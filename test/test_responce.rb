require File.expand_path(File.dirname(__FILE__) + '/helper')

class ResponceTest < Test::Unit::TestCase
  context "A Responce" do
    def setup
      @simple_json = {:foo => "bar"}
      @resp = LittleSMS::Responce.new(@simple_json)
    end

    should "create new responce object" do
      assert_equal(@resp.instance_eval { @json }, @simple_json)
    end

    should "success?" do
      resp = LittleSMS::Responce.new({:status => "success"})
      assert_equal(resp.success?, true)
      assert_equal(resp.error?, false)
    end

    should "error?" do
      resp = LittleSMS::Responce.new({:status => "error"})
      assert_equal(resp.error?, true)
      assert_equal(resp.success?, false)
    end

    should "return error code and message" do
      responce_json = {:status => "error", :error => 2, :message => "invalid signature"}
      resp = LittleSMS::Responce.new(responce_json)
      assert_equal(resp.error, responce_json[:error])
      assert_equal(resp.message, responce_json[:message])
    end

    should "map responce fields to methods" do
      responce_json = {:recipients=>["79213752462"], :price=>0.5, :balance=>0, :test=>1}
      resp = LittleSMS::Responce.new(responce_json)
      assert_equal(resp.price, 0.5)
      assert_equal(resp.balance, 0)
    end

    should "respond to mapped method" do
      assert_respond_to(@resp, :foo)
    end

    should "raise error if unknown methods invoked" do
      resp = LittleSMS::Responce.new({:foo => "foo"})
      assert_raise NoMethodError do
        resp.bar
      end
    end

  end
end

