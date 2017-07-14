/**
 * Created by new on 06.06.2017.
 */
@RestResource(urlMapping='/Product/*')
global with sharing class TestRest {


    global static List<Product2> getproductList(){
        return [SELECT name, id, ProductCode FROM Product2];
    }
    @HttpGet
    global static ProductWrapper doGet() {
        RestRequest req = RestContext.request;
        List<Product2> result;
        RestResponse res = RestContext.response;
        List<Product> products = new List<Product>();
        String productId = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
        if(productId == '') {
            result = [SELECT
                    name,
                    id,
                    ProductCode
            FROM
                    Product2];
        }else {
            result = [SELECT name, id, ProductCode FROM Product2 WHERE id =: productId];
        }
        try {
            if (result.size() == 0) {
                throw new CustmException('No products');
            }
            for (Product2 product :result) {
                products.add(new Product(String.valueOf(product.id), product.Name, product.ProductCode));
            }
            return new ProductWrapper(products, false, null, 'OK');
        } catch (CustmException e) {
            return new ProductWrapper(null, true, '1', e.getMessage());
        }
        return null;
    }
}