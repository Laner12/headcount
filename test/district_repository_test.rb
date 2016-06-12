require_relative "../lib/district_repository"
require_relative "test_helper"

class DistrictRepositoryTest < Minitest::Test

  def test_it_is_an_instance_of_district
    dr = DistrictRepository.new
    dr.load_data({
      :enrollment => {
        :kindergarten => "./data/Kindergartners in full-day program.csv"
      }
    })
    district = dr.find_by_name("ACADEMY 20")

    assert_instance_of District, district
  end

  def test_it_can_find_by_name
    d1 = District.new({:name => "ACADEMY 20"})
    d2 = District.new({:name => "ACADEMY 30"})
    d3 = District.new({:name => "ADAMS"})
    dr = DistrictRepository.new({"ACADEMY 20" => d1,
                                 "ACADEMY 30" => d2,
                                 "ADAMS" => d3 })

    assert_equal d3, dr.find_by_name("ADAMS")
  end

  def test_it_can_find_all_matching
    d1 = District.new({:name => "ACADEMY 20"})
    d2 = District.new({:name => "ACADEMY 30"})
    d3 = District.new({:name => "ADAMS"})
    dr = DistrictRepository.new({"ACADEMY 20" => d1,
                                 "ACADEMY 30" => d2,
                                 "ADAMS" => d3 })

    assert_equal [d1, d2, d3], dr.find_all_matching("a")
  end

  def test_searching_for_a_object_of_district_for_participation_percent
    dr = DistrictRepository.new
    dr.load_data({
      :enrollment => {
        :kindergarten => "./data/Kindergartners in full-day program.csv"
      }
    })
    district = dr.find_by_name("ACADEMY 20")

    assert_equal 0.436, district.enrollment.kindergarten_participation_in_year(2010)
  end
end
