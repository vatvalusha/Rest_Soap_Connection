/**
 * Created by new on 14.06.2017.
 */

global with sharing class MockAutorization implements HttpCalloutMock {
    global HTTPResponse respond(HTTPRequest req) {
        System.assertEquals('https://login.salesforce.com/services/oauth2/token', req.getEndpoint());
        System.assertEquals('POST', req.getMethod());
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setBody('{"access_token":"00D0Y000001dj0c!AR4AQNeef8izZly8Ws7Ge3KohRKHcUVjhgcQ3ZifD.GKP3AQdEvC_wxC9FVOYGifAkp50qlTRVjT8Toe7D6KJd1dfMkO.N1W","instance_url":"https://esymon-dev-ed.my.salesforce.com","id":"https://login.salesforce.com/id/00D0Y000001dj0cUAA/0050Y000001hgbCQAQ","token_type":"Bearer","issued_at":"1497433510890","signature":"n9ugzmeCr4dRGxIVl4pRClqQgbw/TRBqRGM9w0oG96Y="}');
        res.setStatusCode(200);
        return res;
    }
}