module Truss
    module Router
        class Request < Rack::Request
            attr_accessor :routing_params
            
            def initialize(*args)
                @routing_params = {}
                super(*args)
            end

            def routing_path
                "#{request_method}#{path}"
            end
        end
    end
end
