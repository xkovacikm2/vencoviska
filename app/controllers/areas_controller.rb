class AreasController < ApplicationController
  before_action :logged_in_user, only:[:create, :new]
  def new
    @city = City.find params[:id]
    @area = @city.areas.new
    @colors = AreaColor.all
  end

  def show
    @area = Area.find params[:id]
    @comments = @area.comments.paginate page: params[:page]
    @comments = @comments.paginate(page: params[:page])
    @colors = AreaColor.all

    @comment = @area.comments.build

    @card = unique_visits "area-#{@area.id}"
    cache_location if logged_in?
  end

  def create
    @area = current_user.areas.build area_params
    if @area.save
      flash[:success] = "Zona #{@area.name} úspešne vytvorená"
      store_activity 'vytvoril/a oblasť', @area, @area.name
      redirect_to @area
    else
      redirect_to 'new'
    end
  end

  def destroy

  end

################################
  private
################################

  def area_params
    params.require(:area).permit(:name, :description, :city_id, :area_color_id, :geom)
  end

end
