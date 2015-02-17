# Description

Simple [Dashing](http://shopify.github.com/dashing) widget that tracks time since a certain event. Time Since Last waits for request to be made to your instance of Dashing and will then reset the time since the last occurrence of whatever event you would like to track. An example could be the time since the last exception for one of your applications, or the time since the last accident on the workfloor (better keep that widget green)!

The widget was made by [@hannesfostie](http://twitter.com/hannesfostie) for use [@openminds](http://www.openminds.be). If you end up using this widget, please send me a tweet! I'd love to hear about it.

# Dependencies

This widget requires HTML5's localStorage in order to keep track of the last time the event occurred in order for it to work across restarts and refreshes.

I also use [Moment.js](http://momentjs.com/) for easier date objects, and to display the time like `a few seconds ago` rather than something ugly. If you are not a fan of this, I'm sure you can figure out how to remove this. If not, get in touch!

# Usage

To use this widget, copy `time_since_last.html`, `time_since_last.coffee`, and `time_since_last.scss` into the `/widgets/time_since_last` directory.

To include the widget in a dashboard, add the following snippet to the dashboard layout file:
```
<li data-row="1" data-col="1" data-sizex="1" data-sizey="1">
  <div data-id="time_since_last" data-view="TimeSinceLast" data-title="Time since last event" data-green-after="60"></div>
</li>
```

# Settings

The `data-green-after`-attribute of the widget takes a number in seconds that have to pass in order for the widget to turn green. You can remove this, and the widget will default to turning the widget green after 100 seconds.

# Making things look nice

I made one extra modification to the widget, but I decided to describe it here because it requires additional javascript libraries which you may or may not want to include. In any case this step is not really required, but I prefer to add it.

The second uses [RainbowVis-JS](https://github.com/anomal/RainbowVis-JS) to set the background color to a color between two (or more!) colors of your choosing. I changed the backgroundColor function to achieve this. In my case:

```
 backgroundColor: =>
    if ($(@node).data('green-after'))
      greenAfter = parseInt($(@node).data('green-after'))
    else
      greenAfter = 100

    diff = moment().unix() - moment(@last_event).unix()
    if (diff > greenAfter)
      "#4d9e45"
    else
      rainbow = new Rainbow().setSpectrum('#e84916', '#4d9e45');
      '#'+rainbow.colourAt(diff / greenAfter * 100)
```

# Contributing

Have tips on making this better? Please leave a comment and/or fork the gist. Sending me a tweet on Twitter is probably a good idea as well!
