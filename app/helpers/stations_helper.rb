module StationsHelper

  def current_song
    Song.last
  end

  def process_fill(text)
    stationarray = []
    lastsong = Song.last
    newsong = Song.new
    text.each_line do |block|
      if block.match('station[0-9]+=.*')
        stationarray << block[/station[0-9]+=(.*)/,1]
      elsif block.match('coverArt=.*')
        # Cover Art
        newsong.art = block[/coverArt=(.*)/,1]
      elsif block.match('detailUrl=.*')
        # Detail Url
        newsong.detail = block[/detailUrl=(.*)/,1]
      elsif block.match('title=.*')
        # Title
        newsong.title = block[/title=(.*)/,1]
      elsif block.match('artist=.*')
        # Artist
        newsong.artist = block[/artist=(.*)/,1]
      elsif block.match('album=.*')
        # Album
        newsong.album = block[/album=(.*)/,1]
      elsif block.match('rating=[0-9]+')
        # Rating
        newsong.rating = block[/rating=([0-9]+)/,1]
      end
    end
    if !newsong.title.empty? && ( newsong.title != lastsong.title || newsong.artist != lastsong.artist || newsong.album != lastsong.album )
      newsong.save
    end
    #if stationarray.length > 0
    #  Station.delete_all
    #end
    # Use transaction to improve performance about 10 times
    ActiveRecord::Base.transaction do
      stationarray.length.times do |i|
        Station.create(name: stationarray[i], index: i)
      end
    end
  end

end
