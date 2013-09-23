class StationsController < ApplicationController

  def show
    @station = Station.find(params[:id])
  end

  def create
    @station = Station.new(station_params)
    if @station.save
      redirect_to @station
    else
      render 'new'
    end
  end

  def new
    @station = Station.new
  end

  def populate
    @station_list = ""
  end

  private

  def station_params
    params.require(:station).permit(:name, :index)
  end

end
