require_relative "enrollment"
require "csv"
require "pry"

class EnrollmentRepository
  attr_reader :grade_levels,
              :enrollments

  def initialize(enrollments = {})
    @enrollments  = enrollments
    @grade_levels =  {
      :kindergarten => :kindergarten_participation,
      :high_school_graduation => :high_school_graduation }
  end

  def load_data(file_path)
    file_path.values[0].values.each_with_index do |key, index|
      CSV.foreach(key, headers: true, header_converters: :symbol) do |row|
        grade = grade_levels[file_path.values[0].keys[index]]
        name = row[:location].upcase
        year = row[:timeframe].to_i
        percent = row[:data].to_f
        data = { :name => name, grade => {year => percent}}
        check_objects = find_by_name(name)
        if check_objects == nil
          @enrollments[name.upcase] = Enrollment.new(data)
        else
          add_grade(check_objects, grade, year, percent)
        end
      end
    end
  end

  def add_grade(check_objects, grade, year, percent)
    if grade == :kindergarten_participation
      check_objects.kindergarten_participation.merge!({year => percent})
    else
      check_objects.high_school_graduation.merge!({year => percent})
    end
  end

  def find_by_name(name)
      @enrollments[name.upcase]
  end

end
