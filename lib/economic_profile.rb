require_relative "truncate"
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
    data[:median_household_income][year]
  end
end
