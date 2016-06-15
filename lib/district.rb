class District
  attr_reader :name,
              :district_repo,
              :attributes,
              :state_connector

  def initialize(attributes, district_repo = nil)
    @attributes = attributes
    @district_repo = district_repo
  end

  def name
    attributes[:name].upcase
  end

  def enrollment
    district_repo.enrollment_connector(attributes[:name].upcase)
  end

def statewide_test
  district_repo.state_connector(attributes[:name].upcase)
end

end
