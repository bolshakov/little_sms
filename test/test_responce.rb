require "test/unit"
require "shoulda"
require_relative "../lib/little_sms/responce"

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
  end
end

