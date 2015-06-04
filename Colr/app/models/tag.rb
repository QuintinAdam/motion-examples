class Tag
  PROPERTIES = [:timestamp, :id, :name]
  attr_accessor *PROPERTIES

  def initialize(hash = {})
    hash.each { |key, value| self.send((key.to_s + "=").to_s, value) if PROPERTIES.member? key.to_sym }
  end

end
