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
  end
end
