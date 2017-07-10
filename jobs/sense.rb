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
        name: "bottom",
        data: [{x:1, y: 0}, {x:2, y:100}, {x:3, y:200},{x:4,y:400},{x:5,y:900},{x:6,y:1200}]
    },
    {
        name: "actual",
        data: [{x:1, y: 0}, {x:2, y:0}, {x:3, y:0},{x:4,y:50},{x:5,y:90},{x:6,y:120}]
    },
    {
        name: "top",
        data: [{x:1, y: 0}, {x:2, y:0}, {x:3, y:0},{x:4,y:100},{x:5,y:1800},{x:6,y:2200}]
    }
    
]




  send_event('sense', series: series)
end