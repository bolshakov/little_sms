require 'test/unit'
require 'shoulda'
require 'lib/little_sms'

class ComponentTest < Test::Unit::TestCase
  context "A LittleSMS::Component" do
    def setup
      @options = {:message=>"sos", :recipients=>"112", :user=>'free', :key=>'Jesus'}
      @options.extend(LittleSMS::Component::Options)
      @options.method_path = {:method => :send, :component => :message }
      @component = LittleSMS::Component.new(:message, "Christ", "Jesus")
    end

    should "should sign request" do
      sign = @component.method(:sign_request).call(@options)
      assert_equal "9ee9ac110901dae9ee9f97fde09f3268", sign
    end

    should "format output" do
      out = {"recipients"=>["911", "112"], "messages_id"=>[], "count"=>1, "parts"=>1, "price"=>0.5, "balance"=>9, "test"=>1, "status"=>"success"}
      formatted = {:recipients=>["911", "112"], :messages_id=>[], :count=>1, :parts=>1, :price=>0.5, :balance=>9, :test=>1, :status=>"success"}
      assert_equal formatted, out.recursive_symbolize_keys
    end
  end
end

