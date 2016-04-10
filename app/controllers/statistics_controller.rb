class StatisticsController < ApplicationController
  def index
    @result=get_statistics_avg_cities_users
  end
end
