class AreasController < ApplicationController
  def show
    @area = Area.find params[:id]
    @comments = @area.comments.paginate page: params[:page]
    @comment = @area.comments.build
    store_location if logged_in?
  end

  def create

  end

  def destroy

  end
end
