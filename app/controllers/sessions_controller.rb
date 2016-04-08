class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_email params[:session][:email].downcase
    if can_log_in? user
      log_in user
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      redirect_to user
    else
      flash.now[:danger] = 'Nesprávne meno, alebo heslo!'
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_path
  end

  ################################
  private
  ################################

  def can_log_in? (user=nil)
    user && user.authenticate(params[:session][:password])
  end
end
