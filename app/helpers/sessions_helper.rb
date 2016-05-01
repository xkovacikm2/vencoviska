module SessionsHelper

  ######################
  #Log in helper methods
  ######################

  def log_in (user)
    session[:user_id] = user.id
  end

  def remember (user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by id: user_id
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by id: user_id
      if user && user.authenticated?(cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end

  def current_user?(user)
    current_user==user
  end

  def logged_in?
    !current_user.nil?
  end

  ######################
  #Log out helper methods
  ######################

  def log_out
    forget current_user
    session.delete :user_id
    @current_user = nil
  end

  def forget(user)
    user.forget
    cookies.delete :user_id
    cookies.delete :remember_token
  end

  ###################################
  #Friendly forwarding helper methods
  ###################################

  def redirect_back(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete :forwarding_url
  end

  def store_location
    session[:forwarding_url] = request.url if request.get?
  end

  ###################################
  #Caching last 10 visited pages
  ###################################

  def cache_location
    $redis.lpush("user-pages-#{@current_user.id}", request.url)
    $redis.ltrim("user-pages-#{@current_user.id}", 0, 9)
  end
end
