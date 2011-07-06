require "require_relative" if RUBY_VERSION.start_with?('1.8')
require 'test/unit'
require 'shoulda'
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

