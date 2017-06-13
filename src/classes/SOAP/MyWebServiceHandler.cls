/**
 * Created by new on 13.06.2017.
 */

global with sharing class MyWebServiceHandler {
    webService static String returnProductList() {
        List<Product> products = new List<Product>();
        List<Product2> result = [
                SELECT
                        name,
                        id,
                        ProductCode
                FROM
                        Product2
        ];
        try {
            if (result.size() == 0) {
                throw new CustmException('No products');
            }
            for (Product2 product :result) {
                products.add(new Product(String.valueOf(product.id), product.Name, product.ProductCode));
            }
//            return new ProductWrapper(products, false, null, 'OK');
            return JSON.serialize(new ProductWrapper(products, false, null, 'OK'));
        } catch (CustmException e) {
            return JSON.serialize(new ProductWrapper(null, true, '1', e.getMessage()));
        }
        return null;
    }
}