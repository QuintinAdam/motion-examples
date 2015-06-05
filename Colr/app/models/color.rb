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

  def self.find(hex, &block)
    AFMotion::HTTP.get("http://www.colr.org/json/color/#{hex}") do |result|
      result_data = BubbleWrap::JSON.parse(result.body.to_str)
      color_data = result_data["colors"][0]

      # Colr will return a color with id == -1 if no color was found

      color = Color.new(color_data)
      if color.id.to_i == -1
        block.call(nil)
      else
        block.call(color)
      end
    end
  end

  def add_tag(tag, &block)
    AFMotion::HTTP.post("http://www.colr.org/js/color/#{self.hex}/addtag/", payload:{tags: tag}) do |response|
      if response.ok?
        block.call(tag)
      else
        block.call(nil)
      end
    end
  end
end
