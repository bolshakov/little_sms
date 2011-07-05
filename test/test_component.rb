require 'test/unit'
require 'shoulda'
require_relative '../lib/little_sms'

class ComponentTest < Test::Unit::TestCase
  context "A LittleSMS::Component" do
    def setup
      @api_user = :"acc-4fe53b2b"
      @api_key = :"OZkgGZ7g"
      @options = {:message=>"test", :recipients=>"+79213752462", :user=>@api_user, :key=>@api_key}
      @component = LittleSMS::Component.new(:message, "Christ", "Jesus")
    end

    should "should sign request" do
      sign = @component.method(:sign_request).call(@options)
      assert_equal "b616ddc6d0e15aaa92ce79ca78806337", sign
    end

    should "format output" do
      out = {"recipients"=>["911", "112"], "messages_id"=>[], "count"=>1, "parts"=>1, "price"=>0.5, "balance"=>9, "test"=>1, "status"=>"success"}
      formatted = {:recipients=>["911", "112"], :messages_id=>[], :count=>1, :parts=>1, :price=>0.5, :balance=>9, :test=>1, :status=>"success"}
      assert_equal formatted, out.recursive_symbolize_keys
    end

    should "return LittleSMS::Responce object" do
      api = LittleSMS.new(@api_user, @api_key)
      resp = api.message.send(:recipients => "+79213752462", :message => "Test", :test => "1")
      assert_equal(resp.class, LittleSMS::Responce)
    end
  end
end

