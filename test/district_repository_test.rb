require_relative "../lib/district_repository"
require_relative "test_helper"

class DistrictRepositoryTest < Minitest::Test

  def test_it_is_an_instance_of_district
    dr = DistrictRepository.new
    dr.load_data({
      :enrollment => {
        :kindergarten => "./data/Kindergartners in full-day program.csv"
      }
      })
      district = dr.find_by_name("ACADEMY 20")

      assert_instance_of District, district
    end

    def test_it_can_find_by_name
      d1 = District.new({:name => "ACADEMY 20"})
      d2 = District.new({:name => "ACADEMY 30"})
      d3 = District.new({:name => "ADAMS"})
      dr = DistrictRepository.new({"ACADEMY 20" => d1,
        "ACADEMY 30" => d2,
        "ADAMS" => d3 })

        assert_equal d3, dr.find_by_name("ADAMS")
        assert_equal d3, dr.find_by_name("adams")
        assert_equal nil, dr.find_by_name("z")
        assert_equal nil, dr.find_by_name("?")
        assert_equal nil, dr.find_by_name(1)
      end

      def test_it_can_find_all_matching
        d1 = District.new({:name => "ACADEMY 20"})
        d2 = District.new({:name => "ACADEMY 30"})
        d3 = District.new({:name => "ADAMS"})
        dr = DistrictRepository.new({"ACADEMY 20" => d1,
          "ACADEMY 30" => d2,
          "ADAMS" => d3 })

          assert_equal [d1, d2, d3], dr.find_all_matching("a")
          assert_equal [d1, d2], dr.find_all_matching("ac")
          assert_equal [d3], dr.find_all_matching("ad")
          assert_equal [], dr.find_all_matching("z")
          assert_equal [], dr.find_all_matching("?")
          assert_equal [], dr.find_all_matching(1)
        end

        def test_searching_for_a_object_of_district_for_participation_percent
          dr = DistrictRepository.new
          dr.load_data({
            :enrollment => {
              :kindergarten => "./data/Kindergartners in full-day program.csv"
            }
            })
            district = dr.find_by_name("ACADEMY 20")
            action = district.enrollment.kindergarten_participation_in_year(2010)

            assert_equal 0.436, action
          end
        end
