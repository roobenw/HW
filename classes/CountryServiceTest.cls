@IsTest
public with sharing class CountryServiceTest {

    public static testmethod void testSyncCountries() {
        Test.setMock(HttpCalloutMock.class, new CountryCalloutMock());
        Test.startTest();
        CountryService.syncCountries();
        Test.stopTest();
        List<Country__c> countries = [SELECT Alpha2Code__c FROM Country__c];
        System.assertEquals('UM', countries[0].Alpha2Code__c, 'Invalid Alpha2Code returned');

    }

}