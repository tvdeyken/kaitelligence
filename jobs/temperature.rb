#!/usr/bin/env ruby
require 'net/http'
require 'json'

# The url you are tracking
sharedlink = URI::encode('www.iobridge.com')

datalink = URI::encode('/api/module/feed.json?key=cUzNFeQ1vVLW5ezKCP')

# :first_in sets how long it takes before the job is first run. In this case, it is run immediately
SCHEDULER.every '1m', :first_in => 0 do |job|
  http = Net::HTTP.new(sharedlink)
  response = http.request(Net::HTTP::Get.new(datalink))
  temp = JSON.parse(response.body)['module']['channels'].first['AnalogInput']
  send_event('it_temp', {value: temp })
end