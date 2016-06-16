require_relative 'statewide_test'
require 'csv'

class StatewideTestRepository

  attr_reader :statewide_tests

  def initialize(statewide_tests = {})
    @statewide_tests = statewide_tests
  end

  def proficiency_parser(stored_data, name, race, year, title, percentage)
    if stored_data.has_key?(name)
      if stored_data[name].has_key?(race)
        if stored_data[name][race].has_key?(year)
          stored_data[name][race][year][title] = percentage
        else
          stored_data[name][race][year] = {title => percentage}
        end
      else
        stored_data[name][race] = {year => {title => percentage}}
      end
    else
      stored_data[name] = {race => {year => {title => percentage}}}
    end
  end

  def determinate_percentage(data)
    if data == "N/A"
    "N/A"
    else
     data.to_f
    end
  end

  def load_data(data)
    stored_data = {}
    data[:statewide_testing].each do |title, file_path|
      title = 3 if title == :third_grade
      title = 8 if title == :eighth_grade
      subjects = [:math, :reading, :writing]
      file = file_path

      CSV.foreach(file, headers: true, header_converters: :symbol) do |row|
        name = row[:location].upcase
        subject = row[:score].downcase.to_sym if row.include?(:score)
        year = row[:timeframe].to_i
        percent = determinate_percentage(row[:data])

        if row.include?(:race_ethnicity)
          if row[:race_ethnicity] == "Hawaiian/Pacific Islander"
            race = :pacific_islander
          else
            race = row[:race_ethnicity].tr(" ", "_").downcase.to_sym
          end
        end

        if subjects.include?(title)
          proficiency_parser(stored_data, name, race, year, title, percent)
        else
          proficiency_parser(stored_data, name, title, year, subject, percent)
        end

      end
    end
    create_statewide_tests(stored_data)
  end

  def create_statewide_tests(data)
    data.each do |name, district_data|
      statewide_tests.merge!(name => StatewideTest.new(district_data))
    end
  end

  def find_by_name(name)
    statewide_tests[name.upcase]
  end
end
