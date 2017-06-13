/**
 * Created by new on 12.06.2017.
 */

global with sharing class OrderWrapper {
    public List<OrderParse> orderParses { get; set; }
    public Boolean errorStatus { get; set; }
    public String errorCode { get; set; }
    public String errorMessage { get; set; }

    global OrderWrapper(List<OrderParse> orderParses, Boolean errorStatus, String errorCode, String errorMessage) {
        this.orderParses = orderParses;
        this.errorStatus = errorStatus;
        this.errorCode = errorCode;
        this.errorMessage = errorMessage;
    }

}