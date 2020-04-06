/**
 * Created by virus on 28.03.2020.
 */

global with sharing class ScheduleExchangeRatesRestServices implements Schedulable{
    global void execute(SchedulableContext sc) {
        ExchangeRatesRestServices b = new ExchangeRatesRestServices();
        b.getExchangeRates();
    }
}