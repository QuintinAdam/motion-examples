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

  # production app, our USER_KEY would probably be a function of the user's id,
  USER_KEY = "user"

  def save
    defaults = NSUserDefaults.standardUserDefaults
    defaults[USER_KEY] = NSKeyedArchiver.archivedDataWithRootObject(self)
  end

  def self.load
    defaults = NSUserDefaults.standardUserDefaults
    data = defaults[USER_KEY]
    # protect against nil case
    NSKeyedUnarchiver.unarchiveObjectWithData(data) if data
  end
end

# defaults = NSUserDefaults.standardUserDefaults
# defaults["some_array"] = [1,2,3]
# defaults["some_number"] = 4
# some_name = defaults["some_name"]

# Here's what an NSCoding serialization looks like:
# my_object = # some NSCoding-compliant object
# defaults = NSUserDefaults.standardUserDefaults
# defaults["some_object"] = NSKeyedArchiver.archivedDataWithRootObject(my_object)
# my_saved_data = defaults["some_object"]
# my_saved_object = NSKeyedUnarchiver.unarchiveObjectWithData(my_saved_data)
