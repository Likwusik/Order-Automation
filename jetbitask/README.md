# Task description
You need to create an application that filters entries in a certain object based on two related criteria. In addition to the application, you need to automate the sending of an email directly from the record interface.

# Additional information
1. Data model (custom object _Order_ with three custom fields + test data)
2. Two picklists on the page ->
- The first one contains the names of all records from the Account object that have one or more related Orders. 
- The second one contains names of all months of Payment Due Date records filtered by the first one (Account records that have more than one or more related Order). Depending on what is selected, the records to be filtered change. The records of the Order object displayed by the component must be clickable (when you click on the record name, the selected record opens).
3. Automation (button "“Send Order” on Order object, Email template that will accept data from related Order record). On button click, send email to current User (UserInfo.getUserEmail()) with Order info. Email should contain information about Payment due date, total sum (in $), customer name and JetBI logo (ask Mentor for .png).

# Steps to complete the task

**Step 1. - _Data model:_**

- [x] Create Custom object: Order

- [x] Create custom field: Total Amount (num, required)

- [x] Create custom field: Payment Due date (date, required)

- [x] Create custom field: Account (lookup)

- [x] Create test data for Account and Order objects:

- Account - 5 records

- Order - 40 records (Records must be evenly distributed on Accounts.  Payment Due Date must be different for records)

> [!NOTE]
> Test data was created using execute anonymous Apex in the Developer Console.
<details>
<summary>Click to open the code</summary>

```
// Create test data: Accounts
List<Account> accounts = new List<Account>();
for(Integer i = 1; i <= 5; i++) {
    accounts.add(new Account(Name = 'Test Account ' + i));
}
insert accounts;
// Check
System.debug('Inserted Accounts: ' + accounts);

// Create test data: Orders
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
// Check
System.debug('Inserted Orders: ' + orders);

```
</details>

**Step 2. - _Component Description:_**



**Step 3. - _Automation:_**



**Necessary to use:**

**1)** Custom Object configuration with relationships.

**2)** SOQL queries

**3)** Unit test coverage: at least 80%

**4)** Lightning application, Lightning web components

**5)** SObjectType, DescribeFieldResult и др.

**6)** Email Template




