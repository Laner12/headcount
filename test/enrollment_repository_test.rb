require_relative "test_helper"
require "./lib/enrollment_repository"

class EnrollmentRepositoryTest

  def test_searching_for_a_name_in_enrollment
    e1 = Enrollment.new({:name => "ACADEMY 20"})
    e2 = Enrollment.new({:name => "ACADEMY 30"})
    e3 = Enrollment.new({:name => "ADAMS"})

    assert_equal "ADAMS", e3.
  end
end
