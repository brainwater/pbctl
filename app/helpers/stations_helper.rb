module StationsHelper
  include ApplicationHelper

  def current_song
    Song.last
  end

  def cat_control_str(str)
    open(fifopath, 'a') { |f| f.puts str }
  end



end
