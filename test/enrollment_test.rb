require_relative "../lib/enrollment"
require_relative "test_helper"

class EnrollmentTest < Minitest::Test

  def test_returning_data_by_year_in_percentage
    e = Enrollment.new({:name => "ACADEMY 20",
                        :kindergarten_participation =>
                        {2010 => 0.3915, 2011 => 0.35356, 2012 => 0.2677}})
    result = {
              2010 => 0.391,
              2011 => 0.353,
              2012 => 0.267}

    assert_equal result, e.kindergarten_participation_by_year
  end

  def  test_method_can_return_zero_percent
    e = Enrollment.new({:name => "ACADEMY 20",
                        :kindergarten_participation => {2010 => 0}})

    assert_equal ({2010=>0.0}), e.kindergarten_participation_by_year
  end

  def test_returning_data_year_for_certain_year
    e = Enrollment.new({:name => "ACADEMY 20",
                        :kindergarten_participation =>
                        {2010 => 0.3915, 2011 => 0.35356, 2012 => 0.2677}})
    return_value = e.kindergarten_participation_in_year(2010)

    assert_equal 0.391, return_value
  end

  def test_whether_we_have_data_before_2000
    e = Enrollment.new({:name => "ACADEMY 20",
                        :kindergarten_participation =>
                        {2010 => 0.3915, 2011 => 0.35356, 2012 => 0.2677}})
    return_value = e.kindergarten_participation_in_year(2000)

    assert_equal nil, return_value
  end

  def test_name_method_for_instance_of_enrollment
    e = Enrollment.new({:name => "ACADEMY 20"})

    assert_equal "ACADEMY 20", e.name
  end

end
