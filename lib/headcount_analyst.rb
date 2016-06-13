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

  def high_school_graduation_rate_variation(first_dist, second_dist)
    averages = [first_dist, second_dist[:against]].map do |dist|
      dist_name = find(dist)
      dist_years = high_years(dist_name).length
      dist_participation = high_participation(dist_name)
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
    kind = kindergarten_participation_rate_variation(district, :against => 'COLORADO')
    high = high_school_graduation_rate_variation(district, :against => 'COLORADO')
    final = (kind / high)
    Truncate.truncate_nan(final)
  end

  def kindergarten_participation_correlates_with_high_school_graduation(district)
      if district.is_a?(String)
        district = district
      elsif district.keys.first == :for
        district = district[:for]
      elsif district.keys.first == :across
        district = district[:across]
      else
        district = district
      end

      if district.is_a?(Array)
        return comparing_states(district)
      elsif district != "STATEWIDE"
        return correlating(district)
      elsif district == "STATEWIDE"
        return comparing_states
      else
        correlating(district)
      end
  end

  def correlating(district)
    correlating = kindergarten_participation_against_high_school_graduation(district)
    does_it_correlate?(correlating)
  end

  def does_it_correlate?(percent)
    if percent >= 0.6 && percent <= 1.5
      true
    else
      false
    end
  end

  def comparing_states(parsed_districts = nil)
    district_names = dr.collect_district_names
    names_array = []
    if parsed_districts == nil
      names = district_names
    else
      names = parsed_districts
    end
    names.map do |district_name|
      if district_name != "COLORADO"
        names_array << kindergarten_participation_correlates_with_high_school_graduation(district_name)
      end
    end
    total = names_array.count
    matched_district_parameter_counter = 0
    names_array.each { |result| matched_district_parameter_counter += 1 if result == true }
    percentage = Truncate.truncate_nan(matched_district_parameter_counter/ total.to_f)
    if percentage >= 0.70
      true
    else
      false
    end
  end
end
