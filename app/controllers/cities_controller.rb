class CitiesController < ApplicationController
  autocomplete :city, :name

  def show
    @city = City.find params[:id]
    @areas = @city.areas.paginate page: params[:page]

    @card = unique_visits "city-#{@city.id}"
    cache_location if logged_in?
  end

  def index
    if params[:search]
      @cities = City.paginate_by_sql("Select * from cities where name like '#{params[:search]}%'", page: params[:page])
    end
    cache_location if logged_in?
  end
end
