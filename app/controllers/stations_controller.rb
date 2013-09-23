class StationsController < ApplicationController
  include StationsHelper
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

  def fill
    @station_list = params[:text]
    puts @station_list
    process_fill(@station_list)
  end

  private

  def station_params
    params.require(:station).permit(:name, :index)
  end

end
