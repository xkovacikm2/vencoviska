class StaticPagesController < ApplicationController
  def home
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
