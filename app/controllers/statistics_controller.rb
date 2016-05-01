class StatisticsController < ApplicationController
  def index
    @result=get_statistics_avg_cities_users

    cache_location if logged_in?
  end
end
