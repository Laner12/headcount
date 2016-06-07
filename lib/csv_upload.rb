module CSVUpload

def self.contents(path)
  CSV.open(path, headers: true, header_converters: :symbol)
end

def self.updload_kindergartners
  kindergartners_data = contents(path).map do |row|
  data_hash = {}
  data_hash[:location] = row[:location]
  data_hash[:timeframe] = row[:timeframe]
  data_hash[:dataformat] = row[:dataformat]
  data_hash[:data] = row[:data]
end
kindergartners_data
binding.pry
end


end
