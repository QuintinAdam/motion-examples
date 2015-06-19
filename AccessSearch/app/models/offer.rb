class Offer
  attr_reader :title, :description, :logo_url, :coordinate
  attr_accessor :profile_image

  def initialize(dict)
    @title = dict['offer_store']['name']
    @description = dict['title']
    @logo_url = dict['logo_url']
    @profile_image = nil
    @coordinate = CLLocationCoordinate2D.new
    @coordinate.latitude = dict['offer_store']['physical_location']['geolocation']['lat']
    @coordinate.longitude = dict['offer_store']['physical_location']['geolocation']['lon']
  end
end
