/**
 * Created by new on 13.06.2017.
 */

public with sharing class SoapController {
    public static  SimonSoapService.SoapService webRes{
        get;
        set;
    }
    public static OrderWrapper response {
        get;
        set;
    }
    public SoapController(){
        webRes = SoapConection.getConnection();
    }

    @future(callout=true)
    public static void getOrders(){
        OrderWrapper orderWp = (OrderWrapper)JSON.deserialize(webRes.getOrderList(), OrderWrapper.class);
        response = orderWp;
        System.debug('OrdList' + response);

    }

    public PageReference processSelected() {
        SimonSoapService.SoapService webRes = SoapConection.getConnection();
        List<OrderParse> forSend = new List<OrderParse>();
        List<OrderParse> forUpdatePage = new List<OrderParse>();
        for (OrderParse orderWp: orderWrapper.orderParses) {
            if (orderWp.selected == true) {
                forSend.add(orderWp);
            } else forUpdatePage.add(orderWp);
        }
        APIAccountOauth2.orderList(forSend);
        orderWrapper.orderParses = forUpdatePage;
        return null;
    }

}