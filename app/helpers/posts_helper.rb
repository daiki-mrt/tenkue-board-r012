module PostsHelper
  def show_posted_time(time)
    time.strftime("%Y-%m-%d %H:%M")
  end
end
