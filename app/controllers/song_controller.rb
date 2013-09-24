class SongController < ApplicationController
  include StationsHelper

  def index
    @song = Song.paginate(page: params[:page], :order => 'created_at DESC')
  end
  
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
    redirect_to current_song.detail
    # @song = current_song
    # @details = fetch_url @song.detail
  end

  def art
    @song = current_song
  end

  private

  def fetch_url(url)
    response = Net::HTTP.get_response(URI.parse(url))
    if response.is_a? Net::HTTPSuccess
      response.body
    else
      nil
    end
  end

end
