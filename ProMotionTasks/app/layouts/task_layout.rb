class TaskLayout < MK::Layout

  def layout
    root :task do
      add UILabel, :notes
    end
  end

  def task_style
    background_color "#FFFFFF".uicolor #same as UIColor.whiteColor
  end

  def notes_style
    # replace frame with auto layout
    # frame [[20,100], [200,100]]
    # lines to 0 mean it can auto span lines
    number_of_lines 0

    text_alignment :center.nsalignment #NStextAlignmentCenter

    constraints do
      left 20
      right -20
    end
  end

  def add_top_layout_guide_constraint(controller)
    unless @contraint_added
      @contraint_added = true

      constraints(:notes) do
        top.equals(controller.topLayoutGuide, :bottom).plus(20)
      end
    end
  end
end
