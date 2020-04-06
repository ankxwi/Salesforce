({
    doInit : function(component, event, helper){
        helper.loadExchangeRates(component, event, helper);
    },

    handleChange: function (component, event, helper) {
        let selectedOptionValue = event.getParam('value');
        let rates = component.get('v.ExchangeRates');
        for(let key in rates){
            if(rates[key].Name === selectedOptionValue){
                component.set('v.SelectRate', rates[key].Rate__c);
                component.set('v.RateScale', rates[key].Scale__c)
            }
        }
    }
})