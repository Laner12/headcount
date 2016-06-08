require_relative "test_helper"
require "./lib/district_repository"


class DistrictRepositoryTest < Minitest::Test

  def test_it_passes_
    dr = DistrictRepository.new
    dr.load_data({
      :enrollment => {
        :kindergarten => "./data/Kindergartners in full-day program.csv"
      }
    })
    district = dr.find_by_name("ACADEMY 20")
    # <District>
    assert_equal "", district
  end

  def test_it_can_find_by_name
    skip
  end
end
