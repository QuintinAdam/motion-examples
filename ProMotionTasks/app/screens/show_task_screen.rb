class ShowTaskScreen < PM::Screen

  attr_accessor :task

  def on_load
    self.title = task.title
  end
end
