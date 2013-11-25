#!/usr/bin/env ruby
require 'net/http'
require 'json'

# The url you are tracking
sharedlink = URI::encode('bcchanger.com')
datalink = URI::encode('/bitcoin_price_feed.php?feed_type=json&currency=EUR')

# :first_in sets how long it takes before the job is first run. In this case, it is run immediately
SCHEDULER.every '1m', :first_in => 0 do |job|
  http = Net::HTTP.new(sharedlink)
  response = http.request(Net::HTTP::Get.new(datalink))
  bc = JSON.parse(response.body)['BTC']['value']
  send_event('bitcoin', {value: bc })
end