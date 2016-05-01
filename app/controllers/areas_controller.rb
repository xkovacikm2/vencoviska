class AreasController < ApplicationController
  def show
    @area = Area.find params[:id]

    if !current_user.nil? && current_user.admin?
      @comments = @area.comments.paginate page: params[:page]
    else
      comments = $redis.get("comments-#{@area.id}")
      if comments.nil?
        comments = @area.comments.to_json
        $redis.set("comments-#{@area.id}", comments)
      end
      @comments = JSON.load(comments)
      @comments = @comments.paginate(page: params[:page])
    end
    @comment = @area.comments.build

    uid = request.remote_ip + (current_user.nil? ? '':current_user.id.to_s)
    $redis.sadd("area-#{@area.id}", "#{uid}")
    @card = $redis.scard("area-#{@area.id}")

    cache_location if logged_in?
  end

  def create

  end

  def destroy

  end
end
