require 'net/http'
require 'json'

# The url you are tracking
uri = URI.parse('https://booking.seaconlogistics.com')

datalink = URI::encode('/statistics')

# :first_in sets how long it takes before the job is first run. In this case, it is run immediately
SCHEDULER.every '1m', :first_in => 0 do |job|

  http = Net::HTTP.new(uri.host, uri.port)

  http.use_ssl = true
  http.verify_mode = OpenSSL::SSL::VERIFY_NONE

  response = http.request(Net::HTTP::Get.new(datalink))

  processing_orders = JSON.parse(response.body)['processing_orders']
  send_event('bookings', {value: processing_orders })
end
