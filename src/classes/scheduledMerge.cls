/**
 * Created by new on 19.06.2017.
 */
global class scheduledMerge implements Schedulable {
    global void execute(SchedulableContext SC) {
        LeadProcessor leadProcessor = new LeadProcessor();
        Database.executeBatch(leadProcessor);
    }
}