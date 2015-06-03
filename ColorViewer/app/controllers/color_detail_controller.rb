class ColorDetailController < UIViewController

  # takes a UIColor as its argument
  def initWithColor(color)
    self.initWithNibName(nil, bundle:nil)
    @color = color
    self.title = "Detail"
    self
  end

  def viewDidLoad
    super
    self.view.backgroundColor = @color
    # style: plain, bordered, or "done"
    rightButton = UIBarButtonItem.alloc.initWithTitle("Change", style: UIBarButtonItemStyleBordered, target:self, action:'change_color')
    # UINavigationItem is not a UIView, so you cannot add new subviews to it
    self.navigationItem.rightBarButtonItem = rightButton
  end

  def change_color
    controller = ChangeColorController.alloc.initWithNibName(nil, bundle:nil)
    controller.color_detail_controller = self
    self.presentViewController(UINavigationController.alloc.initWithRootViewController(controller), animated:true, completion: lambda {})
  end

end
