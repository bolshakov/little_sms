require File.expand_path(File.dirname(__FILE__) + '/helper')

class ComponentTest < Test::Unit::TestCase
  include Auth
  def setup
    @api_user, @api_key = self.auth
  end

  must "sign request" do
    options = {:message=>"test", :recipients=>"+79213752462"}
    component = LittleSMS::Component.new(:message, @api_user, @api_key)
    sign = component.method(:sign_request).call(options)
    assert_equal "da7a3ceb9f29874825b7451d40117adb", sign
  end

  must "format output" do
    out = {"recipients"=>["911", "112"], "messages_id"=>[], "count"=>1, "parts"=>1, "price"=>0.5, "balance"=>9, "test"=>1, "status"=>"success"}
    formatted = {:recipients=>["911", "112"], :messages_id=>[], :count=>1, :parts=>1, :price=>0.5, :balance=>9, :test=>1, :status=>"success"}
    assert_equal formatted, out.symbolize_keys
  end

  must "return LittleSMS::Responce object" do
    api = LittleSMS.new(@api_user, @api_key)
    resp = api.message.send(:recipients => "+79213752462", :message => "Test", :test => "1")
    assert_equal(resp.class, LittleSMS::Responce)
  end
end

