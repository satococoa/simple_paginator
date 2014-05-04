# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'simple_paginator/version'

Gem::Specification.new do |spec|
  spec.name          = "simple_paginator"
  spec.version       = SimplePaginator::VERSION
  spec.authors       = ["Satoshi Ebisawa"]
  spec.email         = ["e.satoshi@gmail.com"]
  spec.description   = %q{Useful paginator library for building APIs.}
  spec.summary       = %q{Useful paginator library for building APIs.}
  spec.homepage      = "https://github.com/satococoa/simple_paginator"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'sqlite3'
  spec.add_dependency 'activerecord'
end
