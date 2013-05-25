module Truss
    module Router
        module Routes
            class Head < Node
                def initialize(path, endpoint, opts={})
                    super(:head, path, endpoint, opts)
                end
            end
        end
    end
end

