require_relative "district"
require_relative "enrollment_repository"
require "csv"

class DistrictRepository

  attr_reader :enrollment_repo,
              :grade_levels,
              :districts


  def initialize(districts = {})
    @districts       = districts
    @enrollment_repo = EnrollmentRepository.new
  end

  def load_data(file_path)
    @enrollment_repo.load_data(file_path)
    file_path.values[0].values.each_with_index do |key, index|
      CSV.foreach(key, headers: true, header_converters: :symbol) do |row|
        # grade = grade_levels[file_path.values[0].keys[index]]
        name = row[:location].upcase
        data = { :name => name}
          check_objects = find_by_name(name)
        if check_objects == nil
          @districts[name] = District.new(data, enrollment_repo ) #add enrollment_repo
          # binding.pry
        # else
        #   @districts[name] = District.new(data ) #add enrollment_repo
        end
      end
    end
  end
    # .uniq
      # name_lines.each do |object|
      #   enrollment = enrollment_repo.find_by_name(object[:name])
      #   @districts << District.new(object, enrollment)
      # end

  # def add_grade(check_objects)
  #   if grade == :kindergarten_participation
  #     check_objects.kindergarten_participation.merge!({year => percent})
  #   else
  #     check_objects.high_school_graduation.merge!({year => percent})
  #   end
  # end

  def find_by_name(name)
    @districts[name]
  end

  def find_all_matching(fragment)
    find = @districts.keys.select do |district|
      district.start_with?(fragment.upcase)
    end
    find.map do |district|
      @districts[district]

    end
  end
end
