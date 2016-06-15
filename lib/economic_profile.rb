require_relative "truncate"
require "pry"
class EconomicProfile
  attr_reader :data

  def initialize(data)
    @data = data
  end

  def name
    data[:name].upcase
  end

  def median_household_income(input)

  end

  def children_in_poverty(input)

  end

  def free_or_reduced_price_lunch(input)

  end

  def title_i(input)

  end

  def median_household_income_in_year(year)
    # could do a method call that checks the year first
    total = []
    data[:median_household_income].each_key do |key|
      if year.between?(key[0], key[1])
        total << data[:median_household_income][key]
      end
    end
    total.reduce(:+) / total.count
  end

  def median_household_income_average
    (data[:median_household_income].values.reduce(:+))/2
  end

  def children_in_poverty_in_year(year)
    Truncate.truncate_float(data[:children_in_poverty][year])
  end

  def free_or_reduced_price_lunch_percentage_in_year(year)
    value = data[:free_or_reduced_price_lunch][year][:percentage]
    Truncate.truncate_float(value)
  end

  def free_or_reduced_price_lunch_number_in_year(year)
    data[:free_or_reduced_price_lunch][year][:total]
  end

  def title_i_in_year(year)
    Truncate.truncate_float(data[:title_i][year])
  end
end
