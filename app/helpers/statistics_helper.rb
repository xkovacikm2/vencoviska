module StatisticsHelper

  def unique_visits(page_id)
    $redis.sadd page_id, request.remote_ip + (current_user.nil? ? '':current_user.id.to_s)
    $redis.scard page_id
  end
end
