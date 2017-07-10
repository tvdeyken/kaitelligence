class Dashing.Eumap extends Dashing.Widget



  ready: ->
    container = $(@node).parent()

    width = (Dashing.widget_base_dimensions[0] * container.data("sizex")) + Dashing.widget_margins[0] * 2 * (container.data("sizex") - 1)
    height = (Dashing.widget_base_dimensions[1] * container.data("sizey"))

    # projection = d3.geo.albers()
    #   .scale(200)
    #   .translate([width / 2, height / 2 - 10])

    projection = d3.geo.azimuthalEqualArea()
      .rotate([0, 0])
      .center([10, 55])
      .scale(Math.min(width*1.1, height*1.2))
      .translate([width/2, height/2])

    path = d3.geo.path()
      .projection(projection)

    #create base svg object
    svg = d3.select(@node).append("svg")
      .attr("width", width)
      .attr("height", height)

    #add background
    svg.append("rect")
      .attr("class", "background")
      .attr("width", width)
      .attr("height", height)

    g = svg.append("g")

    #load map json
    d3.json("/eu.topojson", (error, eu) ->
      #add country outlines
      g.append("g")
          .attr("id", "europe")
        .selectAll("path")
          .data(topojson.feature(eu, eu.objects.europe).features)
        .enter().append("path")
          .attr("d", path)

      #add country borders
      g.append("path")
          .datum(topojson.mesh(eu, eu.objects.europe, (a, b) -> a != b ))
          .attr("id", "europe-borders")
          .attr("d", path)
    )



  onData: (data) ->
    if (Dashing.widget_base_dimensions)
      container = $(@node).parent()

      width = (Dashing.widget_base_dimensions[0] * container.data("sizex")) + Dashing.widget_margins[0] * 2 * (container.data("sizex") - 1)
      height = (Dashing.widget_base_dimensions[1] * container.data("sizey"))

      projection = d3.geo.azimuthalEqualArea()
        .rotate([0, 0])
        .center([10,55])
        .scale(Math.min(width*1.1, height*1.2))
        .translate([width/2, height/2])


      #on each update grab the existing svg node
      svg = d3.select(@node).select('svg')

      #select all the points on the map and merge with current data
      circle = svg.selectAll("circle")
        .data(data.points, (d) -> d.id )

      #for each new point, add a svg circle
      #I've left commented code to animate and base the circle radius on an optional size parameter
      circle.enter().append("circle")
        # .attr("r", (d) -> if d.size then 5 + parseInt(d.size,10)/(100*1024*1024) else 5)
        .attr('r', Math.min(.008*width, 5))
        .attr("class", (d) -> "point" + if d.type then ' '+d.type else '')
        .attr("transform", (d) -> "translate(" + projection([d.lon,d.lat]) + ")" )
        # .transition()
        #   .duration(1000)
        #   .attr('r', 5)
        # .transition()
        #   .delay(1000)
        #   .duration(30000)
        #   .style('opacity', .4)

      #remove points no longer in data set
      circle.exit().remove()

      #reorder points based on id
      #if new points will always have higher ids than existing points, this may not be necessary
      circle.order()

