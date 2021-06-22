#!/usr/bin/env ruby
require 'bunny'

# start connection with bunny
connection = Bunny.new(user: 'user', password: 'pwd')
connection.start

# create channel and queue
channel = connection.create_channel
queue = channel.queue('hello')


begin
  puts ' [*] Waiting for messages. To exit press CTRL+C'
  queue.subscribe(block: true) do |delivery_info, properties, body|
    puts delivery_info
    puts properties
    puts " [x] Received #{body}"
  end
rescue Interrupt => _
  connection.close

  exit(0)
end
