require 'test/unit'
require 'shoulda'
require 'lib/little_sms'

class ComponentTest < Test::Unit::TestCase
  context "A LittleSMS::Component" do
    def setup
      @options = {:message=>"sos", :recipients=>"112", :user=>'free', :key=>'Jesus'}
      @options.extend(LittleSMS::Component::Options)
      @options.method_path = {:method => :send, :component => :message }
    end

    should "should sign request" do
      component = LittleSMS::Component.new(:message, "Christ", "Jesus")
      sign = component.method(:sign_request).call(@options)
      assert_equal "9ee9ac110901dae9ee9f97fde09f3268", sign
    end
  end
end

