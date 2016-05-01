class CitiesController < ApplicationController
  def show
    @city = City.find params[:id]
    @areas = @city.areas.paginate page: params[:page]
    uid = request.remote_ip + (current_user.nil? ? '':current_user.id.to_s)
    $redis.sadd("city-#{@city.id}", "#{uid}")
    @card = $redis.scard("city-#{@city.id}")

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
