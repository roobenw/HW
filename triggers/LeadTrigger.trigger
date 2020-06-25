/**
 * @author Ruben Vahanyan
 * @date 13/06/2020
 *
 * @description Lead trigger
 */
trigger LeadTrigger on Lead (before update) {
    LeadTriggerHandler handler = new LeadTriggerHandler(Trigger.new, Trigger.oldMap);

    if (Trigger.isBefore) {
        if (Trigger.isUpdate) {
            handler.afterUpdate();
        }
    }
}