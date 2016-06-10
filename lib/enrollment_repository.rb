require_relative "enrollment"
require "csv"

class EnrollmentRepository

  def initialize(enrollments = [])
    @enrollments = enrollments
  end

  def load_data(file_path)
    data = []
     file_path[:enrollment].each_key do |key|
      path = file_path[:enrollment][key]
      data << CSV.foreach(path, headers: true, header_converters: :symbol).map do |row|
        { :name => row[:location].upcase, row[:timeframe].to_i => row[:data].to_f }
      end
      data
      # binding.pry
    end
    # needs to be dynamic
    # needs to load all the values of enrollment

    data_by_row = data.group_by do |row|
      row[:name]
    end

    parsed_data = data_by_row.map do |name, years|
      merged = years.reduce({}, :merge)
      merged.delete(:name)
      { name: name,
        kindergarten_participation: merged }
        # needs to be dynamic
      end

      parsed_data.each do |object|
        @enrollments << Enrollment.new(object)
      end
  end

  def find_by_name(name)
    @enrollments.detect do |enrollment|
      enrollment.data[:name] == name
    end
  end
end
