class ShowTaskScreen < PM::Screen

  attr_accessor :task

  def on_load
    self.title = task.title
    # set rootview
    @layout = TaskLayout.new(root: self.view)
    @layout.build
    @layout.get(:notes).text = task.notes
  end

  def updateViewConstraints
    @layout.add_top_layout_guide_constraint(self)
    super
  end
end
