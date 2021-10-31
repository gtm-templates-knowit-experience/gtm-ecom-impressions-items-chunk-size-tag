# Ecommerce Impressions/Items Chunk Size Tag
If the payload size is larger than **8192 bytes**, the **hit will not be sent to Google Analytics**. This usually occours with **GA Enhanced Ecommerce Impressions**, or **GA4 Items** sent with the **view_item_list Event**. To overcome this problem, you can send the data in smaller chunks.

This **GTM Tag Template (Web)** makes it possible to break GA4 Ecommerce Items or GA EEC Impressions payload into smaller chunks.

## GTM Tag Template Overview/Setup
### Ecommerce Object
This setting lets you choose if you want to read Ecommerce data from the **Ecommerce Object (Data Layer)**, or from a **GTM Variable**.

If you for example have rewritten your Ecommerce Object using a Custom Javascript Variable, you can choose this Variable as the input for this template. A complete Ecommerce Object must be returned in the Variable.

### Number of Items/Products returned in the chunked payload
How many items to return will depends, but a good starting number to experiment with is **15**.

### Event Name
Choose the Event Name that should be used as Trigger for the chunked ecommerce data.
Suggested Event Name is **view_item_list_chunk**.

### Trigger
Use the Trigger you normally would have used to trigger the GA/GA4 Tag. In this case the **view_item_list** Event is used as Trigger.

![Ecommerce Impressions/Items Chunk Size Tag](https://github.com/gtm-templates-knowit-experience/gtm-ecom-impressions-items-chunk-size-tag/blob/main/images/ecom-impressions-items-chunk-size-tag-template.png)

## GA4 Event Tag Setup Example
In this example setup we are using **view_item_list_chunk** as a trigger for the **GA4 Event Tag**.

Since GA4 Ecommerce only works with predefined Event Names, notice that **view_item_list** has been manually added as Event Name in the GA4 Event Tag.

![GA4 Event Tag Setup Example](https://github.com/gtm-templates-knowit-experience/gtm-ecom-impressions-items-chunk-size-tag/blob/main/images/ga4-view_item_list_tag-example-setup.png)
