module Truss
    module Router
        module Routes
            class Put < Node
                def initialize(path, endpoint, opts={})
                    super(:put, path, endpoint, opts)
                end
            end
        end
    end
end
