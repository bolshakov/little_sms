require 'test/unit'
require 'shoulda'
require_relative '../lib/little_sms'

class LittleSMSTest < Test::Unit::TestCase
  context "A LittleSMS" do
    def setup
      @api_user = :testapiuser
      @api_key = :testapikeystring
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
      api = LittleSMS.new(:"acc-4fe53b2b", :"OZkgGZ7g")
      resp = api.message.send(:recipients => "+79213752462", :message => "Test", :test => "1")
      assert_equal(resp.success?, true)
    end
  end
end

