#!/usr/bin/env ruby

require 'bunny'

# start connection with bunny
connection = Bunny.new(user: 'user', password: 'pwd')
connection.start

# create channel and queue
channel = connection.create_channel
queue = channel.queue('task_queue', durable: true)

message = ARGV.empty? ? 'Hello World!' : ARGV.join(' ')
queue.publish(message, persistent: true)
puts " [x] Sent #{message}"

connection.close




