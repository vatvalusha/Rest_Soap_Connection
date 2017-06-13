/**
 * Created by new on 12.06.2017.
 */

global with sharing class Product {
    public String id { get; set; }
    public String Name { get; set; }
    public String ProductCode { get; set; }

    global Product(String id, String Name, String ProductCode) {
        this.id = id;
        this.Name = Name;
        this.ProductCode = ProductCode;
    }
}