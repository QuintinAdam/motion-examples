class AlphabetController < UIViewController

  def viewDidLoad
    super
    self.title = "Alphabet"
    # grouped like settings.app
    @table = UITableView.alloc.initWithFrame(self.view.bounds, style: UITableViewStyleGrouped)
    # big list
    # @table = UITableView.alloc.initWithFrame(self.view.bounds)
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

    # @data = ("A".."Z").to_a

    @data = {}
    ("A".."Z").to_a.each do |letter|
      @data[letter] = []
      5.times do
        random_string = (0...4).map{65.+(rand(25)).chr}.join
        @data[letter] << letter + random_string
      end
    end
  end

  def tableView(tableView, numberOfRowsInSection: section)
    # return the UITableViewCell for the row
    # @data.count
    rows_for_section(section).count
  end

  def tableView(tableView, cellForRowAtIndexPath: indexPath)
    @reuseIdentifier ||= "CELL_IDENTIFIER"
    # cell = tableView.dequeueReusableCellWithIdentifier(@reuseIdentifier)
    cell ||= UITableViewCell.alloc.initWithStyle(UITableViewCellStyleDefault, reuseIdentifier:@reuseIdentifier)
    # cell.textLabel.text = @data[indexPath.row]
    cell.textLabel.text = row_for_index_path(indexPath)
    # adds the arrows
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator
    cell
  end

  def tableView(tableView, didSelectRowAtIndexPath:indexPath)
    # by default UITableView will keep a row highlighted in blue once the user taps it
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
    # letter = @data[indexPath.row]
    letter = sections[indexPath.section]

    controller = UIViewController.alloc.initWithNibName(nil, bundle:nil)
    controller.view.backgroundColor = UIColor.whiteColor
    controller.title = letter
    # label
    label = UILabel.alloc.initWithFrame(CGRectZero)
    # label.text = letter
    label.text = row_for_index_path(indexPath)
    label.sizeToFit
    label.center = [controller.view.frame.size.width / 2, controller.view.frame.size.height / 2]
    # add view
    controller.view.addSubview(label)
    self.navigationController.pushViewController(controller, animated:true)
  end

  # to get the gray headers to appear, we need to return their titles in another new dataSource method
  def tableView(tableView, titleForHeaderInSection:section)
    sections[section]
  end

  def numberOfSectionsInTableView(tableView)
    self.sections.count
  end

  # adds side quick index
  def sectionIndexTitlesForTableView(tableView)
    sections
  end

  # adds side quick index
  def tableView(tableView, sectionForSectionIndexTitle: title, atIndex: index)
    sections.index title
  end

  #deletes
  def tableView(tableView, editingStyleForRowAtIndexPath: indexPath)
    UITableViewCellEditingStyleDelete
  end

  def tableView(tableView, commitEditingStyle:editingStyle, forRowAtIndexPath:indexPath)
    if editingStyle == UITableViewCellEditingStyleDelete
      rows_for_section(indexPath.section).delete_at indexPath.row
      # tableView.reloadData
      # reload reload data with a nice animation
      # other UITableViewRowAnimations like UITableViewRowAnimationRight or UITableViewRowAnimationBottom
      tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation:UITableViewRowAnimationFade)
    end
  end

  #helpers
  # These just abstract NSIndexPath-based access to our data
  def sections
    @data.keys.sort
  end

  def rows_for_section(section_index)
    @data[self.sections[section_index]]
  end

  def row_for_index_path(index_path)
    rows_for_section(index_path.section)[index_path.row]
  end
end
