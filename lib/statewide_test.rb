class StatewideTest
  attr_reader :data
  def initialize(data)
    @data = data
  end

  def name
    data[:name].upcase
  end

  def proficient_by_grade(grade)
    
  end

  def proficient_by_race_or_ethnicity(race)

  end

  def proficient_for_subject_by_grade_in_year(subject, grade, year)

  end

  def proficient_for_subject_by_race_in_year(subject, race, year)

  end
end
