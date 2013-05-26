module Truss
    module Router
        class Node
            attr_accessor :request_method, :path, :has_dynamic_segments, 
                          :endpoint, :matchable_regex, :options
            def initialize(method, path, endpoint, options={})
                @request_method, @path, @endpoint = method, path, endpoint
                @has_dynamic_segments = false 
                @matchable_regex = build_matchable_regex(method, path, options)
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
                    /\A#{method_group(method)}#{segment_string(path)}\Z/
                else
                    %r[\A#{method_group(method)}#{path}\Z]
                end
            end

            def method_group(method)
                origin = case method
                when :get
                    "(GET|HEAD|OPTIONS)"
                when :options
                    "OPTIONS"
                else
                    "(#{method.to_s.upcase}|OPTIONS)"
                end
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
