namespace anubhav.db;
using { cuid, managed, temporal, Currency } from '@sap/cds/common';
using { anubhav.common } from './commons';


type Guid : String(32);

context master {
    entity businesspartner {
        key NODE_KEY : Guid;
        BP_ROLE	:String(2);
        EMAIL_ADDRESS :String(105);
        PHONE_NUMBER: String(32);
        FAX_NUMBER: String(32);
        WEB_ADDRESS:String(44);	
        ADDRESS_GUID: Association to address;	
        BP_ID: String(32);	
        COMPANY_NAME: String(250);
    }

    annotate businesspartner with{
        NODE_KEY @title :  '{i18n>bp_key}';
        BP_ROLE @title: '{i18n>bp_role}';
        COMPANY_NAME @title : '{i18n>company_name}';
        BP_ID @title : '{i18n>bp_id}';
        EMAIL_ADDRESS @title : '{i18n>email_addr}'
    };

    entity address {
        key NODE_KEY: Guid;
        CITY: String(44);
        POSTAL_CODE: String(8);
        STREET: String(44);
        BUILDING:String(128)  ;
        COUNTRY: String(44);
        ADDRESS_TYPE: String(44);
        VAL_START_DATE: Date;
        VAL_END_DATE:Date;
        LATITUDE: Decimal;
        LONGITUDE: Decimal;
        businesspartner: Association to one businesspartner on businesspartner.ADDRESS_GUID = $self;
    }

    // entity prodtext {
    //     key NODE_KEY: Guid;
    //     PARENT_KEY: Guid;
    //     LANGUAGE:String(2);	
    //     TEXT: String(256);        
    // }
    
    entity product {
        key NODE_KEY: Guid;
        PRODUCT_ID: String(28);
        TYPE_CODE: String(2);
        CATEGORY: String(32);
        DESCRIPTION: localized String(255);
        SUPPLIER_GUID: Association to master.businesspartner;
        TAX_TARIF_CODE: Integer;
        MEASURE_UNIT: String(2);
        WEIGHT_MEASURE	: Decimal(5,2);
        WEIGHT_UNIT: String(2);
        CURRENCY_CODE:String(4);
        PRICE: Decimal(15,2);
        WIDTH:Decimal(5,2);	
        DEPTH:Decimal(5,2);	
        HEIGHT:	Decimal(5,2);
        DIM_UNIT:String(2);

    }

    
    entity employees: cuid {
        nameFirst: String(40);
        nameMiddle: String(40);	
        nameLast: String(40);	
        nameInitials: String(40);	
        sex	: common.Gender;
        language: String(1);
        phoneNumber: common.PhoneNumber;
        email: common.Email;
        loginName: String(12);
        Currency: Currency;
        salaryAmount: common.AmountT;	
        accountNumber: String(16);	
        bankId: String(8);
        bankName: String(64);
    }

}



context transaction {
    
     entity purchaseorder: common.Amount {
            key NODE_KEY:Guid;
            PO_ID: String(24);     	
            PARTNER_GUID: association to master.businesspartner;                      
            LIFECYCLE_STATUS: String(1);	
            OVERALL_STATUS: String(1);
            Items: association to many poitems on Items.PARENT_KEY = $self
     }

     entity poitems: common.Amount {
            key NODE_KEY: Guid;               	
            PARENT_KEY: association to purchaseorder;
            PO_ITEM_POS: Integer;	
            PRODUCT_GUID: association to master.product;           	
              
     }

}

