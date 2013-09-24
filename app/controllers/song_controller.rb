class SongController < ApplicationController
  include StationsHelper
  
  def pause
    redirect_to song_url
  end

  def skip
    redirect_to song_url
  end

  def like
    redirect_to song_url
  end

  def dislike
    redirect_to song_url
  end

  def details
    @song = current_song
  end

  def art
    @song = current_song
  end

end
