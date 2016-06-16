require "csv"
require "pry"
require_relative "economic_profile"


class EconomicProfileRepository

  attr_reader :economic_profile

  def initialize(economic_profile = {})
    @economic_profile = economic_profile
  end

  def load_data(data)
    stored_data = {}
    data[:economic_profile].each do |title, file_path|

      file = file_path
      contents = CSV.foreach(file, headers: true, header_converters: :symbol) do |row|
        name = row[:location].upcase
        dataformat = row[:dataformat]
        data = row[:data]
        timeframe = row[:timeframe]

        if title == :free_or_reduced_price_lunch
          if dataformat == "Percent"
            percentage = data.to_f
          elsif dataformat == "Number"
            total = data.to_i
          end
        end

        if title == :median_household_income
          years = timeframe.split("-").map { |num| num.to_i }
          income = data.to_i
        else
          year = timeframe.to_i
          percentage  = data.to_f
        end

        if title == :free_or_reduced_price_lunch
          lunch_data_parser(stored_data, name, title, year, percentage, total, dataformat)
        elsif title == :median_household_income
          compile_other_data(stored_data, name, title, years, income)
        elsif title == :title_i || title == :children_in_poverty
          compile_other_data(stored_data, name, title, year, percentage)
        end
      end
    end
    create_economic_profile(stored_data)
  end

  def find_by_name(name)
    economic_profile[name.upcase]
  end

  def create_economic_profile(data)
    data.each do |name, district_data|
      economic_profile.merge!(name => EconomicProfile.new(district_data))
    end
  end

  def compile_other_data(stored_data, name, title, time, stats)
    if stored_data[name] && stored_data[name][title]
      stored_data[name][title][time] = stats
    end
    if stored_data[name] && stored_data[name][title].nil?
      stored_data[name][title] = {time => stats}
    end
    if stored_data[name].nil?
      stored_data[name] = {title => {time => stats}}
    end
  end

  def lunch_data_parser(stored_data, name, title, year, percentage, total, dataformat)
    if stored_data[name] && stored_data[name][title] && stored_data[name][title][year] && dataformat == "Percent"
      stored_data[name][title][year][:percentage] = percentage
    end
    if stored_data[name] && stored_data[name][title] && stored_data[name][title][year] && dataformat == "Number"
      stored_data[name][title][year][:total] = total
    end
    if stored_data[name] && stored_data[name][title] && stored_data[name][title][year].nil?
      stored_data[name][title][year] = {:percentage => percentage, :total => total}
    end
    if stored_data[name] && stored_data[name][title].nil?
      stored_data[name][title] = {year => {:percentage => percentage, :total => total}}
    end
    if stored_data[name].nil?
      stored_data[name] = {title => {year => {:percentage => percentage, :total => total}}}
    end
  end
end
