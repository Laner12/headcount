require "pry"
require "csv"
require_relative "district"

class DistrictRepository

  def initialize(districts = [])
    @districts = districts
  end

  def load_data(file_tree)
    filepath = file_tree[:enrollment][:kindergarten]
    name = CSV.foreach(filepath, headers: true, header_converters: :symbol).map do |row|
      { :name => row[:location], row[:timeframe].to_i => row[:data].to_f}
    end.group_by do |row|
      row[:name]
    end.map do |name, years|
      merged = years.reduce({}, :merge)
      merged.delete(:timeframe)
      { name: name,
        kindergarten_participation: merged }
      end.each do |e|
        @districts << District.new(e)
      end
  end

  def find_by_name(name)
    @districts.detect do |district|
      district.attributes[:name] == name
    end
  end
end
