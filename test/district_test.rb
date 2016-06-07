require_relative "test_helper"
require "./lib/district"

class DistrictTest < Minitest::Test

  def test_it_returns_name
    d1 = District.new({:name => "ACADEMY 20"})
    d2 = District.new({:name => "ACADEMY 30"})

    assert_equal "ACADEMY 20", d1.name
    assert_equal "ACADEMY 30", d2.name
    refute_equal "ACADEMY 30", d1.name
  end
end
