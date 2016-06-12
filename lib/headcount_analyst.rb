require_relative "district_repository"
require_relative "truncate"

class HeadcountAnalyst
  attr_reader :dr

  def initialize(district_repository)
    @dr = district_repository
  end

  def kindergarten_participation_rate_variation(first_district, second_district)
    district_one = @dr.find_by_name(first_district)
    district_one_years = district_one.enrollment.data[:kindergarten_participation].length
    district_one_total_participation = district_one.enrollment.data[:kindergarten_participation].values.reduce(:+)
    district_one_average = district_one_total_participation/district_one_years

    district_two = @dr.find_by_name(second_district[:against])
    district_two_years = district_two.enrollment.data[:kindergarten_participation].length
    district_two_total_participation = district_two.enrollment.data[:kindergarten_participation].values.reduce(:+)
    district_two_average = district_two_total_participation/district_two_years
    Truncate.truncate_float(district_one_average/ district_two_average)
  end

  def kindergarten_participation_rate_variation_trend(first_district, second_district)
    district_one = @dr.find_by_name(first_district)
    district_one_years = district_one.enrollment.data[:kindergarten_participation]

    district_two = @dr.find_by_name(second_district[:against])
    district_two_years = district_two.enrollment.data[:kindergarten_participation]

    district_one_years.merge!(district_two_years) do |key , onekey, twokey|
      Truncate.truncate_float(onekey / twokey)
    end
  end
end
