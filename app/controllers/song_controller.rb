class SongController < ApplicationController
  include StationsHelper

  def index
    @song = Song.paginate(page: params[:page], :order => 'created_at DESC')
  end
  
  def pause
    cat_control_str('p')
    redirect_to song_index_url
  end

  def skip
    cat_control_str('n')
    redirect_to song_index_url
  end

  def like
    cat_control_str('+')
    redirect_to song_index_url
  end

  def dislike
    cat_control_str('-')
    redirect_to song_index_url
  end

  def volup
    cat_control_str(')')
    redirect_to song_index_url
  end
  
  def voldown
    cat_control_str('(')
    redirect_to song_index_url
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
