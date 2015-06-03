class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    @window.backgroundColor = UIColor.whiteColor
    @window.makeKeyAndVisible # This is a special method for UIWindow that tells the system it will be the window receiving touch events and should be drawn to the screen.

    @blue_view = UIView.alloc.initWithFrame(CGRect.new([10, 40], [100, 100]))
    @blue_view.backgroundColor = UIColor.blueColor
    @window.addSubview(@blue_view)

    @add_button = UIButton.buttonWithType(UIButtonTypeSystem)
    @add_button.setTitle("Add", forState:UIControlStateNormal)
    @add_button.sizeToFit
    @add_button.frame = CGRect.new([10, @window.frame.size.height - 10 - @add_button.frame.size.height], @add_button.frame.size)
    @window.addSubview(@add_button)

    @add_button.addTarget(self, action: "add_tapped", forControlEvents:UIControlEventTouchUpInside)

    true
  end

  def add_tapped
  new_view = UIView.alloc.initWithFrame(CGRect.new([0, 0], [100, 100]))
  new_view.backgroundColor = UIColor.blueColor
  last_view = @window.subviews[0]
  new_view.frame = CGRect.new(
      [last_view.frame.origin.x,
        last_view.frame.origin.y + last_view.frame.size.height + 10],
      last_view.frame.size)
    @window.insertSubview(new_view, atIndex:0)
  end

end
