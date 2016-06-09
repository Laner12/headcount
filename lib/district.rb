class District
  attr_reader :name,
              :enrollment,
              :attributes


  def initialize(attributes, enrollment = nil)
    @attributes = attributes
    @enrollment = enrollment
    @name       = attributes[:name].upcase
  end
end
