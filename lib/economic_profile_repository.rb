require_relative "economic_profile"
require "csv"
require "pry"

class EconomicProfileRepository

  attr_reader :economic_profile

  def initialize(economic_profile = {})
    @economic_profile = economic_profile
  end

  def load_data(data)
    stored_data = {}
    data[:economic_profile].each do |title, file_path|
      CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
        name = row[:location].upcase
        dataformat = row[:dataformat]
        data = row[:data].to_f
        timeframe = row[:timeframe]

        if title == :free_or_reduced_price_lunch
          if dataformat == "Percent"
            percentage = data.to_f
          elsif  dataformat == "Number"
            total = data.to_i
          end
        end

        if title == :median_household_income
          if dataformat == "Currency"
            total = data.to_i
            years = timeframe.split("-").map { |num| num.to_i }
            income = data.to_i
          else
            years = timeframe.to_i
            percentage = data.to_f
          end
        end

        if title == :free_or_reduced_price_lunch
          lunch_parsed_data(stored_data, name, title, years, percentage, total, dataformat)
        elsif title == :median_household_income
          additional_parser(stored_data, name, title, years, income)
        else title == :children_in_poverty || :title_i
          additional_parser(stored_data, name, title, years, percentage)
        end
      end
    end
  end

  def additional_parser(stored_data, name, title, years, income)
    if stored_data.has_key?(name)
      if stored_data[name].has_key?(title)
        if stored_data[name][title].has_key?(years)
          stored_data[name][title][years] = percentage
        else
          stored_data[name][year] = {title => percentage}
        end
      else
        stored_data[name] = {year => {title => percentage}}
      end
    end
  end

  def lunch_parsed_data(stored_data, name, title, years, percentage, total, dataformat)
    if stored_data.has_key?(name)
      if stored_data[name].has_key?(title)
        if stored_data[name][title].has_key?(years)
          stored_data[name][title][years] = percentage
        else
          stored_data[name][years] = {title => percentage}
        end
      else
        stored_data[name] = {years => {title => percentage}}
      end
    end
    create_economic_profile(stored_data)
  end

  def create_economic_profile(data)
    data.each do |name, district_data|
      economic_profile.merge!(name => EconomicProfile.new(district_data))
    end
  end

    def find_by_name(name)
      economic_profile[name.upcase]
    end

end
