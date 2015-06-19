class AccessMapController < UIViewController
  def init
    if super
      self.tabBarItem = UITabBarItem.alloc.initWithTitle('Map', image:UIImage.imageNamed('map.png'), tag:1)
    end
    self
  end

  def loadView
    self.view = MKMapView.alloc.init
    view.delegate = self
  end

  def viewDidLoad
    @offers = []
    searchBar = UISearchBar.alloc.initWithFrame(CGRectMake(0, 0, self.view.frame.size.width, 0))
    searchBar.delegate = self;
    searchBar.showsCancelButton = true;
    searchBar.sizeToFit
    # view.tableHeaderView = searchBar
    # view.dataSource = view.delegate = self

    searchBar.text = 'pizza'
    searchBarSearchButtonClicked(searchBar)

    region = MKCoordinateRegionMake(CLLocationCoordinate2D.new(44.04484, -122.93529), MKCoordinateSpanMake(10.1, 10.1))
    self.view.setRegion(region)
  end

  def searchBarSearchButtonClicked(searchBar)
    query = searchBar.text.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)
    # url = "http://www.reddit.com/search.json?q=#{query}"
    url = "http://offer-demo.adcrws.com/v1/offers?access_token=#{ENV['ACCESS_TOKEN']}&sort=random&query=#{query}"

    @offers.clear
    Dispatch::Queue.concurrent.async do
      json = nil
      begin
        json = JSONParser.parse_from_url(url)
      rescue RuntimeError => e
        presentError e.message
      end

      new_offers = []
      json['offers'].each do |dict|
       new_offers << Offer.new(dict)
      end

      Dispatch::Queue.main.sync { load_offers(new_offers) }
    end

    searchBar.resignFirstResponder
  end

  def searchBarCancelButtonClicked(searchBar)
    searchBar.resignFirstResponder
  end

  def load_offers(offers)
    @offers = offers
    @offers.each { |offer| self.view.addAnnotation(offer) }
    # view.reloadData
  end

  def viewWillAppear(animated)
    navigationController.setNavigationBarHidden(true, animated:true)
  end

  ViewIdentifier = 'ViewIdentifier'
  def mapView(mapView, viewForAnnotation:offer)
    if view = mapView.dequeueReusableAnnotationViewWithIdentifier(ViewIdentifier)
      view.annotation = offer
    else
      view = MKPinAnnotationView.alloc.initWithAnnotation(offer, reuseIdentifier:ViewIdentifier)
      view.canShowCallout = true
      view.animatesDrop = true
      button = UIButton.buttonWithType(UIButtonTypeDetailDisclosure)
      button.addTarget(self, action: :'showDetails:', forControlEvents:UIControlEventTouchUpInside)
      view.rightCalloutAccessoryView = button
    end
    view
  end

  def showDetails(sender)
    if view.selectedAnnotations.size == 1
      offer = view.selectedAnnotations[0]
      controller = UIApplication.sharedApplication.delegate.offer_details_controller
      navigationController.pushViewController(controller, animated:true)
      controller.showDetailsForBeer(offer)
    end
  end
end
