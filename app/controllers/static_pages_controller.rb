class StaticPagesController < ApplicationController
  def home
    activities = $redis.lrange("activities", 0, -1);
    @activities = []
    activities.each do |activity|
      @activities.push JSON.load activity
    end
    cache_location if logged_in?
  end

  def help
    cache_location if logged_in?
  end

  def about
    cache_location if logged_in?
  end

  def contact
    cache_location if logged_in?
  end
end
