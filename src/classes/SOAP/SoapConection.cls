/**
 * Created by new on 13.06.2017.
 */

public with sharing class SoapConection {
    public static SimonSoapService.SoapService getConnection() {
        partnerSoapSforceCom.Soap myPartnerSoap = new partnerSoapSforceCom.Soap();
        partnerSoapSforceCom.LoginResult partnerLoginResult = myPartnerSoap.login(Label.username, Label.password);
        SimonSoapService.SessionHeader_element webserviceSessionHeader = new SimonSoapService.SessionHeader_element();
        webserviceSessionHeader.sessionId = partnerLoginResult.sessionId;
        SimonSoapService.SoapService myWebservice = new SimonSoapService.SoapService();
        myWebservice.SessionHeader = webserviceSessionHeader;
        return myWebservice;
    }
}