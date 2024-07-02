# Task description
You need to create an application that filters entries in a certain object based on two related criteria. In addition to the application, you need to automate the sending of an email directly from the record interface.

# Steps to complete the task

# **Step 1. - _Data model:_**

- [x] Create Custom object: *Order__c* with custom fields:

- [x] Total Amount (num, required)

- [x] Payment Due date (date, required)

- [x] Account (lookup)

- [x] Create test data for Account and Order objects:

- Account - 5 records

- Order - 40 records (Records must be evenly distributed on Accounts.  Payment Due Date must be different for records)

> [!NOTE]
> <details>
> <summary>Test data was created using execute anonymous Apex in the Developer Console.</summary>
```
CODE!
```
> </details>

