public with sharing class LeadService {

    public void afterUpdate(List<Lead> leads) {
        Set<Id> countryIds = new Set<Id>();
        List<Lead> leadsToUpdate = new List<Lead>();
        for (Lead lead : leads) {
            countryIds.add(lead.Country__c);
        }
        Map<Id, Country__c> countryMap = new Map<Id, Country__c>(
        [SELECT Alpha2Code__c, Alpha3Code__c, Capital__c, Region__c,Subregion__c, RegionalBlocks__c
        FROM Country__c
        WHERE Id IN: countryIds]);

        for (Lead lead : leads) {
            Country__c country = countryMap.get(lead.Country__c);
            lead.Alpha2Code__c = country.Alpha2Code__c;
            lead.Alpha3Code__c = country.Alpha3Code__c;
            lead.Capital__c = country.Capital__c;
            lead.Region__c = country.Region__c;
            lead.Subregion__c = country.Subregion__c;
            lead.RegionalBlocks__c = country.RegionalBlocks__c;
        }
        update leadsToUpdate;
    }
}