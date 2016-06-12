require_relative "truncate"

class Enrollment
  attr_reader :data

  def initialize(data)
    @data = data
  end

  def name
    data[:name].upcase
  end
  
  def high_school_graduation
    return data[:high_school_graduation] if high_school_graduation_data_exists?
    data[:high_school_graduation] = Hash.new
  end

  def high_school_graduation_data_exists?
    data.has_key?(:high_school_graduation)
  end

  def kindergarten_participation_by_year
    data[:kindergarten_participation].reduce({}) do |result, pair|
      result.merge({pair.first => Truncate.truncate_float(pair.last)})
    end
  end

  def kindergarten_participation_in_year(year)
    if data[:kindergarten_participation][year] != nil
      Truncate.truncate_float(data[:kindergarten_participation][year])
    end
  end

  def graduation_rate_by_year
    data[:high_school_graduation].reduce({}) do |result, pair|
      result.merge({pair.first => Truncate.truncate_float(pair.last)})
    end
  end

  def graduation_rate_in_year(year)
    if data[:high_school_graduation][year] != nil
      Truncate.truncate_float(data[:high_school_graduation][year])
    end
  end

  def kindergarten_participation
    data{:kindergarten_participation}
  end
end
