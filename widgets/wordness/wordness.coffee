class Dashing.Wordness extends Dashing.Widget

  @accessor 'value', Dashing.AnimatedValue

  constructor: ->
    super

  onData: (data) ->
    node = $(@node)
    value = data.value
    console.log(value)
    level = switch
      when value == 'OK' then 0
      when value == 'Busy' then 1
      when value == 'Warning' then 2
      when value == 'Error' then 4
      else 
        bucketSize = (warm - cool) / 3 # Total # of colours in middle
        Math.ceil (value - cool) / bucketSize
  
    backgroundClass = "wordness#{level}"
    lastClass = @get "lastClass"
    node.toggleClass "#{lastClass} #{backgroundClass}"
    @set "lastClass", backgroundClass
