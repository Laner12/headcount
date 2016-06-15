require_relative "district"
require_relative "enrollment_repository"
require_relative "statewide_test_repository"
require "csv"

class DistrictRepository
  attr_reader :enrollment_repo,
              :districts

  def initialize(districts = {})
    @districts  = districts
    @enrollment_repo = EnrollmentRepository.new
  end


  def load_data(file_path)
  enrollment_repo.load_data(file_path)
  file = file_path[:enrollment][:kindergarten]
    CSV.foreach(file, headers: true, header_converters: :symbol) do |row|
      name = row[:location].upcase
      data = { :name => name}
      check_objects = find_by_name(name)
      if check_objects == nil
      districts[name] = District.new(data, self)
      end
    end
  end

  def find_by_name(name)
    string = name.to_s
    @districts[string.upcase]
  end

  def find_all_matching(fragment)
    frag = fragment.to_s
    find = @districts.keys.select do |district|
      district.start_with?(frag.upcase)
    end
    find.map do |name|
      find_by_name(name)
    end
  end

  def enrollment_connector(name)
   enrollment_repo.enrollments[name.upcase]
  end

  def collect_district_names
   enrollment_repo.enrollments.keys
  end
end
