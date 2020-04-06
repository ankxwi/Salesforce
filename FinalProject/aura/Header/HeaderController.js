/**
 * Created by virus on 05.03.2020.
 */
({
    doInit : function(component, event, helper){
        helper.loadExchangeRates(component, event, helper);
    },

    handleChange: function (component, event, helper) {
        let selectedOptionValue = event.getParam("value");
        let rates = component.get('v.ExchangeRates')[0];

        for(let key in rates){
            if(key === selectedOptionValue){
                component.set('v.SelectRate', rates[key]);
            }
        }


    }
})