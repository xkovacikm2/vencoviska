class CommentsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]

  def create
    @comment = current_user.comments.build comment_params
    #TODO uncomment
    #if @comment.save
    if @comment.my_save
      flash[:success] = "Komentar vytvoreny!"
      redirect_back current_user
    else
      flash[:danger] = "Nieco zlyhalo!"
      redirect_back current_user
    end
  end

  def destroy
    Comment.find(params[:id]).destroy
    flash[:success] = "Komentar zmazaný"
    redirect_back current_user
  end

  ################################
  private
  ################################

  def comment_params
    params.require(:comment).permit(:content, :user_id, :area_id)
  end
end
