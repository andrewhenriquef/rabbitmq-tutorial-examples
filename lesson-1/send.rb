#!/usr/bin/env ruby

require 'bunny'

# start connection with bunny
connection = Bunny.new(user: 'user', password: 'pwd')
connection.start

# create channel and queue
channel = connection.create_channel
queue = channel.queue('hello')

channel.default_exchange.publish('Hello World!', routing_key: queue.name)
puts " [x] Sent 'Hello World!'"

connection.close


