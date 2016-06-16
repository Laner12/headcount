
require './test/test_helper'
require './lib/statewide_test_repository'
require './lib/statewide_test'

class StatewideTestRepositoryTest < Minitest::Test


  def test_loads_data
    statewiderepo_class = StatewideTestRepository.new
    statewiderepo_class.load_data({
      :statewide_testing => {
        :third_grade => "./data/3rd grade students scoring proficient or above on the CSAP_TCAP.csv",
        :eighth_grade => "./data/8th grade students scoring proficient or above on the CSAP_TCAP.csv",
        :math => "./data/Average proficiency on the CSAP_TCAP by race_ethnicity_ Math.csv",
        :reading => "./data/Average proficiency on the CSAP_TCAP by race_ethnicity_ Reading.csv",
        :writing => "./data/Average proficiency on the CSAP_TCAP by race_ethnicity_ Writing.csv"}})

        assert_instance_of StatewideTest, statewiderepo_class.statewide_tests["ACADEMY 20"]
        assert_equal 181, statewiderepo_class.statewide_tests.count
        result1 = {2011=>{:math=>0.8169, :reading=>0.8976, :writing=>0.8268}, 2012=>{:math=>0.8182, :reading=>0.89328, :writing=>0.8083}, 2013=>{:math=>0.8053, :reading=>0.90193, :writing=>0.8109}, 2014=>{:math=>0.8, :reading=>0.85531, :writing=>0.7894}}
        result2 = {2008=>{:math=>0.857, :reading=>0.866, :writing=>0.671}, 2009=>{:math=>0.824, :reading=>0.862, :writing=>0.706}, 2010=>{:math=>0.849, :reading=>0.864, :writing=>0.662}, 2011=>{:math=>0.819, :reading=>0.867, :writing=>0.678}, 2012=>{:reading=>0.87, :math=>0.83, :writing=>0.65517}, 2013=>{:math=>0.8554, :reading=>0.85923, :writing=>0.6687}, 2014=>{:math=>0.8345, :reading=>0.83101, :writing=>0.63942}}
        assert_equal result1, statewiderepo_class.statewide_tests["ACADEMY 20"].attributes[:asian]
        assert_equal result2, statewiderepo_class.statewide_tests["ACADEMY 20"].attributes[3]
      end

    end
