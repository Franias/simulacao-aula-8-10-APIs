require 'allure-rspec'
require 'airborne'
require 'logger'
require_relative '../src/app'
RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end
  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
  config.shared_context_metadata_behavior = :apply_to_host_groups
  config.include AllureRSpec::Adaptor
end

Airborne.configure do |config|
  config.rack_app = Sinatra::Application
end

AllureRSpec.configure do |config|
  config.output_dir = 'log'
  config.clean_dir = true
  config.logging_level = Logger::WARN
end