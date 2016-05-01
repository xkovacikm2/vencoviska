class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update, :index, :destroy]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy

  def new
    @user=User.new
    @cities = City.all
  end

  def show
    @user=User.find params[:id]
    @comments = @user.comments.paginate page: params[:page]
    @pages = $redis.lrange("user-pages-#{@user.id}", 0, -1)

    @card = unique_visits "user-#{@user.id}"
    cache_location if logged_in?
  end

  def create
    @user=User.new user_params
    if @user.save
      log_in @user
      flash[:success] = "Vitajte vo Venčoviskách"
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
    @cities = City.all
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = "Profil aktualizovaný"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def index
    @users=User.paginate page: params[:page]
    @cities=City.all

    cache_location if logged_in?
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "Uživatel zmazaný"
    redirect_to users_url
  end

  ################################
  private
  ################################

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :description, :city_id, :birthday)
  end

  ### Before filters

  def correct_user
    @user = User.find(params[:id])
    redirect_to current_user unless current_user? @user
  end

  def admin_user
    redirect_to root_url unless current_user.admin?
  end
end
