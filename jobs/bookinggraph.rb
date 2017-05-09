require 'net/http'
require 'json'
require 'date'
require 'byebug'

# The url you are tracking
uri = URI.parse('https://booking.seaconlogistics.com')

datalink = URI::encode('/statistics/usage?days=7')

# :first_in sets how long it takes before the job is first run. In this case, it is run immediately
SCHEDULER.every '15m', :first_in => 0 do |job|

  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = true
  http.verify_mode = OpenSSL::SSL::VERIFY_NONE

  response = http.request(Net::HTTP::Get.new(datalink))

  booking_history = JSON.parse(response.body)

  # add empty dates
  today = Date.today()
  (today-6 .. today).each do |date|
    next if booking_history.key?(date.to_s)
    booking_history[date.to_s]=0
  end

  points = []
  booking_history.each do |date, bookings|
    unix_date = DateTime.parse(date).to_time.to_i
    points << {x: unix_date, y: bookings}
  end
  points = points.sort_by { |hsh| hsh[:x] }
  send_event('booking-history', points: points)
end
