/**
 * @author Ruben Vahanyan
 * @date 13/06/2020
 *
 * @description
 */
public with sharing class LeadTriggerHandler {
    private final List<Lead> newRecords;
    private final Map<Id, Lead> oldRecords;
    @testVisible private static LeadService leadService = new LeadService();

    public LeadTriggerHandler(List<Lead> newRecords, Map<Id, Lead> oldRecords) {
        this.newRecords = newRecords;
        this.oldRecords = oldRecords;
    }

    public void afterUpdate() {
        leadService.afterUpdate(newRecords);
    }
}