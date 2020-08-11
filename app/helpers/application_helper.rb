module ApplicationHelper
  def show_created_time(time)
    time.strftime("%Y-%m-%d %H:%M")
  end
end
