module Truncate

  def self.truncate_float(float)
    truncated_data =(float * 1000).floor / 1000.to_f
  end
end
