# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mccabe/version'

Gem::Specification.new do |spec|
  spec.name          = "mccabe"
  spec.version       = McCabe::VERSION
  spec.authors       = ["Andrew Mason"]
  spec.email         = ["mason@case.edu"]

  spec.summary       = %q{TODO: Write a short summary, because Rubygems requires one.}
  spec.description   = %q{TODO: Write a longer description or delete this line.}
  spec.homepage      = "https://github.com/ajm188/mccabe"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.executables   = ['mccabe']
  spec.require_paths = ["lib"]

  spec.add_dependency 'parser'

  spec.add_development_dependency "bundler", "~> 1.9"
  spec.add_development_dependency "rake", "~> 10.0"
end
