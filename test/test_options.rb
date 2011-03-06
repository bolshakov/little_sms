require 'test/unit'
require 'shoulda'
require 'lib/little_sms'

class OptionsTest < Test::Unit::TestCase
  context "A Options" do
    def setup
      @order = [:user, :recipients, :message, :sender, :test, :sign, :key]
      @options = {:message=>"sos", :recipients=>"112"}
      @options.extend(LittleSMS::Component::Options)
      @options.method_path = {:method => :send, :component => :message }
    end

    should "load order from file" do
      assert_equal(@order, @options.instance_eval("load_order(:message, :send)"))
    end

    should "sort with loaded order" do
      assert_equal @options.sort, [[:recipients, "112"], [:message, "sos"]]
    end

    should "fail if unknown method called" do
      @options.method_path = {:method => :unknown, :component => :message }
      assert_raise LittleSMS::Component::Options::NoMethodError do
         @options.sort
      end
    end

    should "fail if unknown component accessed" do
      @options.method_path = {:method => :unknown, :component => :unknown }
      assert_raise LittleSMS::Component::Options::NoComponentError do
         @options.sort
      end
    end
  end
end

