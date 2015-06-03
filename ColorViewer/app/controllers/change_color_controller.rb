class ChangeColorController < UIViewController
  attr_accessor :color_detail_controller

  def viewDidLoad
    super
    self.title = "Change Color"
    self.view.backgroundColor = UIColor.whiteColor
    # text field
    @text_field = UITextField.alloc.initWithFrame(CGRectZero)
    @text_field.borderStyle = UITextBorderStyleRoundedRect
    @text_field.textAlignment = UITextAlignmentCenter
    @text_field.placeholder = "Enter a color"
    @text_field.frame = [CGPointZero, [150,32]]
    @text_field.center = [self.view.frame.size.width / 2, self.view.frame.size.height / 2 - 170]
    # add it
    self.view.addSubview(@text_field)
    # button
    @button = UIButton.buttonWithType(UIButtonTypeSystem)
    @button.setTitle("Change", forState:UIControlStateNormal)
    @button.frame = [[@text_field.frame.origin.x, @text_field.frame.origin.y + @text_field.frame.size.height + 10 ], @text_field.frame.size]
    # add it
    self.view.addSubview(@button)
    # action
    @button.addTarget(self, action:"change_color", forControlEvents:UIControlEventTouchUpInside)
  end

  def change_color
    color_text = @text_field.text
    color_text ||= ""
    color_text = color_text.downcase
    color_method = "#{color_text}Color"
    if UIColor.respond_to?(color_method)
      color = UIColor.send(color_method)
      # ColorDetailController using color_detail_controller(), set its background color
      self.color_detail_controller.view.backgroundColor = color
      # dismiss
      self.dismissViewControllerAnimated(true, completion: nil)
      return
    end
    # if no color
    @text_field.text = "Error!"
  end
end
