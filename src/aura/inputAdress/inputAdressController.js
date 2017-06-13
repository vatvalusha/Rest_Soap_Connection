({
    "save": function (component, event,helper) {
        helper.saveHelper(component,event);
    },

    navigate: function (component) {
        alert("Hello i am function ");
    },
    doInit: function (cmp, event, helper) {
        helper.doInitHelper(cmp);
    },
    Update: function (component, event, helper) {
        helper.UpdateHelper(component);
    },
    showCaseDeleteModal: function (component, event, helper) {
       helper.showCaseDeleteModalHelper(component,event);
    }
})