/*Created by kovko on 14.6.2016.*/

function initDrawingMap() {
    var map = new google.maps.Map(document.getElementById('map-drawing-tool'), {
        center: {lat: 48.6724821, lng: 19.696058},
        zoom: 8
    });

    var drawingManager = new google.maps.drawing.DrawingManager({
        drawingMode: google.maps.drawing.OverlayType.POLYGON,
        drawingControl: true,
        drawingControlOptions: {
            position: google.maps.ControlPosition.TOP_CENTER,
            drawingModes: [
                google.maps.drawing.OverlayType.POLYGON,
            ]
        },
    });

    var address = $('.city_class').data('city').name;
    moveTo(address, map);
    drawingManager.setMap(map);

    google.maps.event.addListener(drawingManager, 'polygoncomplete', function (polygon) {
        var path = polygon.getPath();
        var encodeString = google.maps.geometry.encoding.encodePath(path);
        $('#area_geom').val(encodeString);
    });
}