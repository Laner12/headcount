require_relative "../lib/enrollment_repository"
require_relative "test_helper"

class EnrollmentRepositoryTest < Minitest::Test

  def test_it_creates_an_instance_of_enrollment
    skip
    er = EnrollmentRepository.new
    er.load_data({
      :enrollment => {
        :kindergarten => "./data/Kindergartners in full-day program.csv"
      }
    })
    enrollment = er.find_by_name("ACADEMY 20")

    assert_instance_of Enrollment, enrollment
  end

  def test_searching_for_a_name_in_enrollment
    e1 = Enrollment.new({:name => "ACADEMY 20"})
    e2 = Enrollment.new({:name => "ACADEMY 30"})
    e3 = Enrollment.new({:name => "ADAMS"})
    er = EnrollmentRepository.new([e1, e2, e3])

    assert_equal e3, er.find_by_name("ADAMS")
  end

  def test_it_takes_multiple_paths
    er = EnrollmentRepository.new
    er.load_data({
      :enrollment => {
        :kindergarten => "./data/Kindergartners in full-day program.csv",
        :high_school_graduation => "./data/High school graduation rates.csv"
      }
    })
    enrollment = er.find_by_name("ACADEMY 20")
    result ={ 2010 => 0.895,
              2011 => 0.895,
              2012 => 0.889,
              2013 => 0.913,
              2014 => 0.898,
            }

    assert_instance_of result, enrollment.graduation_rate_by_year
  end
end
