module Truss
    module Router
        module Routes
            class Delete < Node
                def initialize(path, endpoint, opts={})
                    super(:delete, path, endpoint, opts)
                end
            end
        end
    end
end
