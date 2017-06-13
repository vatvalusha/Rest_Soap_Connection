/**
 * Created by new on 07.06.2017.
 */

public with sharing class APIAccountOauth2 {

    public static final String postMethode = 'POST';
    public static final String getMethode = 'GET';
    public static final String encoding = 'UTF-8';
    public static final String contexJson = 'application/json';
    public static String authorization {
        get;
        set;
    }

    private static String oauthLogin(String loginUri, String clientId, String clientSecret, String username, String password) {

        HttpRequest req = new HttpRequest();
        req.setMethod('POST');
        req.setEndpoint(loginUri + '/services/oauth2/token');
        req.setBody(
                'grant_type=password' +
                        '&client_id=' + clientId +
                        '&client_secret=' + clientSecret +
                        '&username=' + EncodingUtil.urlEncode(username, encoding) +
                        '&password=' + EncodingUtil.urlEncode(password, encoding)
        );

        Http http = new Http();
        HTTPResponse res = http.send(req);
        JSONParser jsonParser = JSON.createParser(res.getBody());
        jsonParser.nextToken();
        jsonParser.nextToken();
        jsonParser.nextToken();
        String token = jsonParser.getText();

        return token;
    }

    public static String authorization() {
        String accessToken = oauthLogin(Label.loginUri,
                Label.client_id,
                Label.client_secret,
                Label.username,
                Label.password);
        return accessToken;

    }

    public static String restTest() {

        String accessToken = authorization();
        HttpRequest req = new HttpRequest();
        req.setMethod(getMethode);
        req.setEndpoint(Label.setEndpoint);
        req.setHeader('Authorization', 'Bearer ' + accessToken);
        Http http = new Http();
        HTTPResponse res = http.send(req);
        System.debug('Status: ');
        return res.getBody();
    }

    public static String orderList(List<OrderParse> orders) {
        String listForSend = JSON.serialize(orders);
        String accessToken = authorization();
        HttpRequest req = new HttpRequest();
        HTTPResponse res = new HTTPResponse();
        Http http = new Http();


        req.setEndpoint(Label.setEndpoint);
        req.setMethod(postMethode);
        req.setHeader('Content-Type', contexJson);
        req.setHeader('Authorization', 'Bearer ' + accessToken);
        System.debug('LISTOVOCKA' + listForSend);
        req.setBody(listForSend);

        try {
            res = http.send(req);
        } catch (System.CalloutException e) {
            System.debug('Callout error: ' + e);
            System.debug(res.toString());
        }
        System.debug('BODY: ' + res.getBody());
        System.debug('Status: ' + res.toString());

        return res.getBody();
    }

}