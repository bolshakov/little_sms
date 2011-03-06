require 'test/unit'
require 'shoulda'
require 'lib/little_sms'

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
  end
end

