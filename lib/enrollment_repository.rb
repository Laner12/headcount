require_relative "enrollment"

class EnrollmentRepository

  def initialize(enrollments = [])
    @enrollments = enrollments
  end

  def find_by_name(name)
    @enrollments.detect do |enrollment|
      enrollment.attributes[:name] == name
    end
  end
end
