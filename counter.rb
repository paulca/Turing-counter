require "sinatra"
require "victor"
require "redis"

get '/counter' do
  redis = Redis.new(url: ENV["REDIS_URL"] || "redis://127.0.0.1:6379")
  redis.incr("counter")

  content_type "image/svg+xml"
  svg = Victor::SVG.new viewBox: "0 0 700 70"

  svg.rect x: 0, y: 0, width: 700, height: 70, fill: '#ddd'
  svg.text redis.get("counter"), x: 100, y: 50, font_family: 'Helvetica', font_weight: 'bold', font_size: 40, fill: 'blue'

  svg.render
end