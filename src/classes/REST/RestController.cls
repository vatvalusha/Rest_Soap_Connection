/**
 * Created by new on 08.06.2017.
 */

public with sharing class RestController {



    public orderWrapper orderWrapper { get; set; }
    public String response { get; set; }

    public RestController() { orderWrapper = getOrders();}

    public static orderWrapper getOrders() {
        OrderWrapper orderWp = (OrderWrapper) JSON.deserialize(APIAccountOauth2.restTest(), OrderWrapper.class);
        return orderWp;
    }

    public PageReference processSelected() {
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