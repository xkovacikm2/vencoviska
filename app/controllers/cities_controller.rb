class CitiesController < ApplicationController
  def show
    @city = City.find params[:id]
    @areas = @city.areas.paginate page: params[:page]

    @card = unique_visits "city-#{@city.id}"
    cache_location if logged_in?
  end

  def index
    @cities = City.paginate page: params[:page]

    cache_location if logged_in?
  end

  def create

  end

  def destroy

  end
end
