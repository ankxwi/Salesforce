/**
 * Created by virus on 30.03.2020.
 */
({
    downloadDocument : function(component, event, helper){

        var sendDataProc = component.get("v.sendData");
        var dataToSend = {
            "label" : "This is test",
            "sadasd" : "asfsfadsfa",
            "dasdasd" : "asdasfdsf",
            "asfadsfasfd" : "safadadsfads"
        }; //this is data you want to send for PDF generation
        console.log('1');
        //invoke vf page js method
        sendDataProc(dataToSend, function(){
            //handle callback
        });
    },
    test : function (component, event, helper) {
        let PDFev = event.getParam('Data');
        component.set('v.sendData', PDFev);
    }
})