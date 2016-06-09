class Enrollment
  attr_reader :data

  def initialize(data)
    @data = data
  end

  def name
    data[:name].upcase
  end

  def kindergarten_participation_by_year
    data[:kindergarten_participation].reduce({}) do |result, pair|
      result.merge({pair.first => truncate_float(pair.last)})
    end
  end

  def truncate_float(float)
    (float * 1000).floor / 1000.to_f
  end

  def kindergarten_participation_in_year(year)
    if data[:kindergarten_participation][year] != nil
      truncate_float(data[:kindergarten_participation][year])
    end
  end
end
