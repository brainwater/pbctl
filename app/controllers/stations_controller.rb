class StationsController < ApplicationController
  include StationsHelper
  include ApplicationHelper
  before_action :authenticated_redirect

  def index
    @stations = Station.paginate(page: params[:page])
  end

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

  def popfile
    @station_file = ""
  end

  def fillfile
    uploaded_file = params[:file]
    file_content = uploaded_file.read
    # puts file_content
    t1 = Time.now
    process_fill(file_content)
    t2 = Time.now
    te = t2 - t1
    puts "PROCESS FILE TIME"
    puts te
    redirect_to popfile_url
  end

  def play
    @station = Station.find(params[:id])
    cat_control_str("s#{@station.index}")
    redirect_to stations_url
  end

  protected

  def protect_against_forgery?
    if params[:file]
      return false
    else
      return allow_forgery_protection
    end
  end

  private

  def station_params
    params.require(:station).permit(:name, :index)
  end

end
