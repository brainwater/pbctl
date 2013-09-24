module StationsHelper

  def current_song
    Song.last
  end

  def process_fill(text)
    stationarray = []
    Song.create
    text.each_line do |block|
      if block.match('station[0-9]+=.*')
        stationarray << block[/station[0-9]+=(.*)/,1]
      elsif block.match('coverArt=.*')
        # Cover Art
        current_song.update_attributes(art: block[/coverArt=(.*)/,1])
      elsif block.match('detailUrl=.*')
        # Detail Url
        current_song.update_attributes(detail: block[/detailUrl=(.*)/,1])
      elsif block.match('title=.*')
        # Title
        current_song.update_attributes(title: block[/title=(.*)/,1])
      elsif block.match('artist=.*')
        # Artist
        current_song.update_attributes(artist: block[/artist=(.*)/,1])
      elsif block.match('album=.*')
        # Album
        current_song.update_attributes(album: block[/album=(.*)/,1])
      elsif block.match('rating=[0-9]+')
        # Rating
        current_song.update_attributes(rating: block[/rating=([0-9]+)/,1])
      end
    end
    if stationarray.length > 0
      Station.delete_all
    end
    stationarray.length.times do |i|
      Station.create(name: stationarray[i], index: i)
    end
  end

end
