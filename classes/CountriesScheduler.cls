/**
 * @author Ruben Vahanyan
 * @date 13/06/2020
 *
 * @description
 */

global with sharing class CountriesScheduler implements Schedulable {

    global void execute(SchedulableContext sc) {
        CountryService.syncCountries();
    }
}