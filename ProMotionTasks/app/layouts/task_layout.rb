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
    frame [[20,100], [200,100]]
    # lines to 0 mean it can auto span lines
    number_of_lines 0

    text_alignment :center.nsalignment #NStextAlignmentCenter
  end
end
