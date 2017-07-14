/**
 * Created by new on 13.06.2017.
 */

public with sharing class SoapController {
    public static  SimonSoapService.SoapService webRes{
        get;
        set;
    }
    public  OrderWrapper response {
        get;
        set;
    }
    public SoapController(){
        webRes = SoapConection.getConnection();
    }

    public  void getOrders(){
        OrderWrapper orderWp = (OrderWrapper)JSON.deserialize(webRes.getOrderList(), OrderWrapper.class);
        response = orderWp;
        System.debug('OrdList' + response);

    }

    public PageReference processSelected() {
        String piska;
        List<OrderParse> forSend = new List<OrderParse>();
        List<OrderParse> forUpdatePage = new List<OrderParse>();
        for (OrderParse orderWp : response.orderParses) {
            if (orderWp.selected == true) {
                forSend.add(orderWp);
            } else forUpdatePage.add(orderWp);
        }

        piska = JSON.serialize(forSend);
        System.debug('JSON' + piska);
        webRes = SoapConection.getConnection();
        webRes.updateOrders(piska);

        response.orderParses = forUpdatePage;
        return null;
    }

    //For test git
    public static void updateInstallmentStatuseField(List<Installment__c> installmentsNew, List<Installment__c> installmentsOld) {
        for (Integer i = 0; i < installmentsNew.size(); i++) {
            Integer dayLeft = getDaysBetweenTimestampAndDueDate(Datetime.valueOf(system.now()), installmentsNew.get(i).DueDate__c);
            if (installmentsNew.get(i).AmountReceived__c >= installmentsOld.get(i).AmountDue__c && dayLeft > 0) {
                installmentsNew.get(i).Timestamp__c = Datetime.valueOf(system.now());
                installmentsNew.get(i).InstallmentStatus__c = PAID;
            } else if (installmentsNew.get(i).AmountReceived__c != installmentsOld.get(i).AmountDue__c && dayLeft <= 0) {
                installmentsNew.get(i).InstallmentStatus__c = OVERDUE;
            } else if(installmentsNew.get(i).AmountReceived__c == installmentsOld.get(i).AmountDue__c && dayLeft <= 0) {
                installmentsNew.get(i).InstallmentStatus__c = OVERDUE;
            }else {
                installmentsNew.get(i).InstallmentStatus__c = OPEN;
            }
        }
    }

}