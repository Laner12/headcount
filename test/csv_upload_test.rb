require_relative "test_helper"
require "./lib/csv_upload"

class CsvUploadTest < Minitest::Test
  include CsvUpload

  def test_contents_reads_csv_data
    assert_equal "", contents("./data/Kindergartners in full-day program.csv")
  end

  def test_data_is_formatted
    contents_output = contents("./data/Kindergartners in full-day program.csv")
    assert_equal "", format_data(contents_output)
  end
end
