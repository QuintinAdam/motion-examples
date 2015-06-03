class User
  # attr_accessor :id
  # attr_accessor :name
  # attr_accessor :email
  PROPERTIES = [:id, :name, :email, :phone]
  attr_accessor *PROPERTIES

  def initialize(properties = {})
    properties.each do |key, value|
      if PROPERTIES.member? key.to_sym
        self.send("#{key}=", value)
      end
    end
  end
end
