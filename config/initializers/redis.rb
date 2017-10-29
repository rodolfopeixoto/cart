# frozen_string_literal: true

begin
  $redis = Redis.new(host: 'redis', port: 6379, driver: :hiredis) 
rescue Exception => e
  puts e
end