/**
 * Created by new on 24.05.2017.
 */

({
    // jsLoaded: function (component, event, helper) {
    //
    //     setTimeout(function () {
    //         // var mapUrl = 'https://server.arcgisonline.com/ArcGIS/rest/services/World_Street_Map/MapServer/tile/{z}/{y}/{x}';
    //         var map = L.map('map', {zoomControl: true}).setView([53.8482145, 27.6393256], 2);
    //         // L.tileLayer('https://server.arcgisonline.com/ArcGIS/rest/services/World_Street_Map/MapServer/tile/{z}/{y}/{x}',
    //         // {
    //         //     attribution: 'Tiles © Esri'
    //         // }).addTo(map);
    //         L.tileLayer('https://server.arcgisonline.com/ArcGIS/rest/services/World_Street_Map/MapServer/tile/{z}/{y}/{x}',
    //             {
    //                 attribution: 'Tiles © Esri'
    //             }).addTo(map);
    //         component.set("v.map", map);
    //     });
    // },


    addressLoaded: function (component, event, helper) {
        // helper.checkMap(component);
        helper.checkMapRemove(component);
        var map =  helper.initMapHelper(component);
        helper.setMarkersHelper(component,event,map);
    },
    addressSelected: function (component, event, helper) {
        helper.addressSelectedHelper(component, event);
    }
})