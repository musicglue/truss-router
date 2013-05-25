module Truss
    module Router
        class Request < Rack::Request
            def routing_path
                "#{request_method}#{path}"
            end
        end
    end
end
