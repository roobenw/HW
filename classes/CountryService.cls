/**
 * @author Ruben Vahanyan
 * @date 13/06/2020
 *
 * @description Service class for integration with RestCountries
 */

public with sharing class CountryService {

    public static final String CALLOUT_DOMAIN =
            'https://restcountries.eu/rest/v2/all?fields=name;capital;region;subregion;alpha2Code;alpha3Code;regionalBlocs';

    public static final Map<String, String> FIELDS = new Map<String, String>{
            'Name' => 'name',
            'Alpha2Code__c' => 'alpha2Code',
            'Alpha3Code__c' => 'alpha3Code',
            'Capital__c' => 'capital',
            'Region__c' => 'region',
            'Subregion__c' => 'subregion'
    };

    @future(callout=true)
    public static void syncCountries() {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(CALLOUT_DOMAIN);
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        if (response.getStatusCode() == 200) {
            List<Object> res = (List<Object>) JSON.deserializeUntyped(response.getBody());
            upsertCountries(res);
        }
    }

    private static void upsertCountries(List<Object> results) {
        List<Country__c> countries = new List<Country__c>();
        List<Country__c> allCountries = [
                SELECT Name, Alpha2Code__c, Alpha3Code__c,Capital__c,Region__c,Subregion__c,RegionalBlocks__c
                FROM Country__c
        ];
        Map<String, Country__c> countryByName = new Map<String, Country__c>();
        for (Country__c c : allCountries) {
            countryByName.put(c.Name, c);
        }

        for (Object resObj : results) {
            Country__c country = buildCountry((Map<String, Object>) resObj);
            if (isChanged(countryByName, country)) {
                countries.add(country);
            }
        }
        if (countries != null) {
            upsert countries;
        }
    }

    private static Country__c buildCountry(Map<String, Object> countryMap) {
        Country__c country = new Country__c();
        List<String> acronyms = new List<String>();
        for (String field : FIELDS.keySet()) {
            country.put(field, (String) countryMap.get(FIELDS.get(field)));
        }
        for (Object regBlock : (List<Object>) countryMap.get('regionalBlocs')) {
            Map<String, Object> blockMap = (Map<String, Object>) regBlock;
            acronyms.add((String) blockMap.get('acronym'));
        }
        country.RegionalBlocks__c = String.join(acronyms, ' ');
        return country;
    }

    private static Boolean isChanged(Map<String, Country__c> countryMap, Country__c country) {
        Country__c oldCountry = countryMap.get(country.Name);
        if (oldCountry == null) {
            return true;
        }

        for (String fieldName : FIELDS.keySet()) {
            if (countryMap.get(fieldName) != oldCountry.get(fieldName)) {
                return true;
            }
        }
        return false;
    }
}