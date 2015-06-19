class AccessListController < UITableViewController

  def init
    if super
      self.tabBarItem = UITabBarItem.alloc.initWithTitle('List', image:UIImage.imageNamed('list.png'), tag:1)
    end
    self
  end

  def viewDidLoad
    @offers = []
    searchBar = UISearchBar.alloc.initWithFrame(CGRectMake(0, 0, self.tableView.frame.size.width, 0))
    searchBar.delegate = self;
    searchBar.showsCancelButton = true;
    searchBar.sizeToFit
    view.tableHeaderView = searchBar
    view.dataSource = view.delegate = self

    searchBar.text = '84101'
    searchBarSearchButtonClicked(searchBar)
  end

  def searchBarSearchButtonClicked(searchBar)
    query = searchBar.text.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)
    url = "http://offer-demo.adcrws.com/v1/offers?access_token=#{ENV['ACCESS_TOKEN']}&sort=random&postal_code=#{query}"

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
    view.reloadData
  end

  def presentError(error)
    # TODO
    $stderr.puts error.description
  end

  def tableView(tableView, numberOfRowsInSection:section)
    @offers.size
  end

  def tableView(tableView, heightForRowAtIndexPath:indexPath)
    OfferCell.heightForOffer(@offers[indexPath.row], tableView.frame.size.width)
  end

  def tableView(tableView, cellForRowAtIndexPath:indexPath)
    offer = @offers[indexPath.row]
    OfferCell.cellForOffer(offer, inTableView:tableView)
  end

  def reloadRowForOffer(offer)
    row = @offers.index(offer)
    if row
      view.reloadRowsAtIndexPaths([NSIndexPath.indexPathForRow(row, inSection:0)], withRowAnimation:false)
    end
  end
end
