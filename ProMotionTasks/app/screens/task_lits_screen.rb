class TaskListScreen < PM::TableScreen

  title "Tasks"

  def table_data
    [
      {
        cells: Task.all.map do |t|
          {
            title: t.title,
            subtitle: t.notes,
            cell_style: UITableViewCellStyleSubtitle,
            action: :show_task,
            arguments: t
          }
        end
      }
    ]
  end

  def show_task(task)

  end
end
