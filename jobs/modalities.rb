# Populate the graph with some random points
points = []
(1..10).each do |i|
  points << { x: i, y: rand(50) }
end
last_x = points.last[:x]

SCHEDULER.every '2s' do
#   points.shift
#   last_x += 1
#   points << { x: last_x, y: rand(50) }



series = [
    {
        name: "Road",
        data: [{x:1483228800, y: 40}, {x:1485907200, y:270}, {x:1488326400, y:60},{x:1491004800,y:20},{x:1493596800,y:120},{x:1496275200,y:20}]
    },
    {
        name: "Intermodal",
        data: [{x:1483228800, y: 60}, {x:1485907200, y:326}, {x:1488326400, y:34},{x:1491004800,y:112},{x:1493596800,y:122},{x:1496275200,y:25}]
    }
]




  send_event('modalities', series: series)
end