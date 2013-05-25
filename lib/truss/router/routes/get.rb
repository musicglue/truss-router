module Truss
    module Router
        module Routes
            class Get < Node
                def initialize(path, endpoint, opts={})
                    super(:get, path, endpoint, opts)
                end
            end
        end
    end
end
