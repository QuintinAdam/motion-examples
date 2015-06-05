class ColorController < UIViewController
  attr_accessor :color

  def initWithColor(color)
    initWithNibName(nil, bundle:nil)
    self.color = color
    self
  end

  def viewDidLoad
    super

    self.title = self.color.hex
    self.edgesForExtendedLayout = UIRectEdgeNone
    self.view.backgroundColor = UIColor.whiteColor

    padding = 10

    @info_container = UIView.alloc.initWithFrame([[0, 0], [self.view.frame.size.width, 60]])
    @info_container.backgroundColor = UIColor.lightGrayColor
    self.view.addSubview(@info_container)

    # box with color
    box_size = @info_container.frame.size.height - 2 * padding
    @color_view = UIView.alloc.initWithFrame([[padding, padding], [box_size, box_size]])
    # sets the color. to_color is from bubble wrap
    @color_view.backgroundColor = String.new(self.color.hex).to_color
    self.view.addSubview(@color_view)

    # text field for adding a tag
    text_field_origin = [@color_view.frame.origin.x + @color_view.frame.size.width + padding, @color_view.frame.origin.y]
    @text_field = UITextField.alloc.initWithFrame(CGRectZero)
    @text_field.placeholder = "tag"
    @text_field.autocapitalizationType = UITextAutocapitalizationTypeNone
    @text_field.borderStyle = UITextBorderStyleRoundedRect
    @text_field.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter
    self.view.addSubview(@text_field)

    # add button
    @add = UIButton.buttonWithType(UIButtonTypeSystem)
    @add.setTitle("Add", forState:UIControlStateNormal)
    @add.setTitle("Adding...", forState:UIControlStateDisabled)
    @add.setTitleColor(UIColor.lightGrayColor, forState:UIControlStateDisabled)
    @add.sizeToFit
    @add.frame = [[self.view.frame.size.width - @add.frame.size.width - padding, @color_view.frame.origin.y], [@add.frame.size.width, @color_view.frame.size.height]]
    self.view.addSubview(@add)

    # when button add clicked
    @add.when(UIControlEventTouchUpInside) do
      @add.enabled = false
      @text_field.enabled = false
      self.color.add_tag(@text_field.text) do |tag|
        if tag
          refresh
        else
          @add.enabled = true
          @text_field.enabled = true
          @text_field.text = "Failed :("
        end
      end
    end

    add_button_offset = @add.frame.size.width + 2*padding
    @text_field.frame = [text_field_origin, [self.view.frame.size.width - text_field_origin[0] - add_button_offset, @color_view.frame.size.height]]

    # for the table
    table_height = self.view.bounds.size.height - @info_container.frame.size.height
    table_frame = [[0, @info_container.frame.size.height], [self.view.bounds.size.width, table_height]]
    @table_view =UITableView.alloc.initWithFrame(table_frame, style: UITableViewStylePlain)
    @table_view.autoresizingMask = UIViewAutoresizingFlexibleHeight
    self.view.addSubview(@table_view)
    @table_view.dataSource = self
  end

  def tableView(tableView, numberOfRowsInSection:section)
    self.color.tags.count
  end

  def tableView(tableView, cellForRowAtIndexPath:indexPath)
    @reuseIdentifier ||= "my-table-cell"
    cell = tableView.dequeueReusableCellWithIdentifier(@reuseIdentifier)
    cell ||= UITableViewCell.alloc.initWithStyle(UITableViewCellStyleDefault, reuseIdentifier:@reuseIdentifier)
    cell.textLabel.text = self.color.tags[indexPath.row].name
    cell
  end
end
