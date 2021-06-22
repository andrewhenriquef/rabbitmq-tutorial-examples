#!/usr/bin/env ruby
require 'bunny'

# start connection with bunny
connection = Bunny.new(user: 'user', password: 'pwd')
connection.start

# create channel and queue
channel = connection.create_channel
queue = channel.queue('task_queue', durable: true)
channel.prefetch(1)

begin
  puts ' [*] Waiting for messages. To exit press CTRL+C'
  queue.subscribe(manual_ack: true, block: true) do |delivery_info, _properties, body|
    puts " [x] Received #{body}"
    # imitate some work
    sleep body.count('.').to_i
    puts ' [x] Done'
    channel.ack(delivery_info.delivery_tag)
  end
rescue Interrupt => _
  connection.close

  exit(0)
end

