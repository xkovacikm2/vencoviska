module StatisticsHelper
  def unique_visits(page_id)
    $redis.sadd page_id, request.remote_ip + (current_user.nil? ? '':current_user.id.to_s)
    $redis.scard page_id
  end

  def store_activity(name, model=nil, link_name=nil)
    link = view_context.link_to link_name, model unless model.nil? or link_name.nil?
    activity = current_user.activities.build name:name, link: link
    $redis.lpush("activities", activity.to_json)
    $redis.ltrim("activities", 0, 100)
  end
end
