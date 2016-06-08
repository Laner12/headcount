require "pry"
require "csv"
module CsvUpload

  def contents(path)
    CSV.open(path, headers: true, header_converters: :symbol).map(&:to_h)
  end

  def format_data(contents_output)
    contents_output.map do |row|
      {name: row[:location], kindergarten_participation: {row[:timeframe] => row[:data]}}
    end.compact
  end

end


#
# def self.updload_kindergartners
#   kindergartners_data = contents(path).map do |row|
#     data_hash = {}
#     # data_hash[:name] = row[:location]
#     data_hash[:location] = row[:location]
#     data_hash[:timeframe] = row[:timeframe]
#     data_hash[:dataformat] = row[:dataformat]
#     data_hash[:data] = row[:data]
#   end
#   kindergartners_data
# end
