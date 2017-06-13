/**
 * Created by new on 26.05.2017.
 */
({
    doInitHelper: function (cmp) {
        var attributeValue = cmp.get("c.currentAdress");
        attributeValue.setParams({"id": cmp.get("v.recordId")});
        attributeValue.setCallback(this, function (response) {
            var stringResult = response.getReturnValue();
            cmp.set("v.AccountAdress", stringResult);
        });
        $A.enqueueAction(attributeValue);
    },

    UpdateHelper: function (component, event) {
        component.set('v.Flag', true);
    },
    showCaseDeleteModalHelper: function (component, event) {
        debugger;
        var Myevent = $A.get("e.c:AddressSelected");
        var fff = event.target.id;
        Myevent.setParams({"address": event.target.id.lat});
        Myevent.fire();
    },

    saveHelper: function (component, event) {
        var jopa;
        var action = component.get("c.saveAdress");
        action.setParams({"adress": component.get("v.AccountAdress"), "id": component.get("v.recordId")});

        action.setCallback(this, function (response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                // debugger;
                jopa = response.getReturnValue();
                component.set("v.wrapper", jopa);
                component.set("v.Flag", jopa.flag);

                if (component.get("v.Flag") == true) {
                    alert("Redirect");
                    window.location.href = '/' + component.get("v.recordId");
                }
                if (jopa.wrapperInners.length > 0) {
                    debugger;
                    component.set("v.menuAddress", true);
                    var event = $A.get("e.c:AddressLoaded");
                    event.setParams({"addresses": jopa, "recordId": component.get('v.recordId')});
                    event.fire();
                }
                if (jopa.wrapperInners.length == 0) {
                    component.set("v.menuAddress", false);
                }
            }
        });

        $A.enqueueAction(action);
    }
})