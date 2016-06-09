require_relative "district_repository"
class HeadcountAnalyst

attr_reader :district_repo

def initialize(dr)
  @district_repo = dr
end

def kindergarten_participation_rate_variation(first_district, second_district)
district_one = @district_repo.find_by_name(first_district)
district_one_years = district_one.enrollment.data[:kindergarten_participation].length
district_one_total_participation = district_one.enrollment.data[:kindergarten_participation].values.reduce(:+)
district_one_average = district_one_total_participation/district_one_years
district_two = @district_repo.find_by_name(second_district[:against])
district_two_years = district_two.enrollment.data[:kindergarten_participation].length
district_two_total_participation = district_two.enrollment.data[:kindergarten_participation].values.reduce(:+)
district_two_average = district_two_total_participation/district_two_years
rate_variation = district_one_average/ district_two_average
rate = rate_variation.round(3)
# needs the trucate method
end


end
