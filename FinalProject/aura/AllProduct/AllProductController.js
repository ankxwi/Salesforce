({
    doInit: function(component, event, helper) {
        let page = component.get("v.page") || 1;
        let recordToDisplay = component.get('v.recordToDisplay');
        let objs = component.get('v.objs');
        console.log(JSON.stringify(objs));
        helper.loadData(component, page, recordToDisplay,'', objs);
    },

    handleClick: function(component, event, helper) {
        let page = component.get("v.page") || 1;
        let productName = component.get('v.myEnterSearch');
        let recordToDisplay = component.get('v.recordToDisplay');
        let status = event.getSource().get('v.value');
        let a = event.getSource().get('v.label');
        let b = event.getSource().get('v.name');
        helper.augmentObject(component, a, b, status, page, recordToDisplay, productName);
    },

    handleKeyUp : function (component, event, helper) {
        if (event.which === 13) {
            let productName = component.get('v.myEnterSearch');
            console.log('ASdasdasdasP_@_#!#)'+productName);
            let page = component.get("v.page") || 1;
            let recordToDisplay = component.get('v.recordToDisplay');
            let objs = component.get('v.objs');
            helper.loadData(component, page, recordToDisplay, productName, objs);
        }
    },

    navigate : function(component, event, helper) {
        let page = component.get("v.page") || 1;
        let direction = event.getSource().get("v.label");
        let recordToDisplay = component.get('v.recordToDisplay');
        page = direction === "Previous Page" ? (page - 1) : (page + 1);
        let objs = component.get('v.objs');
        let productName = component.get('v.myEnterSearch');
        helper.loadData(component, page, recordToDisplay, productName, objs);
    },
    selectProduct : function(component, event, helper){
        let index = event.currentTarget.id;
        let products = component.get('v.Products');
        component.set('v.SelectedProduct', products[index]);
        console.log(products[index]);
    },
    onSelectChange : function(component, event, helper) {
        let page = 1;
        let recordToDisplay = component.get('v.recordToDisplay');
        helper.loadData(component, page, recordToDisplay);
    },
    downloadDocument : function(component, event, helper){

        var sendDataProc = component.get("v.sendData");
        var dataToSend = {
            "label" : "This is test"
        }; //this is data you want to send for PDF generation
        console.log('1');
        //invoke vf page js method
        sendDataProc(dataToSend, function(){
            //handle callback
        });
    },

})