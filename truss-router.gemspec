# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'truss/router/version'

Gem::Specification.new do |spec|
  spec.name          = "truss-router"
  spec.version       = Truss::Router::VERSION
  spec.authors       = ["John Maxwell"]
  spec.email         = ["john@musicglue.com"]
  spec.description   = %q{Truss Router is a modular Rack Router for Truss}
  spec.summary       = %q{Truss Router is a modular Rack Router for Truss}
  spec.homepage      = "http://truss-io.github.io"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"

  spec.add_dependency "rack", "~> 1.5.0"
end
