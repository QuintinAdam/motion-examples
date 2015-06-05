class SearchController < UIViewController
  def viewDidLoad
    super
    self.title = "Search"
    self.view.backgroundColor = UIColor.whiteColor

    @text_field = UITextField.alloc.initWithFrame [[0,0], [160, 26]]
    @text_field.placeholder = "#ffffff"
    @text_field.textAlignment = UITextAlignmentCenter
    @text_field.autocapitalizationType = UITextAutocapitalizationTypeNone
    #StyleNone and StyleLine also exist
    @text_field.borderStyle = UITextBorderStyleRoundedRect
    @text_field.center = [self.view.frame.size.width / 2, self.view.frame.size.height / 2 - 100]

    self.view.addSubview(@text_field)

    @search = UIButton.buttonWithType(UIButtonTypeSystem)
    @search.setTitle("Search", forState:UIControlStateNormal)
    @search.setTitle("Loading", forState:UIControlStateDisabled)
    @search.sizeToFit
    @search.center = [self.view.frame.size.width / 2, @text_field.center.y + 40]

    self.view.addSubview(@search)

    # when is from bubble wrap
    # when() function is available to every UIControl (of which UIButton is a subclass) and takes the usual bitmask of UIControlEvents as its arguments
    # While the request runs, we temporarily disable our UI elements using the enabled property of each element.
    @search.when(UIControlEventTouchUpInside) do
      @search.enabled = false
      @text_field.enabled = false
      hex = @text_field.text
      # chop off any leading #s
      hex = hex[1..-1] if hex[0] == "#"
      Color.find(hex) do |color|
        if color.nil?
          @search.setTitle("None :(", forState: UIControlStateNormal)
        else
          @search.setTitle("Search", forState: UIControlStateNormal)
          self.open_color(color)
        end
        @search.enabled = true
        @text_field.enabled = true
      end
    end

    def open_color(color)
      p "Opening #{color.inspect}"
    end
  end

end

