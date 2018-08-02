require "sinatra"
require "victor"
require "redis"

def connect_to_redis
  $redis = Redis.new(url: ENV["REDIS_URL"] || "redis://127.0.0.1:6379")
end

def increment_the_counter
  $redis.incr("counter")
end

def generate_svg
  content_type "image/svg+xml"
  svg = Victor::SVG.new viewBox: "0 0 700 70"

  svg.rect x: 0, y: 0, width: 700, height: 70, fill: '#ddd'
  svg.text $redis.get("counter"), x: 100, y: 50, font_family: 'Helvetica', font_weight: 'bold', font_size: 40, fill: 'blue'

  svg.render
end

connect_to_redis

get '/counter' do
  increment_the_counter
  generate_svg
end