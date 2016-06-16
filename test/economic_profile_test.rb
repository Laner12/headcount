require_relative "../lib/economic_profile"
require_relative "test_helper"

class EconomicProfileTest < Minitest::Test

  def test_it_has_a_name
    data = {:median_household_income => {[2005, 2009] => 50000, [2008, 2014] => 60000},
        :children_in_poverty => {2012 => 0.1845},
        :free_or_reduced_price_lunch => {2014 => {:percentage => 0.023, :total => 100}},
        :title_i => {2015 => 0.543},
        :name => "ACADEMY 20"
       }
    economic_profile = EconomicProfile.new(data)

    assert_equal "ACADEMY 20", economic_profile.name
  end

  def test_it_returns_median_household_data_by_year
    data = {:median_household_income => {[2005, 2009] => 50000, [2008, 2014] => 60000},
        :children_in_poverty => {2012 => 0.1845},
        :free_or_reduced_price_lunch => {2014 => {:percentage => 0.023, :total => 100}},
        :title_i => {2015 => 0.543},
        :name => "ACADEMY 20"
       }
       economic_profile = EconomicProfile.new(data)

       assert_equal 50000, economic_profile.median_household_income_in_year(2005)
       assert_equal 55000, economic_profile.median_household_income_in_year(2009)
  end

  def test_it_returns_median_household_data
    data = {:median_household_income => {[2005, 2009] => 50000, [2008, 2014] => 60000},
        :children_in_poverty => {2012 => 0.1845},
        :free_or_reduced_price_lunch => {2014 => {:percentage => 0.023, :total => 100}},
        :title_i => {2015 => 0.543},
        :name => "ACADEMY 20"
       }
       economic_profile = EconomicProfile.new(data)

       assert_equal 55000, economic_profile.median_household_income_average
  end

  def test_it_return_children_in_porverty_in_year
    data = {:median_household_income => {[2005, 2009] => 50000, [2008, 2014] => 60000},
        :children_in_poverty => {2012 => 0.1845},
        :free_or_reduced_price_lunch => {2014 => {:percentage => 0.023, :total => 100}},
        :title_i => {2015 => 0.543},
        :name => "ACADEMY 20"
       }
       economic_profile = EconomicProfile.new(data)

       assert_equal 0.184, economic_profile.children_in_poverty_in_year(2012)
  end

  def test_it_returns_free_or_reduced_lunch_in_year_percentage
    data = {:median_household_income => {[2005, 2009] => 50000, [2008, 2014] => 60000},
        :children_in_poverty => {2012 => 0.1845},
        :free_or_reduced_price_lunch => {2014 => {:percentage => 0.023, :total => 100}},
        :title_i => {2015 => 0.543},
        :name => "ACADEMY 20"
       }
       economic_profile = EconomicProfile.new(data)

       assert_equal 0.023, economic_profile.free_or_reduced_price_lunch_percentage_in_year(2014)
  end

  def test_it_returns_free_or_reduced_lunch_number_in_year_
    data = {:median_household_income => {[2005, 2009] => 50000, [2008, 2014] => 60000},
        :children_in_poverty => {2012 => 0.1845},
        :free_or_reduced_price_lunch => {2014 => {:percentage => 0.023, :total => 100}},
        :title_i => {2015 => 0.543},
        :name => "ACADEMY 20"
       }
       economic_profile = EconomicProfile.new(data)

       assert_equal 100, economic_profile.free_or_reduced_price_lunch_number_in_year(2014)
  end

  def test_it_returns_title_one
    data = {:median_household_income => {[2005, 2009] => 50000, [2008, 2014] => 60000},
        :children_in_poverty => {2012 => 0.1845},
        :free_or_reduced_price_lunch => {2014 => {:percentage => 0.023, :total => 100}},
        :title_i => {2015 => 0.543},
        :name => "ACADEMY 20"
       }
       economic_profile = EconomicProfile.new(data)

       assert_equal 0.543, economic_profile.title_i_in_year(2015)
  end
end
