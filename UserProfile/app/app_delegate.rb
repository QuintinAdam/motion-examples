class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)

    # setup user
    @user = User.new
    @user.id = "123"
    @user.name = "Clay"
    @user.email = "clay@mail.com"
    @user_controller = UserController.alloc.initWithUser(@user)
    @nav_controller =
        UINavigationController.alloc.initWithRootViewController(@user_controller)
    @window.rootViewController = @nav_controller
    @window.makeKeyAndVisible

    true
  end
end
