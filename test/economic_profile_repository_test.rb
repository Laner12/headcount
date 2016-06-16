require_relative "../lib/economic_profile_repository"
require_relative "test_helper"

class EconomicProfileRepositoryTest < Minitest::Test

  def test_it_can_extract_values_parsing_the_row_with_median_household_title
    skip
    title = :median_household_income
    row = {location: "Colorado",
          timeframe: "2005-2009",
          dataformat: "Currency",
          data:"56222"}
    epr = EconomicProfileRepository.new

    assert_equal(["COLORADO", [2005, 2009], 56222.0], epr.parse_row(title, row))
  end

  def test_it_can_extract_values_parsing_the_row_and_returns_types_of_years
    skip
    title = :title_i
    row = {location: "Colorado",
          timeframe: "2009",
          dataformat: "Percent",
          data:"0.216"}
    epr = EconomicProfileRepository.new

    assert_equal(["COLORADO", 2009, 0.216], epr.parse_row(title, row))
  end

  def test_it_can_return_values_from_path_to_parse_for_median_household
    skip
    title = :median_household_income
    row = {location: "Colorado",
          timeframe: "2005-2009",
          dataformat: "Currency",
          data:"56222"}
    epr = EconomicProfileRepository.new

    assert_equal({:name=>"COLORADO", :median_household_income=>{[2005, 2009]=>56222.0}}, epr.path_to_parsing(title, row))
  end

  def test_it_can_return_values_from_path_to_parse_for_title_i
    skip
    title = :title_i
    row = {location: "Colorado",
          timeframe: "2009",
          dataformat: "Percent",
          data:"0.216"}
    epr = EconomicProfileRepository.new

    assert_equal({:name=>"COLORADO", :title_i=>{2009=>0.216}}, epr.path_to_parsing(title, row))
  end

  def test_it_can_return_values_from_path_to_parse_for_poverty
    skip
    title = :children_in_poverty
    row = {location: "Colorado",
          timeframe: "2009",
          dataformat: "Percent",
          data:"0.216"}
    epr = EconomicProfileRepository.new

    assert_equal({:name=>"COLORADO", :children_in_poverty=>{2009=>0.216}}, epr.path_to_parsing(title, row))
  end

  def test_it_can_return_values_from_path_to_parse_for_lunch
    skip
    title = :free_or_reduced_price_lunch
    row = {location: "Colorado",
          povertylevel: "Eligible for Free Lunch",
          timeframe: "2000",
          dataformat: "Percent",
          data:"0.27"}
    epr = EconomicProfileRepository.new

    assert_equal({:name=>"COLORADO", :free_or_reduced_price_lunch=>{2000=>{:Percent=>0.27}}}, epr.path_to_parsing(title, row))
  end

  def test_it_returns_an_instance_of_eco_prof
    epr = EconomicProfileRepository.new
    epr.load_data({
      :economic_profile => {
        :median_household_income => "./data/Median household income.csv",
        :children_in_poverty => "./data/School-aged children in poverty.csv",
        :free_or_reduced_price_lunch => "./data/Students qualifying for free or reduced price lunch.csv",
        :title_i => "./data/Title I students.csv"
      }
    })
    ep = epr.find_by_name("ACADEMY 20")
    ep2 = epr.find_by_name("lane")
    assert_instance_of EconomicProfile, ep
    binding.pry
    assert_equal nil, ep2
  end

  def test_searching_for_a_name_in_economic_profile
    ep1 = EconomicProfile.new({:name => "ACADEMY 20"})
    ep2 = EconomicProfile.new({:name => "ACADEMY 30"})
    ep3 = EconomicProfile.new({:name => "ADAMS"})
    erp = EconomicProfileRepository.new({"ACADEMY 20" => ep1,
                                   "ACADEMY 30" => ep2,
                                   "ADAMS" => ep3})

    assert_equal ep3, erp.find_by_name("ADAMS")
  end
end
