class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    @window.backgroundColor = UIColor.whiteColor
    @window.makeKeyAndVisible # This is a special method for UIWindow that tells the system it will be the window receiving touch events and should be drawn to the screen.

    @blue_view = UIView.alloc.initWithFrame(CGRect.new([10, 40], [100, 100]))
    @blue_view.backgroundColor = UIColor.blueColor
    @window.addSubview(@blue_view)
    true
  end
end
