module Truss
    module Router
        class Routeset
   
            attr_accessor :nodes
            def initialize(nodes=[])
                @nodes = nodes
            end

            def add_node(node)
                @nodes << node
            end

            def <<(node)
                @nodes << node
            end

            def [](node)
                @nodes[node]
            end

            def length
                @nodes.length
            end

            def find_route request
                @nodes.detect do |node|
                    node.matches?(request)
                end
            end
        end
    end
end
