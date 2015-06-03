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

  # make User NSCoding compliant
  # decode and encode our data
  # deserialize our object out of the decoder instance
  def initWithCoder(decoder)
    self.init
    PROPERTIES.each do |prop|
      saved_value = decoder.decodeObjectForKey(prop.to_s)
      self.send("#{prop}=", saved_value)
    end
    self
  end

  # gets called when we want to save our object and encode its properties with encodeObject:forKey
  def encodeWithCoder(encoder)
    PROPERTIES.each do |prop|
      encoder.encodeObject(self.send(prop), forKey: prop.to_s)
    end
  end
end
