require "bunny"

def publish(str)
  conn = Bunny.new
  conn.start
  
  ch   = conn.create_channel
  x    = ch.fanout("incidents")
  
  x.publish(str)
  puts " [x] Sent #{str}"
end
