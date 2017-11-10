# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "pg_assistant/version"

Gem::Specification.new do |spec|
  spec.name          = "pg_assistant"
  spec.version       = PgAssistant::VERSION
  spec.authors       = ["German Antsiferov"]
  spec.email         = ["dxdy@bk.ru"]

  spec.summary       = %q{Support for database functions in Rails migrations}
  spec.description   = <<-DESCRIPTION
    Adds methods to ActiveRecord::Migration to create and manage database functions in Rails
  DESCRIPTION

  spec.homepage      = "https://github.com/mr-dxdy/pg_assistant.git"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", ">= 1.15"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", ">= 3.3"
  spec.add_development_dependency 'ammeter', '>= 1.1.3'
  spec.add_development_dependency 'pg'
  spec.add_development_dependency 'byebug'

  spec.add_dependency 'activerecord', '>= 4.0.0'
  spec.add_dependency 'railties', '>= 4.0.0'

  spec.required_ruby_version = '~> 2.1'
end
