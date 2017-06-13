/**
 * Created by new on 08.06.2017.
 */

global with sharing class OrderParse {

    global String id {
        get;
        set;
    }
    global Boolean status {
        get;
        set;
    }
    global String name {
        get;
        set;
    }
    global Boolean selected {
        get;
        set;
    }

    global OrderParse(String id, Boolean status, Boolean selected, String name) {
        this.id = id;
        this.status = status;
        this.selected = selected;
        this.name = name;
    }

}