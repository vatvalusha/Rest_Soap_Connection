/**
 * Created by new on 26.05.2017.
 */
({
    checkMapRemove: function (component) {
        debugger;

        var map = component.get('v.map');
        if (map != null || map !=undefined) {

            alert('before')
            // component.set('v.map','');
            // document.getElementById("map").outerHTML = "";
            alert('after');

        }
    },
    checkMap : function (component, event) {
        if (component.get('v.map') != null) {
            var element = document.getElementById("map");
            element.parentNode.removeChild(element);
            var div = document.createElement('div');
            div.innerHTML = "<strong>Ура!</strong> Вы прочитали это важное сообщение.";
            div.id = 'map';
            var paparasha =  document.body;
            paparasha.insertBefore(div, document.body.firstChild);
        }
    },
    addressSelectedHelper : function (component, event) {
        debugger;
        var map = component.get('v.map');
        var address = event.getParam("address");
        function onClick(e) {
            alert(address.lat + ' between ' + address.lng);
        }
        map.on('click', onClick());
        map.panTo([address.lat, address.lng]);
    },

    initMapHelper : function (component) {
        debugger;
        var map = new L.map('map', {zoomControl: true}).setView([53.8482145, 27.6393256], 2);
        L.tileLayer('https://server.arcgisonline.com/ArcGIS/rest/services/World_Street_Map/MapServer/tile/{z}/{y}/{x}',
            {
                attribution: 'Tiles © Esri'
            }).addTo(map);
        component.set("v.map", map);
        return map;
    },

    setMarkersHelper: function(component, event, map){
        var addresses = event.getParam('addresses');
        for (var i = 0; i < addresses.wrapperInners.length; i++) {
            var address = addresses.wrapperInners[i];
            var latLng = [address.lat, address.lng];
            L.marker(latLng).bindPopup(address.adresses).addTo(map).on('click', onClick);

        }
        function onClick(e) {
            var action = component.get("c.changeAddress");
            action.setParams({"address": this.getPopup().getContent(), id: event.getParam('recordId')});
            window.location.href = '/' + event.getParam('recordId');
            $A.enqueueAction(action);
        }
    }
})