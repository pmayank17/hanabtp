using { anubhav.db.master as master,anubhav.db.transaction as transaction  } from '../db/demo';

service CatalogService@(path:'/CatalogServiceRAR') {

    entity EmployeeSet as projection on master.employees;
    entity AddressSet as projection on master.address;
    entity ProductSet as projection on master.product;
    entity BPSet as projection on master.businesspartner;

    entity POs  as projection on transaction.purchaseorder;

    entity POItems as projection on transaction.poitems;
    

}