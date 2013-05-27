module Truss
    module Router
        class Node
            attr_accessor :request_method, :path, :has_dynamic_segments, 
                          :endpoint, :matchable_regex, :options, :allowed_methods,
                          :path_segments
            
            def initialize(method, path, endpoint, options={})
                @request_method, @path, @endpoint = method, path, endpoint
                @has_dynamic_segments = false
                @matchable_regex = build_matchable_regex(method, path, options)
                @allowed_methods = discover_allowed_methods(method, path, options)
                @path_segments   = get_path_segments(path)
                @options = options
            end

            def matches? request
                if has_dynamic_segments
                    match = matchable_regex.match(request.routing_path)
                    if match
                        request.routing_params = Hash[match.names.zip(match.captures)]
                    end
                    match
                else
                    matchable_regex.match(request.routing_path)
                end
            end

            def call request
                endpoint.call(request)
            end

            private
            def build_matchable_regex(method, path, options)
                if path.include?(":")
                    self.has_dynamic_segments = true
                    /\A#{segment_string(path)}\Z/
                else
                    %r[\A#{path}\Z]
                end
            end

            def discover_allowed_methods(method, path, options)
                allowed = [method.to_s.upcase]
                allowed << "OPTIONS" if options.has_key?(:cors)
                allowed << "HEAD" if (method == :get)
                allowed
            end

            def get_path_segments(path)
                path.split("/").reject(&:empty?).count
            end
                    
            def segment_string(path)
                components = path.split("/").map do |comp|
                    if comp[0] == ":"
                        "(?<#{comp[1..-1]}>[\\w\\-]+)"
                    else
                        comp
                    end
                end
                "#{components.join('/')}"
            end
        end
    end
end
