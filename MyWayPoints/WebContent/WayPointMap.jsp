<!DOCTYPE html>
<html>
  <head>
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no">
    <meta charset="utf-8">
    <title>WayPoints</title>
    <style>
      /* Always set the map height explicitly to define the size of the div
       * element that contains the map. */
      #map {
        height: 100%;
      }
      /* Optional: Makes the sample page fill the window. */
      html, body {
        height: 100%;
        margin: 0;
        padding: 0;
      }
      #floating-panel {
        position: absolute;
        top: 10px;
        left: 25%;
        z-index: 5;
        background-color: #fff;
        padding: 5px;
        border: 1px solid #999;
        text-align: center;
        font-family: 'Roboto','sans-serif';
        line-height: 30px;
        padding-left: 10px;
      }
      #warnings-panel {
        width: 100%;
        height:10%;
        text-align: center;
      }
    </style>
  </head>
  <body>
    <div id="floating-panel">
    <b>Start: </b>
    <select id="start">
      <option value=""> -- select an option -- </option>
      <option value="buffalo, ny">Buffalo, NY</option>
      <option value="chicago, il">Chicago, IL</option>
      <option value="new york">New York City</option>
      <option value="washington D.C.">Washington D.C.</option>
      <option value="oklahoma city, ok">Oklahoma City, OK</option>
      <option value="Dallas, tx">Dallas, TX</option>
      <option value="Miami, fl">Miami, FL</option>
      <option value="pheonix, az">Pheonix, AZ</option>
      <option value="seattle, wa">Seattle, WA</option>
      <option value="Atlanta, ga">Atlanta, GA</option>
      <option value="boston, ma">Boston, MA</option>
      <option value="New Orleans, la">New Orleans, LA</option>
      <option value="los angeles, ca">Los Angeles</option>
      <option value="Charlotte, nc">Charlotte, NC</option>
      <option value="Salt Lake City, ut">Salt Lake City, ut</option>
      <option value="Houston, tx">Houston, TX</option>
      <option value="st. louis, mo">St. Louis, MO</option>
      <option value="Kansas City, mo">Kansas City, MO</option>
      <option value="Indianapolis, IA">Indianapolis, IA</option>
      <option value="Denver, CO">Denver, CO</option>
      <option value="Minneapolis, MN">Minneapolis, MN</option>
      <option value="San Francisco, CA">San Francisco, CA</option>
      <option value="Detroit, MI">Detroit, MI</option>
      <option value="Cleveland, OH">Cleveland, OH</option>
      <option value="Philadelphia, PA">Philadelphia, PA</option>
      <option value="San Diego, CA">San Diego, CA</option>
      <option value="Las Vegas, NV">Las Vegas, NV</option>
      <option value="Pittsburgh, PA">Pittsburgh, PA</option>
      <option value="Albuquerque, NM">Albuquerque, NM</option>
      <option value="Portland, OR">Portland, OR</option>
      <option value="Norfolk, VA">Norfolk, VA</option>
      <option value="Memphis, TN">Memphis, TN</option>
      <option value="Milhaukee, WI">Milhaukee, WI</option>
      <option value="Orlando, fl">Orlando, fl</option>
      <option value="Lincoln, NE">Lincoln, NE</option>
    </select>
    <b>End: </b>
    <select id="end">
      <option value=""> -- select an option -- </option>
      <option value="new york">New York City</option>
      <option value="chicago, il">Chicago, IL</option>
      <option value="washington D.C.">Washington D.C.</option>
      <option value="oklahoma city, ok">Oklahoma City, OK</option>
      <option value="Dallas, tx">Dallas, TX</option>
      <option value="Miami, fl">Miami, FL</option>
      <option value="pheonix, az">Pheonix, AZ</option>
      <option value="seattle, wa">Seattle, WA</option>
      <option value="Atlanta, ga">Atlanta, GA</option>
      <option value="boston, ma">Boston, MA</option>
      <option value="New Orleans, la">New Orleans, LA</option>
      <option value="los angeles, ca">Los Angeles</option>
      <option value="Charlotte, nc">Charlotte, NC</option>
      <option value="Salt Lake City, ut">Salt Lake City, ut</option>
      <option value="Houston, tx">Houston, TX</option>
      <option value="st. louis, mo">St. Louis, MO</option>
      <option value="Kansas City, mo">Kansas City, MO</option>
      <option value="buffalo, ny">Buffalo, NY</option>
      <option value="Indianapolis, IA">Indianapolis, IA</option>
      <option value="Denver, CO">Denver, CO</option>
      <option value="Minneapolis, MN">Minneapolis, MN</option>
      <option value="San Francisco, CA">San Francisco, CA</option>
      <option value="Detroit, MI">Detroit, MI</option>
      <option value="Cleveland, OH">Cleveland, OH</option>
      <option value="Philadelphia, PA">Philadelphia, PA</option>
      <option value="San Diego, CA">San Diego, CA</option>
      <option value="Las Vegas, NV">Las Vegas, NV</option>
      <option value="Pittsburgh, PA">Pittsburgh, PA</option>
      <option value="Albuquerque, NM">Albuquerque, NM</option>
      <option value="Portland, OR">Portland, OR</option>
      <option value="Norfolk, VA">Norfolk, VA</option>
      <option value="Memphis, TN">Memphis, TN</option>
      <option value="Milhaukee, WI">Milhaukee, WI</option>
      <option value="Orlando, fl">Orlando, fl</option>
      <option value="Lincoln, NE">Lincoln, NE</option>
    </select>
    </div>
    <div id="map"></div>
    &nbsp;
    <div id="warnings-panel"></div>
    <script type="text/javascript" src="https://maps.googleapis.com/maps/api/js">
    </script>
    
    <script>
    var openweatherkey="openweatherkey";
      function initMap() {
        var markerArray = [];
        console.log("FUK");
        // Instantiate a directions service.
        var directionsService = new google.maps.DirectionsService;

        // Create a map and center it on University at Buffalo.
        var map = new google.maps.Map(document.getElementById('map'), {
          zoom: 13,
          center: {lat: 43.0008, lng: -78.7890}
        });

        // Create a renderer for directions and bind it to the map.
        var directionsDisplay = new google.maps.DirectionsRenderer({map: map});

        // Instantiate an info window to hold step text.
        var stepDisplay = new google.maps.InfoWindow;

        // Display the route between the initial start and end selections.
        calculateAndDisplayRoute(directionsDisplay, directionsService, markerArray, stepDisplay, map);
        
        // Listen to change events from the start and end lists.
        var onChangeHandler = function() {
          calculateAndDisplayRoute(directionsDisplay, directionsService, markerArray, stepDisplay, map);
        };
        document.getElementById('start').addEventListener('change', onChangeHandler);
        document.getElementById('end').addEventListener('change', onChangeHandler);
      }

      function calculateAndDisplayRoute(directionsDisplay, directionsService,markerArray, stepDisplay, map) {
        // First, remove any existing markers from the map.
        if(document.getElementById('start').value!="" && document.getElementById('end').value!=""){
        for (var i = 0; i < markerArray.length; i++) {
          markerArray[i].setMap(null);
        }

        // Retrieve the start and end locations and create a DirectionsRequest using DRIVING directions.
        directionsService.route({
          origin: document.getElementById('start').value,
          destination: document.getElementById('end').value,
          travelMode: 'DRIVING'
        }, function(response, status) {
          // Route the directions and pass the response to a function to create markers for each step.
          if (status === 'OK') {
            document.getElementById('warnings-panel').innerHTML = '<b>' + response.routes[0].warnings + '</b>';
            directionsDisplay.setDirections(response);
            showSteps(response, markerArray, stepDisplay, map);
          } 
          else {
        	//error-failed
            window.alert('Directions request failed due to ' + status);
          }
        });
        }
      }

      function showSteps(directionResult, markerArray, stepDisplay, map) {
        // At each step, place a marker, and add the text to the marker's infowindow.
        // Also attach the marker to an array so we can keep track of it and remove it for calculating new routes.
        var myRoute = directionResult.routes[0].legs[0];
        for (var i = 0; i < myRoute.steps.length; i++) {
          var marker = markerArray[i] = markerArray[i] || new google.maps.Marker;
          marker.setMap(map);
          marker.setPosition(myRoute.steps[i].start_location);
          var arr=(myRoute.steps[i].start_location.toString()).split(",");
          var lat=arr[0].substr(1);
          //var l1=lat.substring(0, 4);
          var lon=arr[1].slice(1,-1);
          //var l2=lon.substring(1,4);
          var name;
          var temp;
          var jsontext;
          try{
        	  dataurl="https://api.openweathermap.org/data/2.5/weather?lat="+lat.toString()+"&lon="+lon.toString()+"&appid="+openweatherkey;
              var xhr =new XMLHttpRequest();
              xhr.open("GET", dataurl, false);
              xhr.send();
              jsontext=JSON.parse(xhr.responseText); 
        	  temp=jsontext.main.temp - 273;
        	  name=(jsontext.name).toString();
          }
          catch(Exception){temp=Exception.toString()}
          var temps=temp.toString();
          attachInstructionText(stepDisplay, marker, "City="+name.toString()+";\nTemp="+temps.substring(0,4)+"C", map);
        }
      }
      
      function attachInstructionText(stepDisplay, marker, text, map) {
        google.maps.event.addListener(marker, 'click', function() {
          // Open an info window when the marker is clicked on, containing the weather information.
          stepDisplay.setContent(text);
          stepDisplay.open(map, marker);
        });
      }
  
    </script>
    <script async defer
    src="https://maps.googleapis.com/maps/api/js?key=GoogleMapsDirectionsKey&callback=initMap">
    </script>
  </body>
</html>