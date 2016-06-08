require_relative "enrollment"
require "pry"

class EnrollmentRepository

  def initialize(enrollments = [])
    @enrollments = enrollments
  end

  def find_by_name(name)
    @enrollments.detect do |enrollment|
      enrollment.data[:name] == name
    end
  end

  def load_data

  end
end

# contents = CSVUpload.contents("./data/Kindergartners in full-day program.csv")
# CSVUpload.updload_kindergartners
