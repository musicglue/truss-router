[![Build Status](https://travis-ci.org/truss-io/router.png)](https://travis-ci.org/truss-io/router)
# Truss Router

Truss Router is the first released part of Truss - a new wrapper around Rack to make writing performant Ruby web endpoints easier.
Truss Router is currently considered alpha software, and as such please don't use in any production environment, but feel free to
explore and see how it handles for you.

Truss supports the following Ruby platforms in Pure Ruby:

* MRI 1.9.3
* MRI 2.0.0
* JRuby 1.7
* RBX 1.9 mode

## Installation

Add this line to your application's Gemfile:

    gem 'truss-router'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install truss-router

## Usage

Truss Router admires Journey, although doesn't fancy doing all the hard work that it does. With that in mind, it offers a nice DSL
and some pleasant features, but doesn't currently support things like namespaces or constraints. To be honest, at this 0.0.2 release
it doesn't actually support much, but features will come!

So, how do I use it? Basically, just require the gem, and then ```draw``` a map of your routes. Routes are evaluated from top to bottom, so routes at the top of the route block will match and return before routes below them. The route builder takes the following arguments:

1. path, e.g. "/home" (currently only exact matches match, dynamic segments coming soon!)
2. rack app, e.g. ```->(env){[200, {'Content-Type' => 'text/plain'}, ["Hi, I'm a Rack App"]]}```
3. an optional hash of options (currently not used!)

```ruby
require 'truss-router'

Truss::Router.draw do |r|
    r.get("/", HomeApp)
    r.post("/login", LoginApp)
    r.patch("/update", DhhApp)
    r.delete("/goodbye", RemoveThisApp)
end
```

Finally, you can then run the Truss Router as a rack app:

```ruby
run Truss::Router
```

## Benchmarks

Truss Router aims to be a highly performant routing solution for your Rack apps, whilst giving you a nicer DSL than some of the
inbuilt rack types (Cascade/URLMap), and a little bit of Rails Magic, such as param matching and simple binding of different
request methods to different endpoints on the same path.

Having said that, there isn't much point in having candy if it makes it slow. HTTP Router inspired me to include benchmarks within
the repo that make it easy to check how performant the solution is. I'll include the current benchmark output in the wiki for each
supported platform ([1.9.3](https://github.com/truss-io/router/wiki/Benchmarks-MRI-1.9.3) / [2.0.0](https://github.com/truss-io/router/wiki/Benchmarks-MRI-2.0.0) / [JRuby1.7](https://github.com/truss-io/router/wiki/Benchmarks-JRuby) / [RBX](https://github.com/truss-io/router/wiki/Benchmarks-RBX)) and update with each release to keep things current.

Currently, 2.0.0 is by far the slowest, which is somewhat curious - I had expected it to lose to JRuby and possibly RBX but not to
MRI 1.9.3, which is worth investigating.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
