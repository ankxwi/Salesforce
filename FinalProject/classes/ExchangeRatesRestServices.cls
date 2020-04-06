/**
 * Created by virus on 27.03.2020.
 */

public with sharing class ExchangeRatesRestServices{
    public void getExchangeRates() {
        List<String> nameRate = new List<String>{'USD', 'EUR', 'RUB', 'PLN'};

        HttpRequest request = new HttpRequest();
        request.setEndpoint('http://www.nbrb.by/API/ExRates/Rates?Periodicity=0');
        request.setMethod('GET');
        request.setTimeout(60000);

        HttpResponse response = new Http().send(request);
                List<ExchangeRates__c> exchangeRates = new List<ExchangeRates__c>();

                for(Integer i=0; i < nameRate.size(); i++) {
                    JSONParser parser = JSON.createParser(response.getBody());
                    while (parser.nextToken() != null) {
                        if (parser.getCurrentToken() == JSONToken.START_OBJECT) {
                            Rate rate = (Rate) parser.readValueAs(Rate.class);
                            if (rate.Cur_Abbreviation == nameRate[i]) {
                                ExchangeRates__c ER = new ExchangeRates__c(Name = nameRate[i],
                                        Rate__c = rate.Cur_OfficialRate,
                                        Scale__c = rate.Cur_Scale);
                                exchangeRates.add(ER);
                                System.debug(rate.Cur_Abbreviation + ': ' + rate.Cur_OfficialRate + ' Scale: '+ rate.Cur_Scale);
                                parser.skipChildren();
                            }
                        }
            }
        }
        try {
            upsert exchangeRates ER.Name;
        } catch (DmlException e){
            System.debug(e.getMessage());
        }

    }

    public class Rate{
        public String Cur_Abbreviation;
        public Integer Cur_Scale;
        public Double Cur_OfficialRate;
    }

}