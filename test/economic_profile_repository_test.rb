require_relative "../lib/economic_profile_repository"
require_relative "test_helper"

class EconomicProfileRepositoryTest < Minitest::Test

  def test_it_returns_an_instance_of_eco_prof
    skip
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
    assert_equal nil, ep2
  end
end
