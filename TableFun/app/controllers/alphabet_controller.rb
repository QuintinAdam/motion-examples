class AlphabetController < UIViewController

  def viewDidLoad
    super
    self.title = "Alphabet"
    @table = UITableView.alloc.initWithFrame(self.view.bounds)
    @table.autoresizingMask = UIViewAutoresizingFlexibleHeight
    self.view.addSubview(@table)

    # A table's dataSource must implement the following methods, or else the app will throw an exception: tableView:cellForRowAtIndexPath: and tableView:numberOfRowsInSection:
    @table.dataSource = self
    @table.delegate = self

    # numberOfRowsInSection: should return exactly what it sounds like. cellForRowAtIndex- Path:'s job is to either create a new cell or recycle an offscreen one.
    # cellForRowAtIndexPath: uses two unfamiliar objects: indexPath is an instance of NSIndexPath, and the method is supposed to return a UITableViewCel

    # def tableView(tableView, numberOfRowsInSection: section)
    # # return the number of rows
    # end
    # def tableView(tableView, cellForRowAtIndexPath: indexPath)
    #   # return the UITableViewCell for the row
    # end

    @data = ("A".."Z").to_a

  end

  def tableView(tableView, numberOfRowsInSection: section)
    # return the UITableViewCell for the row
    @data.count
  end

  def tableView(tableView, cellForRowAtIndexPath: indexPath)
    @reuseIdentifier ||= "CELL_IDENTIFIER"
    cell = tableView.dequeueReusableCellWithIdentifier(@reuseIdentifier)
    cell ||= UITableViewCell.alloc.initWithStyle(UITableViewCellStyleDefault, reuseIdentifier:@reuseIdentifier) cell.textLabel.text = @data[indexPath.row]
    cell
  end

  def tableView(tableView, didSelectRowAtIndexPath:indexPath)
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
    letter = @data[indexPath.row]

    controller = UIViewController.alloc.initWithNibName(nil, bundle:nil)
    controller.view.backgroundColor = UIColor.whiteColor
    controller.title = letter
    label = UILabel.alloc.initWithFrame(CGRectZero)
    label.text = letter
    label.sizeToFit
    label.center = [controller.view.frame.size.width / 2, controller.view.frame.size.height / 2]
    controller.view.addSubview(label)
    self.navigationController.pushViewController(controller, animated:true)
  end

end
