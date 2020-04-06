/**
 * Created by virus on 28.03.2020.
 */

public with sharing class GetExchangeRates {
    @AuraEnabled
    public static List<ExchangeRates__c> ExchangeRates(){
        List<ExchangeRates__c> exRates = [SELECT Name, Rate__c, Scale__c FROM ExchangeRates__c];
        return exRates;
    }
}