require 'rack'
require 'http_router'
require 'usher'
require 'benchmark'
$:.unshift File.expand_path("../../lib", __FILE__)
require File.expand_path("../../lib/truss-router", __FILE__)

REQUEST = Rack::MockRequest.env_for("/home", method: "GET")
APP     = ->(env){ [200, {'Content-Type' => 'text/plain'}, ["Hello World"]] }
TIMES   = 50_000

puts "Running with a single route\n\n"

h = HttpRouter.new
h.add('/home').to(APP)

r = Usher::Interface.for(:rack) do
    add('/home').to(APP)
end

Truss::Router.draw do |r|
    r.get('/home', APP)
end

Benchmark.bmbm(12) do |x|
    x.report("HTTP Router")     { TIMES.times { h.call(REQUEST) } }
    x.report("Usher Router")    { TIMES.times { r.call(REQUEST) } }
    x.report("Truss Router")    { TIMES.times { Truss::Router.call(REQUEST) } }
end

puts "\n\nRunning with 10 routes\n\n"
BLOG_POST_REQ = Rack::MockRequest.env_for("/blog/posts/9", method: "GET")

a = HttpRouter.new
a.get('/home').to(APP)
a.get('/news').to(APP)
a.get('/articles/:id').to(APP)
a.get('/staff/:name').to(APP)
a.get('/contact-us').to(APP)
a.get('/about-us').to(APP)
a.post('/login').to(APP)
a.delete('/logout').to(APP)
a.get('/blog').to(APP)
a.get('/blog/posts/:id').to(APP)

routes = Usher::Interface.for(:rack) do
    add('/home').to(APP)
    add('/news').to(APP)
    add('/articles/:id').to(APP)
    add('/staff/:name').to(APP)
    add('/contact-us').to(APP)
    add('/about-us').to(APP)
    add('/login').to(APP)
    add('/logout').to(APP)
    add('/blog').to(APP)
    add('/blog/posts/:id').to(APP)
end

Truss::Router.reset!
Truss::Router.draw do |r|
    r.get("/home", APP)
    r.get("/news", APP)
    r.get("/articles/:id", APP)
    r.get("/staff/:name", APP)
    r.get("/contact-us", APP)
    r.get("/about-us", APP)
    r.post("/login", APP)
    r.delete("/logout", APP)
    r.get("/blog", APP)
    r.get("/blog/posts/:id", APP)
end

Benchmark.bmbm(12) do |x|
    x.report("HTTP Router")     { TIMES.times { a.call(BLOG_POST_REQ) } }
    x.report("Usher Router")    { TIMES.times { routes.call(BLOG_POST_REQ) } }
    x.report("Truss Router")    { TIMES.times { Truss::Router.call(BLOG_POST_REQ) } }
end
