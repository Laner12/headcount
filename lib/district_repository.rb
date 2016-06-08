require_relative "district"
require_relative "enrollment_repository"
require "csv"

class DistrictRepository

  def initialize(districts = [])
    @districts = districts
    @enrollment_repo = EnrollmentRepository.new
  end

  def load_data(file_tree)
    filepath = file_tree[:enrollment][:kindergarten]
    name_lines = CSV.foreach(filepath, headers: true, header_converters: :symbol).map do |row|
      { :name => row[:location]}
    end.uniq
      name_lines.each do |name|
        @districts << District.new(name)
      end
      @enrollment_repo.load_data(file_tree)
  end

  def find_by_name(name)
    @districts.detect do |district|
      district.attributes[:name] == name
    end
  end

  def find_all_matching(fragment)
    @districts.select do |district|
      district.attributes[:name].start_with?(fragment.upcase)
    end
  end
end
