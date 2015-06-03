class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    @window.makeKeyAndVisible
    # UIViewController and adjust the view's frame to fit the window. This lets us write our controller without hard-coding its size, making our controller reusable to other containers
    @window.rootViewController = ColorsController.alloc.initWithNibName(nil, bundle: nil)

    true
  end
end
