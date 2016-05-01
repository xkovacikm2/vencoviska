class CommentsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]

  def create
    @comment = current_user.comments.build comment_params
    if @comment.save
      flash[:success] = "Komentar vytvoreny!"
      $redis.del("comments-#{comment.area.id}")
      redirect_back current_user
    else
      flash[:danger] = "Nieco zlyhalo!"
      redirect_back current_user
    end
  end

  def destroy
    comment = Comment.find(params[:id])
    $redis.del("comments-#{comment.area.id}")
    comment.destroy
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
