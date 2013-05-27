module Truss
    module Router
        class Request < Rack::Request
            attr_accessor :routing_params
            
            def initialize(*args)
                @routing_params = {}
                super(*args)
            end

            def routing_path; path end

            def segment_length
                @seglength ||= path.split("/").reject(&:empty?).count
            end
        end
    end
end
