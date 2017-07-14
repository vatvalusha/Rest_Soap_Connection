/**
 * Created by new on 14.06.2017.
 */
@isTest
public with sharing class TestRestController {
    @isTest static void getOrdersTest(){
        System.Test.setMock(HttpCalloutMock.class, new MockHttpResponseGeneratorRest());
        OrderWrapper response = RestController.getOrders();
        String text = '{"products":null,"orderParses":[{"status":false,"name":"Order Number 0046","id":"a0K0Y000002ndW3UAI"},{"status":false,"name":"Order Number 0047","id":"a0K0Y000002ndW8UAI"}],"errorStatus":false,"errorMessage":"OK","errorCode":null}';
        OrderWrapper actually = (OrderWrapper) JSON.deserialize(text, OrderWrapper.class);
        System.assertEquals(response.orderParses.get(0).id, actually.orderParses.get(0).id);
    }
    @isTest static void processSelectedTest(){
        System.Test.setMock(HttpCalloutMock.class, new MockHttpResponseGeneratorRest());
        RestController restController = new RestController();
        PageReference actually = restController.processSelected();
        System.assertEquals(null, actually);
    }

}