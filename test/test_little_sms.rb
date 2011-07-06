require File.expand_path(File.dirname(__FILE__) + '/helper')

class LittleSMSTest < Test::Unit::TestCase
  include Auth
  context "A LittleSMS" do
    def setup
      @api_user, @api_key = self.auth
      @sms = LittleSMS.new @api_user, @api_key
    end

    should "create Component for unknown method" do
      @sms.foo
      assert_equal(@sms.instance_eval { @components[:foo].class }, LittleSMS::Component)
    end

    should "accept block" do
      mes = nil
      LittleSMS.new @api_user, @api_key do
        mes = message
      end
      assert_equal(LittleSMS::Component, mes.class)
    end

    should "send message" do
      api = LittleSMS.new(@api_user, @api_key)
      resp = api.message.send(:recipients => "+79213752462", :message => "Test", :test => "1")
      assert_equal(resp.success?, true)
    end
  end
end

