require "require_relative" if RUBY_VERSION.start_with?('1.8')
require 'test/unit'
#require 'shoulda'
require_relative '../lib/little_sms'

module Auth
  def self.included(other)
    other.class_eval do
      def auth
        [:"acc-4fe53b2b", :"OZkgGZ7g"]
      end
    end
  end
end

# https://github.com/sandal/rbp/blob/master/testing/test_unit_extensions.rb
module Test::Unit
  # Used to fix a minor minitest/unit incompatibility in flexmock
  AssertionFailedError = Class.new(StandardError)

  class TestCase

    def self.must(name, &block)
      test_name = "test_#{name.gsub(/\s+/,'_')}".to_sym
      defined = instance_method(test_name) rescue false
      raise "#{test_name} is already defined in #{self}" if defined
      if block_given?
        define_method(test_name, &block)
      else
        define_method(test_name) do
          flunk "No implementation provided for #{name}"
        end
      end
    end

  end
end

