class ShowTaskScreen < PM::Screen

  attr_accessor :task

  def on_load
    self.title = task.title
    # set rootview
    @layout = TaskLayout.new(root: self.view)
    @layout.build
  end
end
