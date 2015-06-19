class OfferCell < UITableViewCell
  CellID = 'CellIdentifier'
  TitleFontSize = 14

  def self.cellForOffer(offer, inTableView:tableView)
    cell = tableView.dequeueReusableCellWithIdentifier(OfferCell::CellID) || OfferCell.alloc.initWithStyle(UITableViewCellStyleSubtitle, reuseIdentifier:CellID)
    cell.fillWithOffer(offer, inTableView:tableView)
    cell
  end

  def initWithStyle(style, reuseIdentifier:cellid)
    if super
      self.textLabel.numberOfLines = 0
      self.textLabel.font = UIFont.systemFontOfSize(TitleFontSize)
    end
    self
  end

  def fillWithOffer(offer, inTableView:tableView)
    self.textLabel.text = offer.title
    self.detailTextLabel.text = offer.description
    unless offer.profile_image
      Dispatch::Queue.concurrent.async do
        profile_image_data = NSData.alloc.initWithContentsOfURL(NSURL.URLWithString(offer.logo_url))
        if profile_image_data
          offer.profile_image = UIImage.alloc.initWithData(profile_image_data)
          Dispatch::Queue.main.sync do
            self.imageView.image = offer.profile_image
            tableView.delegate.reloadRowForOffer(offer)
          end
        end
      end
    else
      self.imageView.image = offer.profile_image
    end
  end

  def self.heightForOffer(offer, width)
    constrain = CGSize.new(width - 57, 1000)
    size = offer.title.sizeWithFont(UIFont.systemFontOfSize(TitleFontSize), constrainedToSize:constrain)
    [57, size.height + 8].max
  end

  def layoutSubviews
    super
    self.imageView.frame = CGRectMake(2, 2, 49, 49)
    label_size = self.frame.size
    self.textLabel.frame = CGRectMake(57, 0, label_size.width - 59, label_size.height)
  end
end
