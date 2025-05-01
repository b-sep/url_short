# frozen_string_literal: true

ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'database_cleaner/mongoid'
require 'minitest/mock'
require 'rails/test_help'

DatabaseCleaner.strategy = :deletion

module ActiveSupport
  class TestCase
    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

    # Add more helper methods to be used by all tests here...
    def setup = DatabaseCleaner.start
    def teardown = DatabaseCleaner.clean
  end
end

require 'mocha/minitest'
