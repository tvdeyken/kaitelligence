class Dashing.Babbler_temp extends Dashing.Widget

  # Overrides Dashing.Widget method in dashing.coffee
  @accessor 'updatedAtMessage', ->
    if updatedAt = @get('updatedAt')
      timestamp = new Date(updatedAt * 1000)
      hours = timestamp.getHours()
      minutes = ("0" + timestamp.getMinutes()).slice(-2)
      "Updated at #{hours}:#{minutes}"

  constructor: ->
    super

  ready: ->
    # This is fired when the widget is done being rendered
    @setIcons()
