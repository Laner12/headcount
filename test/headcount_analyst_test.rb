require "pry"
require_relative "test_helper"
require_relative "../lib/district_repository"
require_relative "../lib/headcount_analyst"

class HeadcountAnalystTest < Minitest::Test

  def test_comparing_variation_with_one_school_and_state_data

  dr = DistrictRepository.new
  dr.load_data({
    :enrollment => {
      :kindergarten => "./data/Kindergartners in full-day program.csv"
    }
  })
  ha = HeadcountAnalyst.new(dr)

  assert_equal 0.766, ha.kindergarten_participation_rate_variation('ACADEMY 20', :against => 'COLORADO')
  end

  def test_comparing_variation_with_two_school_data_sets
    dr = DistrictRepository.new
    dr.load_data({
      :enrollment => {
        :kindergarten => "./data/Kindergartners in full-day program.csv"
      }
    })
    ha = HeadcountAnalyst.new(dr)

    assert_equal 0.447, ha.kindergarten_participation_rate_variation('ACADEMY 20', :against => 'YUMA SCHOOL DISTRICT 1')
  end


  def test_comparing_variation_trend_with_school_and_state
    dr = DistrictRepository.new
    dr.load_data({
      :enrollment => {
        :kindergarten => "./data/Kindergartners in full-day program.csv"
      }
    })
    ha = HeadcountAnalyst.new(dr)
    result = {2004 => 1.257, 2005 => 0.96, 2006 => 1.05, 2007 => 0.992, 2008 => 0.717, 2009 => 0.652, 2010 => 0.681, 2011 => 0.727, 2012 => 0.688, 2013 => 0.694, 2014 => 0.661 }

    assert_equal result, ha.kindergarten_participation_rate_variation_trend('ACADEMY 20', :against => 'COLORADO')
  end

  def test_participation_of_kindergarten_against_high_school
    dr = DistrictRepository.new
    dr.load_data({
      :enrollment => {
        :kindergarten => "./data/Kindergartners in full-day program.csv",
        :high_school_graduation => "./data/High school graduation rates.csv"
      }
    })
    ha = HeadcountAnalyst.new(dr)

    assert_equal 0.641,ha.kindergarten_participation_against_high_school_graduation('ACADEMY 20')
  end

  def test_kindergarten_participation_correlates_with_high_school_graduation
    dr = DistrictRepository.new
    dr.load_data({
      :enrollment => {
        :kindergarten => "./data/Kindergartners in full-day program.csv",
        :high_school_graduation => "./data/High school graduation rates.csv"
      }
    })
    ha = HeadcountAnalyst.new(dr)

    assert_equal true, ha.kindergarten_participation_correlates_with_high_school_graduation(for: 'ACADEMY 20')
  end

  def test_kindergarten_participation_correlates_with_high_school_graduation_statewide
    dr = DistrictRepository.new
    dr.load_data({
      :enrollment => {
        :kindergarten => "./data/Kindergartners in full-day program.csv",
        :high_school_graduation => "./data/High school graduation rates.csv"
      }
      })
      ha = HeadcountAnalyst.new(dr)

    assert_equal false, ha.kindergarten_participation_correlates_with_high_school_graduation(:for => 'STATEWIDE')
  end

  def test_can_get_all_district_names
    dr = DistrictRepository.new
    dr.load_data({
      :enrollment => {
        :kindergarten => "./data/Kindergartners in full-day program.csv",
        :high_school_graduation => "./data/High school graduation rates.csv"
      }
      })

      assert_equal ["COLORADO", "ACADEMY 20", "ADAMS COUNTY 14"], dr.collect_district_names[0..2]
      assert_equal 181, dr.collect_district_names.count
  end

  def test_can_get_subset_district_names
    dr = DistrictRepository.new
    dr.load_data({
      :enrollment => {
        :kindergarten => "./data/Kindergartners in full-day program.csv",
        :high_school_graduation => "./data/High school graduation rates.csv"
      }
      })
      ha = HeadcountAnalyst.new(dr)

      assert_equal false, ha.kindergarten_participation_correlates_with_high_school_graduation(
      :across => ['ACADEMY 20', 'PUEBLO CITY 60', 'AGATE 300', 'ADAMS COUNTY 14'])

      assert_equal true, ha.kindergarten_participation_correlates_with_high_school_graduation(
      :across => ['ACADEMY 20', 'ACADEMY 20', 'ACADEMY 20', 'ACADEMY 20'])
  end
end
