/**
 * Created by new on 06.06.2017.
 */
@RestResource(urlMapping='/Product/*')
global with sharing class TestRest {
    @HttpGet
    global static ProductWrapper doGet() {
        List<Product> products = new List<Product>();
        RestResponse res = RestContext.response;
        List<Product2> result = [
                SELECT
                        name,
                        id,
                        ProductCode
                FROM
                        Product2
        ];
//        List<Product2> result = new List<Product2>();
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