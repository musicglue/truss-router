require "truss/router/version"
require "truss/router/node"
require "truss/router/routes"
require "truss/router/routeset"
require "truss/router/request"

module Truss
    module Router
        extend self
        def draw(&block)
            raise ArgumentError unless block_given?
            block.call(self)
        end

        def routeset
            @routeset ||= Truss::Router::Routeset.new
        end

        def get(path, endpoint, opts={})
            build_node :Get, path, endpoint, opts
        end

        def post(path, endpoint, opts={})
            build_node :Post, path, endpoint, opts
        end

        def options(path, endpoint, opts={})
            build_node :Options, path, endpoint, opts
        end

        def head(path, endpoint, opts={})
            build_node :Head, path, endpoint, opts
        end

        def put(path, endpoint, opts={})
            build_node :Put, path, endpoint, opts
        end

        def patch(path, endpoint, opts={})
            build_node :Patch, path, endpoint, opts
        end

        def delete(path, endpoint, opts={})
            build_node :Delete, path, endpoint, opts
        end

        def reset!
            @routeset = Truss::Router::Routeset.new
        end

        def call env
            request = Request.new(env.dup)
            route = routeset.find_route(request)   
            if route
                route.call(request)
            else
                [404, {'Content-Type' => 'text/plain'}, ["Not Found"]]
            end
        end

        protected
        def build_node method, path, endpoint, opts
            routeset << Routes.const_get(method).new(path, endpoint, opts)
        end
    end
end
