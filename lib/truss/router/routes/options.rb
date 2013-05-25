module Truss
    module Router
        module Routes
            class Options < Node
                def initialize(path, endpoint, opts={})
                    super(:options, path, endpoint, opts)
                end
            end
        end
    end
end

