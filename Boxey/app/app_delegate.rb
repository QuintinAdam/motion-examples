class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    # white background
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    @window.backgroundColor = UIColor.whiteColor
    @window.makeKeyAndVisible # This is a special method for UIWindow that tells the system it will be the window receiving touch events and should be drawn to the screen.

    #blue box
    @blue_view = UIView.alloc.initWithFrame(CGRect.new([10, 40], [100, 100]))
    @blue_view.backgroundColor = UIColor.blueColor
    @window.addSubview(@blue_view)

    #add button
    @add_button = UIButton.buttonWithType(UIButtonTypeSystem)
    @add_button.setTitle("Add", forState:UIControlStateNormal)
    @add_button.sizeToFit
    @add_button.frame = CGRect.new([10, @window.frame.size.height - 10 - @add_button.frame.size.height], @add_button.frame.size)
    @window.addSubview(@add_button)

    #tapped button event add box
    @add_button.addTarget(self, action: "add_tapped", forControlEvents:UIControlEventTouchUpInside)

    #remove button
    @remove_button = UIButton.buttonWithType(UIButtonTypeSystem)
    @remove_button.setTitle("Remove", forState:UIControlStateNormal)
    @remove_button.sizeToFit
    @remove_button.frame = CGRect.new([@add_button.frame.origin.x + @add_button.frame.size.width + 10, @add_button.frame.origin.y], @remove_button.frame.size)
    @window.addSubview(@remove_button)

    # tapped button event remove box
    @remove_button.addTarget(self, action:"remove_tapped", forControlEvents:UIControlEventTouchUpInside)

    true
  end

  def add_tapped
    new_view = UIView.alloc.initWithFrame(CGRect.new([0, 0], [100, 100]))
    new_view.backgroundColor = UIColor.blueColor
    last_view = @window.subviews[0]
    new_view.frame = CGRect.new([last_view.frame.origin.x, last_view.frame.origin.y + last_view.frame.size.height + 10], last_view.frame.size)
    @window.insertSubview(new_view, atIndex:0)
  end

  def remove_tapped
    # make sure we only deal with boxes
    other_views = @window.subviews.reject do |view|
      view.is_a?(UIButton)
    end
    # the last box created
    last_view = other_views.last
    # if there are no more boxes?
    return unless last_view && other_views.count > 1
    # Animations revolve around the UIView.animateWithDuration:animations: group of methods (you can also use animateWithDuration:delay:options:animations:completions: if you need to fine-tune things)
    animations_block = lambda do
      last_view.alpha = 0
      last_view.backgroundColor = UIColor.redColor
      other_views.reject do |view|
        view == last_view
      end.each do |view|
        new_origin = [view.frame.origin.x, view.frame.origin.y - (last_view.frame.size.height + 10)]
        view.frame = CGRect.new(new_origin, view.frame.size)
      end
    end
    # clean up view This will remove the view from its parent's subviews and be erased from the screen.
    completion_block = lambda { |finished| last_view.removeFromSuperview }

    UIView.animateWithDuration(0.5,
      animations: animations_block,
      completion: completion_block)
  end
end
