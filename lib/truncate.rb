module Truncate

  def self.truncate_float(float)
   (float * 1000).floor / 1000.to_f
  end

  def self.truncate_nan(float)
    float = 0 if float.nan?
    (float * 1000).floor / 1000.to_f
  end
end
