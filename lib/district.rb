class District
  attr_reader :attributes


  def initialize(attributes) #district_repo)
    @attributes = attributes
    # @district_repo = district_repo
  end

  def name
    @attributes[:name].upcase
  end

  # def enrollment
  #     #travers the self branch
  #     #go to the enrollment
  # end



end
