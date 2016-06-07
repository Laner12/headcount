require "pry"
require "csv"

class DistrictRepository


  def file_opener
    contents = CSV.open "./data/Kindergartners in full-day program.csv", headers: true, header_converters: :symbol
    contents.each do |row|
      location = row[:location]
      timeframe = row[:timeframe]
      dataformat = row[:dataformat]
      data = row[:data]
    end
  end

  
  def find_by_name
  end


  #break up our date into headers that can be called (:district => location)


end
