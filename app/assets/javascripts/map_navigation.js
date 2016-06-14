/**
 * Created by kovko on 14.6.2016.
 */
function moveTo(address, map){
    var geocoder = new google.maps.Geocoder();
    geocoder.geocode({'address': address+",Slovakia"}, function (results, status) {
        if (status == google.maps.GeocoderStatus.OK) {
            map.setCenter(results[0].geometry.location);
        } else {
            alert("Geocode was not successful for the following reason: " + status);
        }
    });
    map.zoom = 14;
}