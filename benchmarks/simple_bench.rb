require 'benchmark'
require 'rack'
require File.expand_path("../../lib/truss-router", __FILE__)

puts "Welcome to Truss Router v#{Truss::Router::VERSION} Benchmark suite. Please wait...\n\n"
app = ->(env) {
    [
        200,
        {'Content-Type' => 'text/plain'},
        ["Hello World"]
    ]
}

TIMES = 50_000
REQUEST = Rack::MockRequest.env_for("/", method: "GET")

Truss::Router.draw do |route|
    route.get("/", app)
end

puts "Benchmarking in progress with 50k iterations, please wait\n\n"

Benchmark.bm(12) do |x|
    x.report("Plain app")    { TIMES.times{ app.call(REQUEST) } }
    x.report("Single route") { TIMES.times { Truss::Router.call(REQUEST) } }
end

puts "\n\nBenchmarking for 2nd preference route with 50k iterations\n\n"

Truss::Router.reset!

app2 = ->(env) {
    [
        200,
        {'Content-Type' => 'text/plain'},
        ["Home Page"]
    ]
}

Truss::Router.draw do |route|
    route.get("/", app)
    route.get("/home", app2)
end

HOME_REQUEST = Rack::MockRequest.env_for("/home", method: "GET")

Benchmark.bm(12) do |x|
    x.report("Plain app")    { TIMES.times{ app.call(REQUEST) } }
    x.report("Single route") { TIMES.times { Truss::Router.call(HOME_REQUEST) } }
end


puts "\n\nBenchmarking 10 route map with 50k iterations, hitting last route\n\n"

Truss::Router.reset!

Truss::Router.draw do |route|
    route.get("/", app)
    route.get("/about", app)
    route.get("/contact", app)
    route.get("/blog", app)
    route.get("/structure", app)
    route.get("/staff", app)
    route.get("/news", app)
    route.get("/log-in", app)
    route.get("/admin", app)
    route.get("/home", app2)
end

Benchmark.bm(10) do |x|
    x.report("Plain app")  { TIMES.times{ app.call(REQUEST) } }
    x.report("Last route") { TIMES.times { Truss::Router.call(HOME_REQUEST) } }
end

