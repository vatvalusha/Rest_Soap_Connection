/**
 * Created by new on 12.06.2017.
 */

global with sharing class ProductWrapper {
    public List<Product> orderParses { get; set; }
    public Boolean errorStatus { get; set; }
    public String errorCode { get; set; }
    public String errorMessage { get; set; }

    global ProductWrapper(List<Product> orderParses, Boolean errorStatus, String errorCode, String errorMessage) {
        this.orderParses = orderParses;
        this.errorStatus = errorStatus;
        this.errorCode = errorCode;
        this.errorMessage = errorMessage;
    }
}