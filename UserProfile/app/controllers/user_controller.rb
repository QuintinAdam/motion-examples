class UserController < UIViewController
  attr_accessor :user

  def initWithUser(user)
    initWithNibName(nil, bundle:nil)
    self.user = user
    self.edgesForExtendedLayout = UIRectEdgeNone
    self
  end

  def viewDidLoad
    super

    self.view.backgroundColor = UIColor.whiteColor

    last_label = nil
    ["id", "name", "email"].each do |prop|
      label = UILabel.alloc.initWithFrame(CGRectZero)
      label.text = "#{prop.capitalize}:"

      label.sizeToFit

      if last_label
        label.frame = [[last_label.frame.origin.x, last_label.frame.origin.y + last_label.frame.size.height], label.frame.size]
      else
        label.frame = [[10, 10], label.frame.size]
      end
      last_label = label

      self.view.addSubview(label)

      value = UILabel.alloc.initWithFrame(CGRectZero)
      value.text = self.user.send(prop)
      value.sizeToFit
      value.frame = [[label.frame.origin.x + label.frame.size.width + 10, label.frame.origin.y], value.frame.size]
      self.view.addSubview(value)
    end
    # set the title to the users name
    self.title = self.user.name
  end
end
