class AppDelegate < PM::Delegate
  def on_load(app, options)
    open TaskListScreen.new(nav_bar: true)
  end
end
