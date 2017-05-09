class Dashing.Calendar extends Dashing.Widget

 
  onData: (data) =>
    
    if data["events"] is ""
      $('body').css 'margin-top', "-#{$(@node).parent('li').height() + 10}px"
    else
      $('body').css 'margin-top', "0px"
