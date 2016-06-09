require_relative "enrollment"
require "csv"

class EnrollmentRepository

  def initialize(enrollments = [])
    @enrollments = enrollments
  end

  def load_data(file_tree)
    filepath = file_tree[:enrollment][:kindergarten]
    years = CSV.foreach(filepath, headers: true, header_converters: :symbol).map do |row|
      { :name => row[:location], row[:timeframe].to_i => row[:data].to_f}
    end.group_by do |row|
      row[:name]
    end.map do |name, years|
      merged = years.reduce({}, :merge)
      merged.delete(:name)
      { name: name,
        kindergarten_participation: merged }
      end.each do |object|
        @enrollments << Enrollment.new(object)
      end
  end

  def find_by_name(name)
    @enrollments.detect do |enrollment|
      enrollment.data[:name] == name
    end
  end
end
