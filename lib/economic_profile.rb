require_relative "errors"
require_relative "truncate"


class EconomicProfile


  attr_reader :information

  def initialize(information)
    @information = information
  end

  def name
    information[:name].upcase
  end

  def median_household_income_in_year(year)
    ranges = information[:median_household_income].keys.reduce({}) do |data, years|
      year_range = [*years[0]..years[1]]
      data[year_range] = information[:median_household_income][years]
      data
    end
    incomes = ranges.keys.reduce([]) do |compiled_incomes, year_range|
      compiled_incomes << ranges[year_range] if year_range.include?(year)
      compiled_incomes
    end
    if incomes.empty?
      raise UnknownDataError
    else
      average_calculator(incomes)
    end
  end

  def median_household_income_average
    average_calculator(information[:median_household_income].values)
  end

  def children_in_poverty_in_year(year)
    if information[:children_in_poverty].keys.include?(year)
      Truncate.truncate_float(information[:children_in_poverty][year])
    else
      raise UnknownDataError
    end
  end

  def free_or_reduced_price_lunch_percentage_in_year(year)
    if information[:free_or_reduced_price_lunch].keys.include?(year)
      Truncate.truncate_float(information[:free_or_reduced_price_lunch][year][:percentage])
    else
      raise UnknownDataError
    end
  end

  def free_or_reduced_price_lunch_number_in_year(year)
    if information[:free_or_reduced_price_lunch].keys.include?(year)
      information[:free_or_reduced_price_lunch][year][:total]
    else
      raise UnknownDataError
    end
  end

  def title_i_in_year(year)
    if information[:title_i].keys.include?(year)
      information[:title_i][year]
    else
      raise UnknownDataError
    end
  end

  def average_calculator(data)
    data.reduce(0, :+) / data.count
  end

end
