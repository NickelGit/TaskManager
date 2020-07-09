require 'simplecov'
require 'coveralls'

SimpleCov.start('rails')
Coveralls.wear!('rails')

ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'
require 'sidekiq/testing'

Sidekiq::Testing.inline!

class ActiveSupport::TestCase
  include ActionMailer::TestHelper
  include AuthHelper
  # Run tests in parallel with specified workers
  parallelize(workers: 1)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  include FactoryBot::Syntax::Methods
end
