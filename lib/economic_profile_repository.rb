
require_relative "economic_profile"
require "csv"

class EconomicProfileRepository
  attr_reader :economic_profile,
              :data_sets

  def initialize(economic_profile = {})
    @economic_profile = economic_profile
    @data_sets =  {
      :median_household_income => :median_household_income,
      :children_in_poverty => :children_in_poverty,
      :free_or_reduced_price_lunch => :free_or_reduced_price_lunch,
      :title_i => :title_i
      }
  end

  def load_data(file_path)
    file_path.values[0].values.each_with_index do |key, index|
      CSV.foreach(key, headers: true, header_converters: :symbol) do |row|
        title = data_sets[file_path.values[0].keys[index]]
        data = path_to_parsing(title, row)
        name = data[:name]
        check_objects = find_by_name(name)
        if check_objects == nil
          @economic_profile[name.upcase] = EconomicProfile.new(data)
        else
          add_data(check_objects, title, data)
        end
      end
    end
  end

  def path_to_parsing(title, row)
    if title == :median_household_income || title == :title_i
      name, year, value = parse_row(title, row)
      { :name => name, title => {year => value}}
    elsif title == :children_in_poverty
      name, year, value = parse_row(title, row)
      { :name => name, title => {year => value}}
    elsif title == :free_or_reduced_price_lunch
      name, year, type, value = parse_row_poverty_and_lunch(title, row)
      { :name => name, title => {year => {type.to_sym => value}}}
    end
  end

  def parse_row(title, row)
    name = row[:location].upcase
    year = row[:timeframe].to_i
     if title == :median_household_income
       year = row[:timeframe].split("-").map { |num| num.to_i }
     end
    value = row[:data].to_f
    [name, year, value]
  end

  def parse_row_poverty_and_lunch(title, row)
    name = row[:location].upcase
    year = row[:timeframe].to_i
    type = row[:dataformat]
    value = row[:data].to_f
    [name, year, type, value]
  end

  def add_data(check_objects, title, data)

  end

  def find_by_name(name)
    @economic_profile[name.upcase]
  end
end
