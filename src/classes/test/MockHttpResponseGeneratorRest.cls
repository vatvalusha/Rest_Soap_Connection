
@isTest
global class MockHttpResponseGeneratorRest implements HttpCalloutMock {
    global HTTPResponse respond(HTTPRequest req) {
//        System.assertEquals('https://esymon-dev-ed.my.salesforce.com/services/apexrest/Order', req.getEndpoint());
//        System.assertEquals('GET', req.getMethod());
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setBody('{"products":null,"orderParses":[{"status":false,"name":"Order Number 0046","id":"a0K0Y000002ndW3UAI"},{"status":false,"name":"Order Number 0047","id":"a0K0Y000002ndW8UAI"}],"errorStatus":false,"errorMessage":"OK","errorCode":null}');
        res.setStatusCode(200);
        return res;
    }
}