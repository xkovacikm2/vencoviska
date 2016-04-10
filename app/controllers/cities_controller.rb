class CitiesController < ApplicationController
  def show
    @city = City.find params[:id]
    @areas = @city.areas.paginate page: params[:page]
  end

  def index
    @cities = City.paginate page: params[:page]
  end

  def create

  end

  def destroy

  end
end
