module Truss
    module Router
        module Routes
            class Post < Node
                def initialize(path, endpoint, opts={})
                    super(:post, path, endpoint, opts)
                end
            end
        end
    end
end
