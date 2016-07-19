class Dashing.Babbler_location extends Dashing.Widget

  # Overrides Dashing.Widget method in dashing.coffee
  @accessor 'updatedAtMessage', ->
    if updatedAt = @get('updatedAt')
      timestamp = new Date(updatedAt * 1000)
      hours = timestamp.getHours()
      minutes = ("0" + timestamp.getMinutes()).slice(-2)
      "Updated at #{hours}:#{minutes}"

  constructor: ->
    super

  onData: (data) ->
    console.log(data.id)
    babbler = data.id
    width = 350
    height = 350
    projection = d3.geo.orthographic().translate([
      width / 2
      height / 2
      ]).scale(width / 2 - 20).clipAngle(90).precision(0.6)
    $(@node).children("canvas").remove()
    canvas = document.createElement("canvas")
    canvas.setAttribute("id", babbler);
    canvas.setAttribute('height',height)
    canvas.setAttribute('width',width)
    $(@node).append(canvas)

    c = canvas.getContext('2d')
    path = d3.geo.path().projection(projection).context(c)
    title = d3.select('h1')

    ready = (error, world, names) ->
      if error
        throw error
      globe = type: 'Sphere'
      land = topojson.feature(world, world.objects.land)
      countries = topojson.feature(world, world.objects.countries).features
      borders = topojson.mesh(world, world.objects.countries, (a, b) ->
        a != b
      )
      i = -1
      n = countries.length
      d3.transition().duration(1250).tween('rotate', ->
        p = data.babbler_location
        # p = [
        #   6.13440425365058
        #   51.3903640883854
        # ]
        r = d3.interpolate(projection.rotate(), [
          -p[0]
          -p[1]
        ])
        console.log p
        (t) ->
          projection.rotate r(t)
          c.clearRect 0, 0, width, height
          c.fillStyle = '#ccc'
          c.beginPath()
          path(land)
          c.fill()
          c.fillStyle = '#f00'
          c.beginPath()
          path(countries[i])
          c.fill()
          c.strokeStyle = '#fff'
          c.lineWidth = .5
          c.beginPath()
          path(borders)
          c.stroke()
          c.strokeStyle = '#000'
          c.lineWidth = 2
          c.beginPath()
          path(globe)
          c.stroke()
          return
      )()
      return

    queue().defer(d3.json, '../raw/world-110m.json').await ready
      

