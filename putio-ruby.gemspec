# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'putio-ruby/version'

Gem::Specification.new do |spec|
  spec.name          = "putio-ruby"
  spec.version       = Putio::VERSION
  spec.authors       = ["Brandon Bloxsom"]
  spec.email         = ["bloxsom@umich.edu"]

  spec.summary       = 'A simple library for communicating with the Put.io REST API'
  spec.description   = 'A simple library for communicating with the Put.io REST API'
  spec.homepage      = "https://github.com/bloxsom/putio-ruby"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.8"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "pry", "~> 0.10"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "webmock", "~> 1.0"
  spec.add_development_dependency "codeclimate-test-reporter", "~> 0.4"

  spec.add_runtime_dependency "faraday", "~> 0.9"
  spec.add_runtime_dependency "faraday_middleware", "~> 0.10"
  spec.add_runtime_dependency "multi_json", "~> 1.7"
  spec.add_runtime_dependency "virtus", "~> 1.0"
end
