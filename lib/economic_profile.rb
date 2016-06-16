require_relative "truncate"

class EconomicProfile
  attr_reader :data

  def initialize(data)
    @data = data
  end

  def name
    data[:name].upcase
  end

  def median_household_income_in_year(year)
    collection = []
    data[:median_household_income].each_key do |key|
      if year.between?(key[0], key[1])
        collection << data[:median_household_income][key]
      end
    end
    collection.reduce(:+) / collection.count
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
