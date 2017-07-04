require 'open-uri'
require 'date'
require 'cgi'
require 'icalendar'
require 'net/http'


def get_todays_events_from_calendar url
  calendar = Icalendar.parse(open(url))
  events = calendar.first.events.sort { |a,b| b.dtstart <=> a.dtstart }
  events.each_with_object([]) do |event, summaries|
    if DateTime.now.between?(Date.parse(event.dtstart.to_s), Date.parse(event.dtend.to_s))
      summaries.push(event.summary)
    end
  end
end

def events_to_text events
  events.join(" -- ")[0, 40]
end

SCHEDULER.every '10s' do
    # TODO: read from config
    calendar_url = "https://calendar.google.com/calendar/ical/seacon.mobi_hbr6hlsvua0btlbhjb0ji98gvc%40group.calendar.google.com/public/basic.ics"

    events = get_todays_events_from_calendar calendar_url
    text = events_to_text events

    send_event('calendar', {events: text })
end