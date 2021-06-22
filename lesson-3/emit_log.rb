#!/usr/bin/env ruby
require 'bunny'

connection = Bunny.new(user: 'user', password: 'pwd')
connection.start

channel = connection.create_channel
exchange = channel.fanout('logs')

message = ARGV.empty? ? 'Hello World!' : ARGV.join(' ')

exchange.publish(message)
puts " [x] Sent #{message}"

connection.close

# to create the log file
# ruby receive_logs > logs_from_rabbit.log
