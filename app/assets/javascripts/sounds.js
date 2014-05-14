$(document).ready(function() {

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

    $('#current_location').click(function() {

  if ("geolocation" in navigator) {
    navigator.geolocation.getCurrentPosition(geolocationSuccess, geolocationError);
  } else {
    alert("Your browser doesn't support Geolocation. Use Google Chrome instead");
  }

  });


});