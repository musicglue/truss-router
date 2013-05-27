module Truss
    module Router
        class Routeset
   
            attr_accessor :nodes
            def initialize(nodes={})
                @nodes = nodes
                %w[GET HEAD OPTIONS POST PATCH PUT DELETE].each do |req|
                    @nodes[req] ||= []
                end
            end

            def add_node(node)
                node.allowed_methods.each do |req|
                    @nodes[req] << node
                end
            end

            def nodes_for(type)
                nodes[type]
            end

            def total_nodes
                nodes.map{|k,v| v.count}.flatten.inject(:+)
            end

            def find_route request
                req_nodes = nodes_for(request.request_method).select{|n| (n.path_segments == request.segment_length) }
                req_nodes.detect do |node|
                    node.matches?(request)
                end
            end
        end
    end
end
