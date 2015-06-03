class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
   @alert =
      UIAlertView.alloc.initWithTitle("Hello",
        message: "Hello, RubyMotion",
        delegate: nil,
        cancelButtonTitle: "OK",
        otherButtonTitles: nil)
    @alert.show
    puts "Hello from the console!"
    puts "app = UIApplication.sharedApplication"
    puts "delegate = app.delegate"
    puts "alert = delegate.instance_variable_get('@alert')"
    puts "alert.title = 'Goodbye'"
    puts 'alert.message = "You say yes?"'
    puts 'alert.show'
    puts 'alert.dismiss'

    true
  end
end
