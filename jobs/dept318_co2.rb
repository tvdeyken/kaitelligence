current_karma = 0

SCHEDULER.every '15s' do
  last_karma     = current_karma
  current_karma     = rand(200000)

  send_event('dept318_co2', { current: current_karma, last: last_karma })
end