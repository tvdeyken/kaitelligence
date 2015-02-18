class Dashing.TimeSinceLast extends Dashing.Widget

  ready: ->
    @last_event = moment(localStorage.getItem(@get('id')+'_last_event'))
    @last_event = moment() unless @last_event
    setInterval(@startTime, 500)
  onData: (data) ->
    localStorage.setItem(@get('id')+'_last_event', moment())
    @last_event = moment()
    @set('time_past', moment(@last_event).fromNow())
    $(@node).fadeOut().css('background-color', @backgroundColor).fadeIn()

  startTime: =>
    @set('time_past', moment(@last_event).fromNow())
    $(@node).css('background-color', @backgroundColor())

  backgroundColor: =>
    if (@get('data-red-after'))
      redAfter = parseInt(@get('data-red-after'))
    else
      redAfter = 10
    diff = moment().unix() - moment(@last_event).unix()
    if (diff > redAfter)
      "#e84916"
    else
      "#4d9e45"