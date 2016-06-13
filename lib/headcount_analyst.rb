require_relative "district_repository"
require_relative "truncate"

class HeadcountAnalyst
  attr_reader :dr,
              :results
  def initialize(district_repository)
    @dr = district_repository
    @results = []
  end

  def find(name)
    dr.find_by_name(name)
  end

  def kinder_years(dist_name)
    dist_name.enrollment.data[:kindergarten_participation]
  end

  def kinder_participation(dist_name)
    dist_name.enrollment.data[:kindergarten_participation].values.reduce(:+)
  end

  def high_years(dist_name)
    dist_name.enrollment.data[:high_school_graduation]
  end

  def high_participation(dist_name)
    dist_name.enrollment.data[:high_school_graduation].values.reduce(:+)
  end

  def average(participation, years)
    participation / years
  end

  def kindergarten_participation_rate_variation(first_dist, second_dist)
    averages = [first_dist, second_dist[:against]].map do |dist|
      dist_name = find(dist)
      dist_years = kinder_years(dist_name).length
      dist_participation = kinder_participation(dist_name)
      average(dist_participation, dist_years)
    end
    Truncate.truncate_float(averages[0] / averages[1])
  end

  def kindergarten_participation_rate_variation_trend(first_dist, second_dist)
    year_collection = [first_dist, second_dist[:against]].map do |dist|
      dist_name = find(dist)
      kinder_years(dist_name)
    end
    year_collection[0].merge!(year_collection[1]) do |key , key_one, key_two|
    Truncate.truncate_float(key_one / key_two)
    end
  end

  def kindergarten_participation_against_high_school_graduation(district)
    name = find(district)
    kinder = average(kinder_participation(name), kinder_years(name).length)
    high = average(high_participation(name), high_years(name).length)

      Truncate.truncate_float(kinder / high)

      # name = find(district)
      # k_p = kinder_participation(name)
      # k_y = kinder_years(name).length
      # kinder = average(k_p, k_y)
      # h_p = high_participation(name)
      # h_y = high_years(name).length
      # high = average(h_p, h_y)
      #   Truncate.truncate_float(kinder / high)
  end

  def kindergarten_participation_correlates_with_high_school_graduation(district)
    # name = find(district[:for])
    name = district
    binding.pry
    value = kindergarten_participation_against_high_school_graduation(name)
    if value >= 0.6 && value <= 1.5
      true
    else
      false
    end
  end

  # def kindergarten_participation_correlates_with_high_school_graduation(district)
  #   binding.pry
  #   if district.keys.first == :for
  #       district[:for]
  #   elsif district.keys.first == :across
  #     district = district[:across]
  #   else
  #     district = district
  #   end
  #   if district.is_a?(Array)
  #     return statewide_comparison(district)
  #     elsif district != "STATEWIDE"
  #       return correlation(district)
  #     elsif district == "STATEWIDE"
  #       return statewide_comparison
  #     else
  #       correlation(district)
  #   end
  # end
  #
  # def correlation(district)
  #   correlation = kindergarten_participation_against_high_school_graduation(district)
  #   correlated?(correlation)
  # end
  #
  # def correlated?(correlation)
  #   # true if correlation >= 0.6 && correlation <= 1.5
  #   if correlation >= 0.6 && correlation <= 1.5
  #      correlation = true
  #    else
  #      correlation = false
  #   end
  # end
  #
  # def statewide_comparison(districts = nil)
  #   district_names = dr.collect_district_names
  #   if districts.nil?
  #     names = district_names
  #   else
  #     names = districts
  #   end
  #   names.map do |district_name|
  #     if district_name != "COLORADO"
  #       #results needs to be an array
  #       @results << kindergarten_participation_correlates_with_high_school_graduation(district_name)
  #     end
  #   end
  #   total = results.count
  #   counter = 0
  #   results.each { |result| counter += 1 if result == true }
  #   percentage = truncate_float(counter/ total.to_f)
  #   percentage >= 0.7 ? true : false
  # end
end
