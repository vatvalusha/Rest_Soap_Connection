/**
 * Created by new on 16.06.2017.
 */

global with sharing class LeadProcessor implements Database.Batchable<sObject>, Database.Stateful{

    global Integer recordsProcessed = 0;
    String queryString = 'SELECT Name, id, Type__c FROM Account';
    String TypeB = 'B';
    String TypeC = 'C';


    global Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator(queryString);
    }

    global void execute(Database.BatchableContext bc, List<Account> scope){
        List<Account> accns = new List<Account>();

        for(sObject s : scope){
            Account a = (Account)s;
            if(a.Type__c == TypeB){
                a.Type__c = 'C';
                accns.add(a);
            }
            else if(a.Type__c == TypeC){
                a.Type__c = 'B';
                accns.add(a);
            }
        }
        update accns;
    }

    global void finish(Database.BatchableContext bc){
//
    }
}