require_relative "truncate"

class Enrollment
  attr_reader :data,
              :name

  def initialize(data)
    @data = data
    @name = data[:name].upcase
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
end
