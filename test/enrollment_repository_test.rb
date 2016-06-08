require_relative "test_helper"
require "./lib/enrollment_repository"

class EnrollmentRepositoryTest < Minitest::Test

  def test_things
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
end
