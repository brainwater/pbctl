module StationsHelper

  def process_fill(text)
    stationarray = []
    text.each_line do |block|
      if block.match('station[0-9]+=.*')
        stationarray << block[/station[0-9]+=(.*)/,1]
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
