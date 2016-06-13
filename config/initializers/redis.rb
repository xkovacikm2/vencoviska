if ENV["REDISCLOUD_URL"]
  $redis = Redis.new(:url => 'redis://rediscloud:rVtn7Zs8RI80Eidt@pub-redis-14040.us-east-1-3.7.ec2.redislabs.com:14040')
end
