___TERMS_OF_SERVICE___

By creating or modifying this file you agree to Google Tag Manager's Community
Template Gallery Developer Terms of Service available at
https://developers.google.com/tag-manager/gallery-tos (or such other URL as
Google may provide), as modified from time to time.


___INFO___

{
  "type": "TAG",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "Ecommerce Impressions/Items Chunk Size",
  "brand": {
    "id": "brand_dummy",
    "displayName": ""
  },
  "description": "Template that allows you to break the Impressions/Items payload into smaller chunks. Supports both GA4 Ecommerce Items \u0026 Enhanced Ecommerce Impressions.",
  "containerContexts": [
    "WEB"
  ]
}


___TEMPLATE_PARAMETERS___

[
  {
    "type": "GROUP",
    "name": "ecomInputGroup",
    "displayName": "Ecommerce Object",
    "groupStyle": "NO_ZIPPY",
    "subParams": [
      {
        "type": "RADIO",
        "name": "ecommerceInput",
        "radioItems": [
          {
            "value": "ecomObject",
            "displayValue": "Ecommerce Object"
          },
          {
            "value": "variable",
            "displayValue": "GTM Variable"
          }
        ],
        "simpleValueType": true
      },
      {
        "type": "SELECT",
        "name": "ecomVariable",
        "displayName": "Select Ecommerce Variable",
        "macrosInSelect": true,
        "selectItems": [],
        "simpleValueType": true,
        "help": "Select a Variable that returns a complete ecommerce object.",
        "valueValidators": [],
        "enablingConditions": [
          {
            "paramName": "ecommerceInput",
            "paramValue": "variable",
            "type": "EQUALS"
          }
        ]
      }
    ],
    "help": "Choose if Ecommerce Data should be read from \u003cb\u003eEcommerce Object\u003c/b\u003e, or from a \u003cb\u003eGTM Variable\u003c/b\u003e. Use the last option if you for example have rewritten your Ecommerce data using a Custom Javascript Variable.\n\u003cbr /\u003e\u003cbr /\u003e\nBoth \u003cstrong\u003eGA4 Ecommerce\u003c/strong\u003e \u0026 \u003cstrong\u003eEnhanced Ecommerce\u003c/strong\u003e are supported."
  },
  {
    "type": "TEXT",
    "name": "chunkNumber",
    "displayName": "Number of Items/Products returned in the chunked payload",
    "simpleValueType": true,
    "valueValidators": [
      {
        "type": "POSITIVE_NUMBER"
      },
      {
        "type": "NON_EMPTY"
      }
    ],
    "valueHint": "15",
    "valueUnit": "Items/Products",
    "alwaysInSummary": true
  },
  {
    "type": "TEXT",
    "name": "eventName",
    "displayName": "Event Name",
    "simpleValueType": true,
    "alwaysInSummary": true,
    "help": "Enter the Event Name that you want to use as a GTM Trigger for the chunked data. \n\u003cbr /\u003e\u003cbr/\u003e\nFor GA4 Ecommerce, you can\u0027t use the standard \u003cstrong\u003eview_item_list\u003c/strong\u003e Event as Trigger for the chunked data.",
    "valueHint": "view_item_list_chunk",
    "valueValidators": [
      {
        "type": "NON_EMPTY"
      }
    ]
  }
]


___SANDBOXED_JS_FOR_WEB_TEMPLATE___

const JSON = require('JSON');
const dataLayer = require('copyFromDataLayer');
let ecom = data.variable ? data.ecomVariable : dataLayer('ecommerce', 1);
if (JSON.stringify(ecom).indexOf('ecommerce')>0) {ecom = ecom.ecommerce;}
let items = ecom.items ? ecom.items : ecom.impressions;

if (items) {
  const createQueue = require('createQueue');
  const dataLayerPush = createQueue('dataLayer');
  const chunkSize = data.chunkNumber;
  let itemsChunck = [];
  
  while (items.length) {
    itemsChunck = items.splice(0, chunkSize);
    const itemsArr = ecom.items ? {'items': itemsChunck} : {'impressions': itemsChunck};
    dataLayerPush({
      'event': data.eventName,
      'ecommerce': itemsArr
    });
  }
}
data.gtmOnSuccess();


___WEB_PERMISSIONS___

[
  {
    "instance": {
      "key": {
        "publicId": "access_globals",
        "versionId": "1"
      },
      "param": [
        {
          "key": "keys",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "key"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  },
                  {
                    "type": 1,
                    "string": "execute"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "dataLayer"
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": false
                  }
                ]
              }
            ]
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "read_data_layer",
        "versionId": "1"
      },
      "param": [
        {
          "key": "keyPatterns",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 1,
                "string": "ecommerce"
              }
            ]
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  }
]


___TESTS___

scenarios: []


___NOTES___

Created on 10/31/2021, 4:43:58 PM


