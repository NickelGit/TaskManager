ENV['RAILS_ENV'] ||= 'test'
require 'simplecov'
require 'coveralls'

SimpleCov.start 'rails'
Coveralls.wear!('rails')

require_relative '../config/environment'
require 'rails/test_help'

class ActiveSupport::TestCase
  include AuthHelper
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  include FactoryBot::Syntax::Methods
end
