class Color

  PROPERTIES = [:timestamp, :hex, :id, :tags]
  attr_accessor *PROPERTIES

  def initialize(properties = {})
    properties.each { |key, value| self.send((key.to_s + "=").to_s, value) if PROPERTIES.member? key.to_sym }
    # properties.each do |key, value|
    #   if PROPERTIES.member? key.to_sym
    #     # self.send("#{key}=", value)
    #     self.send((key.to_s + "=").to_s, value)
    #   end
    # end
  end

  def tags
    @tags ||= []
  end

  def tags=(tags)
    if tags.first.is_a? Hash
      tags = tags.collect { |tag| Tag.new(tag) }
    end
    tags.each do |tag|
      if not tag.is_a? Tag
        raise "Wrong class for attempted tag #{tag.inspect}"
      end
    end
    @tags = tags
  end
end
