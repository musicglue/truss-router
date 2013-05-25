module Truss
    module Router
        class Node
            attr_accessor :request_method, :path, :endpoint
            def initialize(meth, path, endpoint, opts={})
                @request_method, @path, @endpoint = meth, path, endpoint
                @opts = opts
            end

            def matches?
            end
        end
    end
end
