class District
  attr_reader :name,
              :district_repo,
              :state_repo,
              :attributes

  def initialize(attributes, district_repo = nil)
    @attributes = attributes
    @district_repo = district_repo
    @state_repo = state_repo
  end

  def name
    attributes[:name].upcase
  end

  def enrollment
    district_repo.enrollment_connector(attributes[:name].upcase)
  end

def statewide_test
  state_repo.state_connector(attributes[:name].upcase)
end

end
