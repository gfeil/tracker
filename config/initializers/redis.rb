url = ENV['REDIS_URL'] || 'redis://localhost:6379'

REDIS = Redis.current = Redis.new(url: url)
