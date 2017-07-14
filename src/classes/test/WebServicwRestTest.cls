/**
 * Created by new on 14.06.2017.
 */

@isTest
global with sharing class WebServicwRestTest {
//    public  List<Product2> listProduct{get;set;}
    static void setup() {
        // Create common test accounts
        List<Product2> testProduct = new List<Product2>();
        for (Integer i = 0; i < 3; i++) {
            testProduct.add(new Product2(Name = 'TestProduct' + i, ProductCode = 'TestCode' + i));
        }
        insert testProduct;
    }

    @isTest static void testGetAllData() {
        setup();
        String recordId = '';
        List<Product> products = new List<Product>();
        RestRequest request = new RestRequest();
        request.requestUri = 'https://richiguy-dev-ed.my.salesforce.com/services/apexrest/Product/' + recordId;
        request.httpMethod = 'GET';
        RestContext.request = request;
        List<Product2> listProduct = [SELECT name, id, ProductCode FROM Product2];
        System.debug('OCHELISHE' + listProduct);
        for (Product2 product :listProduct) {
            products.add(new Product(String.valueOf(product.id), product.Name, product.ProductCode));
        }
        ProductWrapper excpected = new ProductWrapper(products, false, null, 'OK');
        ProductWrapper pw = TestRest.doGet();
        System.assert(pw != null);
        System.assertEquals(pw.errorCode, excpected.errorCode);
        System.assertEquals(pw.orderParses.get(0).id, excpected.orderParses.get(0).id);
    }
    @isTest static void testGetProductById() {
        setup();
        Product2 recordId = [SELECT id From Product2 LIMIT 1];
        List<Product> products = new List<Product>();
        RestRequest request = new RestRequest();
        request.requestUri = 'https://richiguy-dev-ed.my.salesforce.com/services/apexrest/Product/' + recordId.id;
        request.httpMethod = 'GET';
        RestContext.request = request;
        List<Product2> listProduct = [SELECT name, id, ProductCode FROM Product2 WHERE id = :recordId.id];
        for (Product2 product :listProduct) {
            products.add(new Product(String.valueOf(product.id), product.Name, product.ProductCode));
        }
        ProductWrapper excpected = new ProductWrapper(products, false, null, 'OK');
        ProductWrapper pw = TestRest.doGet();
        System.assert(pw != null);
        System.assertEquals(pw.errorCode, excpected.errorCode);
        System.assertEquals(pw.orderParses.get(0).id, excpected.orderParses.get(0).id);
    }

    @isTest static void resultNullTest() {
        String recordId = '';
        RestRequest request = new RestRequest();
        request.requestUri = 'https://richiguy-dev-ed.my.salesforce.com/services/apexrest/Product/' + recordId;
        request.httpMethod = 'GET';
        RestContext.request = request;
        CustmException e = new CustmException('No products');
        ProductWrapper expected = new ProductWrapper(null, true, '1', e.getMessage());
        ProductWrapper pw = TestRest.doGet();
        System.assertEquals(pw.errorCode, expected.errorCode);
    }

    @isTest static void queryTest() {
        List<Product2> expected = [SELECT name, id, ProductCode FROM Product2];
        System.debug('EXPECTED' + expected);
        List<Product2> actually = TestRest.getproductList();
        System.debug('Actually' + actually);
        System.assertEquals(expected, actually);


    }

}