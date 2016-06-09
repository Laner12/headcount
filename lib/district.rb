class District
  attr_reader :attributes
  attr_accessor :enrollment


  def initialize(attributes, enrollment = nil)
    @attributes = attributes
    @enrollment = enrollment
  end

  def name
    @attributes[:name].upcase
  end
end
