require 'test/unit'
require 'shoulda'
require 'lib/little_sms'

class ComponentTest < Test::Unit::TestCase
  context "A LittleSMS::Component" do
    def setup
      @options = {:user=>:foo, :baz=>:bazz, :key=>:bar}
    end

    should "should sign request" do
      component = LittleSMS::Component.new(:noname, @options[:user], @options[:key])
      sign = component.method(:sign_request).call(@options)
      assert_equal "1c971171ab417c41c75d34e001c86403", sign
    end
  end
end

