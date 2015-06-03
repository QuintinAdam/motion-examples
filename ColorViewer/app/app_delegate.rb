class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    @window.makeKeyAndVisible
    # UIViewController and adjust the view's frame to fit the window. This lets us write our controller without hard-coding its size, making our controller reusable to other containers

    # basic controller
        # the root view to a controller
        # @window.rootViewController = ColorsController.alloc.initWithNibName(nil, bundle: nil)

    # nav controller
        # set up the controller then pass it into a ui nav controller
        # controller = ColorsController.alloc.initWithNibName(nil, bundle: nil)
        # nav_controller = UINavigationController.alloc.initWithRootViewController(controller)

        # @window.rootViewController = nav_controller

    # tab controller
    controller = ColorsController.alloc.initWithNibName(nil, bundle: nil)
    nav_controller = UINavigationController.alloc.initWithRootViewController(controller)
    tab_controller = UITabBarController.alloc.initWithNibName(nil, bundle: nil)
    tab_controller.viewControllers = [nav_controller]
    @window.rootViewController = tab_controller

    true
  end
end
