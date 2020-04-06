/**
 * Created by virus on 07.03.2020.
 */
({

    loadData : function(component, page, recordToDisplay, productName, objs) {
        let action = component.get('c.getProducts');
        action.setParams({
            'pageNumber' : page,
            'recordToDisplay' : recordToDisplay,
            'Name' : productName,
            'Objs' :  JSON.stringify(objs)
        });
        console.log('OBJS  ' + JSON.stringify(objs));
        action.setCallback(this, function(response) {
            let state = response.getState();
            if(state === 'SUCCESS') {
                let result = response.getReturnValue();
                console.log('result ---->' + JSON.stringify(result));

                component.set('v.SelectedProduct', result.products[0]);
                component.set('v.Products', result.products);
                component.set('v.page', result.page);
                component.set('v.total', result.total);
                component.set('v.pages', Math.ceil(result.total / recordToDisplay));
            }
        });
        $A.enqueueAction(action);
    },

    createObj : function(Name, Category){
        let obj = {name :  Name, category: 'Product2.'+ Category + '__c' };
        return obj;
    },

    augmentObject : function (component, a, b, status, page, recordToDisplay, productName) {
        let objs = component.get('v.objs');
        if(status === true){
            objs.push(this.createObj(a,b));
            component.set('v.objs', objs);
        }
        else if(status === false){
            let index = objs.findIndex(el => el.name === a);
            objs.splice(index, 1);
            component.set('v.objs', objs);
        }
        this.loadData(component, page, recordToDisplay, productName, objs)
        console.log(JSON.stringify(objs));
    }
})