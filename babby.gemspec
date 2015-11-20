# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'babby/version'

Gem::Specification.new do |spec|
  spec.name          = "babby"
  spec.version       = Babby::VERSION
  spec.authors       = ["Chaz Straney"]
  spec.email         = ["chaz@plaidpotion.com"]

  spec.summary       = %q{Meta-DSL for writing simple inheritance-based DSLs.}
  spec.description   = %q{Meta-DSL for writing simple inheritance-based DSLs.}
  spec.homepage      = "http://www.github.com/chazu/babby/"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
end
