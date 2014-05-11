module PopulateHelper
  include ApplicationHelper
  
  # Gets the text from the pianobar information/eventtext file
  def get_event_text()
    File.read(eventtext_path)
  end
  
  # Processes the text from the pianobar information/eventtext file
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
      elsif block.match('stationName=.+')
        # Current station
        newsong.station = block[/stationName=(.+)/,1]
      end
    end
    if !lastsong || ( !newsong.title.empty? && ( newsong.title != lastsong.title || newsong.artist != lastsong.artist || newsong.album != lastsong.album ) )
      newsong.save
    else
      lastsong.update_attributes(rating: newsong.rating)
    end
    # If a station has been added or deleted, however it will not work if a station has been added AND a station has been deleted
    if stationarray.length > 0 && stationarray.length != Station.all.length
      Station.delete_all
      ActiveRecord::Base.transaction do
        stationarray.length.times do |i|
          Station.create(name: stationarray[i], index: i)
        end
      end
    end

    #if stationarray.length > 0
    #  Station.delete_all
    #end
    # Use transaction to improve performance about 10 times (I think this comment was for when I was repopulating the stations every time but I am not sure)
  end
end
