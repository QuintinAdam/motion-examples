class ColorDetailController < UIViewController

  # takes a UIColor as its argument
  def initWithColor(color)
    self.initWithNibName(nil, bundle:nil)
    @color = color
    self.title = "Detail"
    self
  end

  def viewDidLoad
    super
    self.view.backgroundColor = @color
  end

end
