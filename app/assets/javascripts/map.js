var map;
var markers = [];
var coords = [];

function initializeMap() {

  var image = 'https://s3-us-west-2.amazonaws.com/allaboutdrama/echoes/images/icons/dark-blue-audio-icon.png';

  var addMarker = true && showMarker;
  var mapOptions = {
    zoom: 14,
    center: new google.maps.LatLng(latitude, longitude),
    mapTypeId: google.maps.MapTypeId.ROADMAP
  };
  map = new google.maps.Map($('#map-canvas')[0], mapOptions);

  if (addMarker) {
    var myMarker = new google.maps.Marker({
        position: new google.maps.LatLng(latitude, longitude),
        map: map,
        icon: image
    });

    markers.push(myMarker);
  }
}


function addMarkers(coords) {
  var image = 'https://s3-us-west-2.amazonaws.com/allaboutdrama/echoes/images/icons/dark-blue-audio-icon.png';

  coords.forEach(function(coord){
    var myMarker = new google.maps.Marker({
        position: new google.maps.LatLng(coord.latitude, coord.longitude),
        map: map,
        icon: image
    });
     markers.push(myMarker);
  });
}

function clearMarkers(){
  markers.forEach(function(marker){
    marker.setMap(null);
  });markers = [];
}


// geolocation
function geolocationSuccess(position) {
    var latitude = position.coords.latitude;
    var longitude = position.coords.longitude;

    $.ajax({
      url: "/sounds",
      method: 'GET',
      data: {
        latitude: latitude,
        longitude: longitude,
      },
      dataType: 'script'
    });
  }

function geolocationError(error) {
  console.log("There was an error :( ");
}

$(document).ready(function( ) {
  $('#current_location').on('click', function(event) {
    event.preventDefault();
    if ("geolocation" in navigator) {
      navigator.geolocation.getCurrentPosition(geolocationSuccess, geolocationError);
    } else {
      alert("Get a better browser!");
    }
  });

  if ($('#map-canvas').length > 0) {
    initializeMap();
    if (coords.length > 0) addMarkers(coords);
  }
});