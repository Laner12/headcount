require_relative "district_repository"
require_relative "truncate"

class HeadcountAnalyst
  attr_reader :dr

  def initialize(district_repository)
    @dr = district_repository
  end

  def find(name)
    dr.find_by_name(name)
  end

  def kinder_data_length(dist_name)
    dist_name.enrollment.data[:kindergarten_participation].length
  end

  def kinder_data_participation(dist_name)
    dist_name.enrollment.data[:kindergarten_participation].values.reduce(:+)
  end

  def average(participation, years)
    participation / years
  end

  def kindergarten_participation_rate_variation(first_dist, second_dist)
    averages = [first_dist, second_dist[:against]].map do |dist|
      dist_name = find(dist)
      dist_years = kinder_data_length(dist_name)
      dist_participation = kinder_data_participation(dist_name)
      average(dist_participation, dist_years)
    end
    Truncate.truncate_float(averages[0] / averages[1])
  end

  def kindergarten_participation_rate_variation_trend(first_district, second_district)
    district_one = dr.find_by_name(first_district)
    district_one_years = district_one.enrollment.data[:kindergarten_participation]

    district_two = dr.find_by_name(second_district[:against])
    district_two_years = district_two.enrollment.data[:kindergarten_participation]

    district_one_years.merge!(district_two_years) do |key , onekey, twokey|
    Truncate.truncate_float(onekey / twokey)
    end
  end

  def kindergarten_participation_against_high_school_graduation(district)
    district_one = dr.find_by_name(district)
    district_one_years = district_one.enrollment.data[:kindergarten_participation].length
    district_one_total_participation = district_one.enrollment.data[:kindergarten_participation].values.reduce(:+)
    district_one_average = district_one_total_participation/district_one_years

    district_two = dr.find_by_name(district)
    district_two_years = district_two.enrollment.data[:high_school_graduation].length
    district_two_total_participation = district_two.enrollment.data[:high_school_graduation].values.reduce(:+)
    district_two_average = district_two_total_participation/district_two_years
    Truncate.truncate_float(district_one_average/ district_two_average)
  end

  # def kindergarten_participation_correlates_with_high_school_graduation(name)
  #   # grab the enrollment data for the named school (kinder) (high)
  #   # then find the percentage overall for both data sets
  #   object = dr.find_by_name(name[:for])
  #   k_years = object.enrollment.data[:kindergarten_participation].length
  #   k_percent = object.enrollment.data[:kindergarten_participation].values.reduce(:+)
  #   k_data = (k_percent / k_years)
  #   h_years = object.enrollment.data[:high_school_graduation].length
  #   h_percent = object.enrollment.data[:high_school_graduation].values.reduce(:+)
  #   h_data = (h_percent / h_years)
  #   final = (k_data / h_data)
  #   final_2 = (h_data / k_data)
  # end

end
