if ENV["REDISCLOUD_URL"]
  $redis = Redis.new(:url => ENV["REDISCLOUD_URL"])
else
  $redis = Redis::Namespace.new("vencoviska", :redis => Redis.new)
end
