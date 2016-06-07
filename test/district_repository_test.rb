require "./test/test_helper"
require "./lib/district_repository"


class DistrictRepositoryTest < Minitest::Test

  def test_it_reads_in_the_csv
    dr = DistrictRepository.new
    assert_equal 1, dr.file_opener
  end

  # def test_return_district_name
  #   dr = DistrictRepository.new
  #   assert_equal
  # end

end
