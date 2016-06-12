class District
  attr_reader :name,
              :district_repo,
              :attributes

  def initialize(attributes, district_repo = nil)
    @attributes = attributes
    @district_repo = district_repo
  end

  def name
    attributes[:name].upcase
  end
end
