trigger CheckDuplicateSpeakerBooking2 on Event_Speaker__c (before insert, before update) {
    
    // Collect all the Event IDs to filter the event speakers
    Set<Id> eventIds = new Set<Id>();
    for (Event_Speaker__c eventSpeaker : Trigger.new) {
        eventIds.add(eventSpeaker.Event__c);
    }
    
    // Query all the Event Speakers for the given event IDs
    List<Event_Speaker__c> existingEventSpeakers = [SELECT Id, Speaker__c, Event__c FROM Event_Speaker__c  WHERE Event__c IN :eventIds];
    //Event_Speaker__c:{Id=a118d000005eAulAAE, Speaker__c=a108d0000084UZJAA2, Event__c=a0y8d00000461ebAAA})
    
    // Create a Map of Speaker ID to Event ID for the existing Event Speakers
    Map<Id, Set<Id>> speakerToEventsMap = new Map<Id, Set<Id>>();
    for (Event_Speaker__c existingEventSpeaker : existingEventSpeakers) {
        if (!speakerToEventsMap.containsKey(existingEventSpeaker.Speaker__c)) {
            speakerToEventsMap.put(existingEventSpeaker.Speaker__c, new Set<Id>());
        }
        speakerToEventsMap.get(existingEventSpeaker.Speaker__c).add(existingEventSpeaker.Event__c);
        //{(SpeakerId)a108d0000084UZJAA2,	(Speaker__c)a0y8d00000461ebAAA}
    }
    
    // Check if any Speaker has already been booked for the same Event
    for (Event_Speaker__c eventSpeaker : Trigger.new) {
        if (speakerToEventsMap.containsKey(eventSpeaker.Speaker__c) && 
            speakerToEventsMap.get(eventSpeaker.Speaker__c).contains(eventSpeaker.Event__c)) {
            eventSpeaker.addError('This Speaker has already been booked for this Event.');
        }
    }
}
