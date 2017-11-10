require "bundler/setup"
require "pg_assistant"

require File.expand_path("../dummy/config/environment", __FILE__)
require 'support/generator_spec_setup'
require 'support/definition_helpers'

RSpec.configure do |config|
  config.order = "random"
  config.include DefinitionHelpers

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
