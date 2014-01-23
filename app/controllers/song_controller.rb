class SongController < ApplicationController
  include StationsHelper

  def index
    @song = Song.paginate(page: params[:page], :order => 'created_at DESC')
  end
  
  def togglepause
    cat_control_str('p')
    after_action
  end

  def start
    # Fifo path: /tmp/pbctl_fifo_control
    pianobarinit = system("scripts/initialize_pianobar.bash \"#{pwd}\"")
    cat_control_str('P')
    after_action
  end

  def pause
    cat_control_str('S')
    after_action
  end

  def skip
    cat_control_str('n')
    after_action
  end

  def like
    cat_control_str('+')
    after_action
  end

  def dislike
    cat_control_str('-')
    after_action
  end

  def tired
    cat_control_str('t')
    after_action
  end

  def bookmarksong
    cat_control_str('bs')
    after_action
  end

  def volup
    cat_control_str(')))')
    after_action
  end
  
  def voldown
    cat_control_str('(((')
    after_action
  end

  def details
    redirect_to current_song.detail
    # @song = current_song
    # @details = fetch_url @song.detail
  end

  def description
    @song = current_song
  end

  def art
    @song = current_song
  end

  private

  def after_action
    redirect_to song_index_url
  end

  def fetch_url(url)
    response = Net::HTTP.get_response(URI.parse(url))
    if response.is_a? Net::HTTPSuccess
      response.body
    else
      nil
    end
  end

end
