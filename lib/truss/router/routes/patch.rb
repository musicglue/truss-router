module Truss
    module Router
        module Routes
            class Patch < Node
                def initialize(path, endpoint, opts={})
                    super(:patch, path, endpoint, opts)
                end
            end
        end
    end
end
