/**
 * Created by kovko on 14.6.2016.
 */
function initCityMap(){
    var map = new google.maps.Map(document.getElementById('map-city'), {
        center: {lat: 48.6724821, lng: 19.696058},
        mapTypeIds: [google.maps.MapTypeId.ROADMAP],
        zoom: 8
    });

    var infoBox = document.createElement('div');
    infoBox.innerHTML = "<div id='info-box'></div>";
    map.controls[google.maps.ControlPosition.RIGHT_TOP].push(infoBox);

    var address = $('.city_class').data('city').name;
    moveTo(address, map);
    var areas = $('.areas_class').data('areas');
    var colors = $('.colors_class').data('colors');
    areas.forEach(drawPolygon);

    function drawPolygon(element, index, array){
        var decodedString = google.maps.geometry.encoding.decodePath(element.geom);
        var polygon = new google.maps.Polygon({
            paths: decodedString,
            strokeColor: colors[element.area_color_id - 1].name,
            strokeOpacity: 0.8,
            strokeWeight: 2,
            fillColor: colors[element.area_color_id - 1].name,
            fillOpacity: 0.35
        });
        google.maps.event.addListener(polygon,"mouseover",function() {
            map.data.revertStyle();
            var box = $('#info-box');
            var appendix1 = '<p style="text-align: center;">' + element.name + ' </p><p style="color: '+ colors[element.area_color_id - 1].name +'; text-align: center;"> ' + colors[element.area_color_id - 1].description + "</p>";
            box.append(appendix1);
        });

        google.maps.event.addListener(polygon,"mouseout",function(){
            map.data.revertStyle();
            $('#info-box').empty();
        });
        google.maps.event.addListener(polygon,"click",function(){
            window.location.href = '/areas/'+element.id
        });
        polygon.setMap(map);
    }
}