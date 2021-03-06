class CitiesController < ApplicationController
  autocomplete :city, :name

  def show
    @city = City.find_by id: params[:id]
    return redirect_to not_found_path if @city.nil?
    @colors = AreaColor.all
    @areas = @city.areas.all

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
