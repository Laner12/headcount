class District

  def initialize(attributes)
    @attributes = attributes
  end

  def name
    @attributes[:name].upcase
  end
end
