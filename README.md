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
// Create Accounts
List<Account> accounts = new List<Account>();
for(Integer i = 1; i <= 5; i++) {
    accounts.add(new Account(Name = 'Test Account ' + i));
}
insert accounts;
System.debug('Inserted Accounts: ' + accounts);

// Create Orders
List<Order__c> orders = new List<Order__c>();
for(Integer i = 0; i < 40; i++) {
    Integer accountIndex = Math.mod(i, 5);
    orders.add(new Order__c(
        Total_Amount__c = (i + 1) * 10,
        Payment_Due_Date__c = Date.today().addDays(i),
        Account__c = accounts[accountIndex].Id
    ));
}
insert orders;
System.debug('Inserted Orders: ' + orders);
```

</details>

