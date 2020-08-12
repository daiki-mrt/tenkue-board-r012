module ApplicationHelper
  def show_created_time(time)
    time.strftime("%Y-%m-%d %H:%M")
  end

  def array_count(array)
    array.count if array.count > 0 
  end
end
