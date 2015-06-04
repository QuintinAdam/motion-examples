class ButtonController < UIViewController

  def viewDidLoad
    super
    # make a button
    button = UIButton.buttonWithType(UIButtonTypeSystem)
    button.setTitle("Tap Me", forState:UIControlStateNormal)
    button.sizeToFit
    button_origin = [0, 100]
    button.frame = [button_origin, button.frame.size]
    # touch event
    button.addTarget(self, action:'tapped', forControlEvents:UIControlEventTouchUpInside)
    # add to view
    self.view.addSubview(button)
    # make a variable that we can change and check for in our tests
    @tapped = false

  end

  def tapped
    @tapped = true
    self.view.backgroundColor = UIColor.redColor
  end

end
