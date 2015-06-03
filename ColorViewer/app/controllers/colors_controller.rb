class ColorsController < UIViewController
  # Subclassing UIViewController always involves overriding viewDidLoad()
  # This method is called right after our controller's view
  # viewDidLoad() is one of the view life-cycle methods.
  # Every controller's view goes through several stages: creation, appearance, disappearance, and destruction.
  def viewDidLoad
    super
    self.view.backgroundColor = UIColor.whiteColor
    @label = UILabel.alloc.initWithFrame(CGRectZero)
    @label.text = "Colors"
    @label.sizeToFit
    @label.center = [self.view.frame.size.width / 2, self.view.frame.size.height / 2]
    @label.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin
    self.view.addSubview(@label)
    # for the ui nav bar title
    self.title = "Colors"

    # buttons

    ["red", "green", "blue"].each_with_index do |color_text, index|
      # create the UIColor, button text, and button callback all with a single color_text variable
      color = UIColor.send("#{color_text}Color")
      button_width = 80
      button = UIButton.buttonWithType(UIButtonTypeSystem)
      button.setTitle(color_text, forState:UIControlStateNormal)
      button.setTitleColor(color, forState:UIControlStateNormal)
      button.sizeToFit
      # size
      button.frame = [[30 + index*(button_width + 10), @label.frame.origin.y + button.frame.size.height + 30], [80, button.frame.size.height]]
      button.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin
      # touch event
      button.addTarget(self, action:"tap_#{color_text}", forControlEvents:UIControlEventTouchUpInside)
      # add to view
      self.view.addSubview(button)
    end
  end

  # override initWithNibName:bundle: in ColorsController, and then we can create our UITabBarItem
  def initWithNibName(name, bundle: bundle)
    super
    # image should be a 30x30 black and transparent icon
    self.tabBarItem = UITabBarItem.alloc.initWithTitle("Colors", image: nil, tag: 1)
    self
  end

  # button callbacks
  # navigationController() is automatically set whenever we add a view controller to a navigation stack, which we did with initWithRootView
  def tap_red
    controller = ColorDetailController.alloc.initWithColor(UIColor.redColor)
    self.navigationController.pushViewController(controller, animated: true)
  end
  def tap_green
    controller = ColorDetailController.alloc.initWithColor(UIColor.greenColor)
    self.navigationController.pushViewController(controller, animated: true)
  end
  def tap_blue
    controller = ColorDetailController.alloc.initWithColor(UIColor.blueColor)
    self.navigationController.pushViewController(controller, animated: true)
  end

end
