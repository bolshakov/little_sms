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
  end
end

