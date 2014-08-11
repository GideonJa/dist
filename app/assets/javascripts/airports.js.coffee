# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


jQuery ->
  $('#from').autocomplete
    source: $('#from').data('autocomplete-source')
    change: ( event, ui ) ->
      console.log(ui.item)
      if $('#from').val() != "" && ui.item
        window.lat1 = parseFloat(ui.item.lat)
        window.lng1 = parseFloat(ui.item.lng)
        window.fromName1 = ui.item.name
      else if $('#from').val() != "" && !ui.item
          message = "<h4> Sorry, I don't recognize Origin airport <em> #{$('#from').val()} </em></h4>"
          $('.result').html(message)
      else
        message = "<h4> Please enter an Origin airport </h4>"
        $('.result').html(message)

  $('#to').autocomplete
    source: $('#to').data('autocomplete-source')
    change: ( event, ui ) ->
      if $('#to').val() != "" && ui.item
        window.lat2 = parseFloat(ui.item.lat)
        window.lng2 = parseFloat(ui.item.lng)
        window.fromName2 = ui.item.name
        if $('#from').val() != ""
          $('#search-button').trigger('click')
      else if $('#to').val() != "" && !ui.item
        message = "<h4> Sorry, I don't recognize destination airport <em> #{$('#to').val()} </em></h4>"
        $('.result').html(message)
      else
        message = "<h4> Please enter an Origin airport </h4>"
        $('.result').html(message)
      



  $('#search-button').click (event) ->
    event.preventDefault()
    if $('#from').val() == ""
      message = "<h4> Please enter an Origin airport </h4>"
    else if $('#to').val() == ""
      message = "<h4> Please enter a Destination airport </h4>"
    else
      R = 3958.76 
      latR1 = window.lat1.toRadians()
      latR2 = window.lat2.toRadians()
      dLat = (lat2-lat1).toRadians()
      dLng = (window.lng2-window.lng1).toRadians()
      a = Math.sin(dLat/2) * Math.sin(dLat/2) + Math.cos(latR1) * Math.cos(latR2) * Math.sin(dLng/2) * Math.sin(dLng/2)
      c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a))
      d = R * c
      d = d.toFixed(2)

      
      message = "<p> The distance from  <em>  #{window.fromName1} </em> to <em> #{window.fromName2} </em> is #{d} miles. </p>"
      fromLatlng = new google.maps.LatLng(window.lat1, window.lng1)
      toLatlng = new google.maps.LatLng(window.lat2, window.lng2)
      markerBounds = new google.maps.LatLngBounds(fromLatlng)
      markerBounds.extend(toLatlng)

      mapOptions = 
        center: fromLatlng,
        zoom: 5
    
      map = new google.maps.Map(document.getElementById("map-canvas"), mapOptions)
      markerFrom = new google.maps.Marker({ position: fromLatlng, title:"#{window.fromName1}" })
      markerTo = new google.maps.Marker({ position: toLatlng, title:"#{window.fromName2}" })
      map.fitBounds(markerBounds)
      markerFrom.setMap(map)
      markerTo.setMap(map)
      # markerMid.setMap(map)

      flightPlanCoordinates = [fromLatlng, toLatlng]
      flightPath = new google.maps.Polyline({
        path: flightPlanCoordinates,
        geodesic: true,
        strokeColor: '#FF0000',
        strokeOpacity: 1.0,
        strokeWeight: 2 })

      flightPath.setMap(map)
    $('.result').html(message)
  

