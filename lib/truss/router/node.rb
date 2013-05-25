module Truss
    module Router
        class Node
            attr_accessor :request_method, :path, :endpoint, :matchable_regex, :options
            def initialize(method, path, endpoint, options={})
                @request_method, @path, @endpoint = method, path, endpoint
                @matchable_regex = build_matchable_regex(method, path, options)
                @options = options
            end

            def matches? request
                matchable_regex.match(request.routing_path)
            end

            def call request
                endpoint.call(request)
            end

            private
            def build_matchable_regex(method, path, options)
                %r[\A#{method_group(method)}#{path}\Z]
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
        end
    end
end
