require 'test/unit'
require 'shoulda'
require_relative '../lib/little_sms'

class ComponentTest < Test::Unit::TestCase
  context "A LittleSMS::Component" do
    def setup
      @options = {:message=>"sos", :recipients=>"112", :user=>'free', :key=>'Jesus'}
      @component = LittleSMS::Component.new(:message, "Christ", "Jesus")
    end

    should "should sign request" do
      sign = @component.method(:sign_request).call(@options)
      assert_equal "09e833ee103f3d274fa97b12a1d19cee", sign
    end

    should "format output" do
      out = {"recipients"=>["911", "112"], "messages_id"=>[], "count"=>1, "parts"=>1, "price"=>0.5, "balance"=>9, "test"=>1, "status"=>"success"}
      formatted = {:recipients=>["911", "112"], :messages_id=>[], :count=>1, :parts=>1, :price=>0.5, :balance=>9, :test=>1, :status=>"success"}
      assert_equal formatted, out.recursive_symbolize_keys
    end
  end
end

