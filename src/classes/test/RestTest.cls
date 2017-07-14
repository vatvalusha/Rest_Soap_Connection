/**
 * Created by new on 13.06.2017.
 */

@isTest
public with sharing class RestTest {
    @isTest static void testCallout() {
        System.Test.setMock(HttpCalloutMock.class, new MockAutorization());
        String res = APIAccountOauth2.authorization();
        String actually = '00D0Y000001dj0c!AR4AQNeef8izZly8Ws7Ge3KohRKHcUVjhgcQ3ZifD.GKP3AQdEvC_wxC9FVOYGifAkp50qlTRVjT8Toe7D6KJd1dfMkO.N1W';
        System.assertEquals(res, actually);
    }

    @isTest static void getResponcePostTest() {
        System.Test.setMock(HttpCalloutMock.class, new MockHttpResponseGeneratorRest());
        String actually = '{"products":null,"orderParses":[{"status":false,"name":"Order Number 0046","id":"a0K0Y000002ndW3UAI"},{"status":false,"name":"Order Number 0047","id":"a0K0Y000002ndW8UAI"}],"errorStatus":false,"errorMessage":"OK","errorCode":null}';
        HttpResponse response = APIAccountOauth2.getResponsePost(actually);
        System.assertEquals(response.getBody(), actually);
    }

    @isTest static void getBodyTest() {
        System.Test.setMock(HttpCalloutMock.class, new MockHttpResponseGeneratorRest());
        String response = APIAccountOauth2.restTest();
        String actually = '{"products":null,"orderParses":[{"status":false,"name":"Order Number 0046","id":"a0K0Y000002ndW3UAI"},{"status":false,"name":"Order Number 0047","id":"a0K0Y000002ndW8UAI"}],"errorStatus":false,"errorMessage":"OK","errorCode":null}';
        System.assertEquals(response, actually);

    }

}