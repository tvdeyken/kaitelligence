class Dashing.Babbler_seal extends Dashing.Widget

  # Overrides Dashing.Widget method in dashing.coffee
  @accessor 'updatedAtMessage', ->
    if updatedAt = @get('updatedAt')
      timestamp = new Date(updatedAt * 1000)
      hours = timestamp.getHours()
      minutes = ("0" + timestamp.getMinutes()).slice(-2)
      "Updated at #{hours}:#{minutes}"

  onData: (data) ->
    node = $(@node)
    console.log(data)
    seal_status = data.seal_status
    level = switch
      when seal_status == 'Unsealed' then 0
      when seal_status == 'Sealed' then 1
      when seal_status == 'Broken' then 4
      else 
        4
  
    backgroundClass = "sealstatus#{level}"
    lastClass = @get "lastClass"
    node.toggleClass "#{lastClass} #{backgroundClass}"
    @set "lastClass", backgroundClass

  constructor: ->
    super
