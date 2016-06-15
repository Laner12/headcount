require './test/test_helper'
require './lib/statewide_test'


class StatewideTestTest < Minitest::Test

  def test_contains_names
    statewide_class = StatewideTest.new({name: "Academy 20"})
    assert_equal "ACADEMY 20", statewide_class.name
  end

  def test_proficient_by_grade
    statewide_class = StatewideTest.new({name: "Academy 20", 3 => {2008 => { :math => 0.857, :reading => 0.866, :writing => 0.671}}})
    result = {2008 => { :math => 0.857, :reading => 0.866, :writing => 0.671}}
    assert_equal result, statewide_class.proficient_by_grade(3)
    assert_raises UnknownDataError do
      statewide_class.proficient_by_grade(6)
    end
  end

  def test_proficient_by_race_or_ethnicity
    statewide_class = StatewideTest.new({name: "Academy 20", :pacific_islander => {2008 => { :math => 0.857, :reading => 0.866, :writing => 0.671}}})
    result = {2008 => { :math => 0.857, :reading => 0.866, :writing => 0.671}}
    assert_equal result, statewide_class.proficient_by_race_or_ethnicity(:pacific_islander)
    assert_raises UnknownRaceError do
      statewide_class.proficient_by_race_or_ethnicity(:martian)
    end
  end

  def test_proficient_for_subject_by_grade_in_year
    statewide_class = StatewideTest.new({name: "Academy 20", 3 => {2008 => { :math => 0.857, :reading => 0.866, :writing => 0.671}}})
    assert_equal 0.857, statewide_class.proficient_for_subject_by_grade_in_year(:math, 3, 2008)
    assert_raises UnknownDataError do
      statewide_class.proficient_for_subject_by_grade_in_year(:music, 3, 2008)
    end
    assert_raises UnknownDataError do
      statewide_class.proficient_for_subject_by_grade_in_year(:math, 6, 2008)
    end
  end

  def test_proficient_for_subject_by_race_in_year
    statewide_class = StatewideTest.new({name: "Academy 20", :pacific_islander => {2008 => { :math => 0.857, :reading => 0.866, :writing => 0.671}}})
    result = {2008 => { :math => 0.857, :reading => 0.866, :writing => 0.671}}
    assert_equal 0.857, statewide_class.proficient_for_subject_by_race_in_year(:math, :pacific_islander, 2008)
    assert_raises UnknownRaceError do
      statewide_class.proficient_for_subject_by_race_in_year(:science, :pacific_islander, 2008)
    end
    assert_raise_with_message UnknownRaceError do
      statewide_class.proficient_for_subject_by_race_in_year(:math, :martian, 2008)
    end
  end
end
