/**
 * Created by virus on 07.03.2020.
 */
({
    loadExchangeRates : function (component, event, helper) {
        let action = component.get('c.ExchangeRates');

        action.setCallback(this, function(response) {
            let state = response.getState();
            if(state === 'SUCCESS') {
                let result = response.getReturnValue();
                console.log('Header helper run! ---->' + JSON.stringify(result));
                component.set('v.ExchangeRates', result);
            }
        });
        $A.enqueueAction(action);
    }
})