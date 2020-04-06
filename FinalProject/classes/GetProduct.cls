/**
 * Created by virus on 07.03.2020.
 */

public with sharing class GetProduct {
    @AuraEnabled
    public static AccountPagerWrapper getProducts(Decimal pageNumber, Integer recordToDisplay, String Name, String Objs) {
        String query;
        String fieldSort = '';
        String s = '%'+Name+'%';
        Integer pageSize = recordToDisplay;
        Integer offset = ((Integer)pageNumber - 1) * pageSize;
        List<Criteria> criteria = new List<Criteria>();

        if(Objs != '[]'){
            List<Object> fieldList = (List<Object>)JSON.deserializeUntyped(objs);
            for (Object fld : fieldList){
                Map<String, Object> data = (Map<String, Object>)fld;
                Criteria c = new Criteria(data.get('category').toString(), data.get('name').toString());
                criteria.add(c);
            }
            fieldSort = 'AND ' + generateWhereQuery(criteria);
        }
        List<PricebookEntry> count = Database.query('SELECT Name FROM PriceBookEntry WHERE (Pricebook2.Name = \'Belarus\' AND Name LIKE :s '+ fieldSort +' )');
        AccountPagerWrapper obj =  new AccountPagerWrapper();
        obj.size = fieldSort;
        obj.pageSize = pageSize;
        obj.page = (Integer) pageNumber;
        obj.products = Database.query('SELECT Name, UnitPrice, Product2.DisplayUrl, Product2.Class__c, Product2.Description, Product2.Material__c, Product2.IsActive FROM PriceBookEntry WHERE (Pricebook2.Name = \'Belarus\' AND Name LIKE :s '+ fieldSort +' ) LIMIT :recordToDisplay OFFSET :offset');
        obj.total = count.size();

        return obj;
    }
    public static String generateWhereQuery(List<Criteria> criterias) {
        List<String> and_conditions = new List<String>();
        for(Criteria single_criteria : criterias) {
            if (single_criteria.IsFieldValueGiven()) {
                and_conditions.add(single_criteria.getSOQLCriteria());
            }
        }
        return String.join(and_conditions, ' AND ');
    }

    public class Criteria {
        public String FieldName;
        public String Operator;
        public String FieldValue;
        public Criteria(String f_name, String f_value) {
            FieldName = f_name;
            FieldValue = f_value;
            Operator = '=';
        }
        public String getSOQLCriteria() {
            return fieldName + ' '  + Operator + ' \'' + FieldValue  +'\'';
        }

        public Boolean IsFieldValueGiven() {
            return FieldValue != null && FieldValue != '';
        }
    }

    public class AccountPagerWrapper {
        @AuraEnabled
        public String size {get;set;}
        @AuraEnabled
        public Integer pageSize {get;set;}
        @AuraEnabled
        public Integer page {get;set;}
        @AuraEnabled
        public Integer total {get;set;}
        @AuraEnabled
        public List<PricebookEntry> products {get;set;}
    }
}