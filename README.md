# Task description
I need to create an application that filters entries in a certain object based on two related criteria. In addition to the application, I need to automate the sending of an email directly from the record interface.

# Additional information
1. Data model (custom object _Order_ with three custom fields + test data)
2. Two picklists on the page ->
- The first one contains the names of all records from the Account object that have one or more related Orders. 
- The second one contains names of all months of Payment Due Date records filtered by the first one. 
- The records of the Order object displayed by the component must be clickable 
3. Button “Send Order” on the Order object. On button click, sends email (using email template) to current User with Order info. Email should contain information about Payment due date, total sum (in $), customer name and JetBI logo (a general rule: 150-200 pixels wide, 70–100 pixels high for a horizontal logo).

# Steps to complete the task

**Step 1. - _Data model:_**

- [x] Create Custom object: Order

- [x] Create custom field: Total Amount (num, required), Payment Due date (date, required), Account (lookup)

- [x] Create test data for Account and Order objects:

- Account - 5 records

- Order - 40 records (records must be evenly distributed on Accounts.  Payment Due Date must be different for records)

> [!NOTE]
> Test data was created using execute anonymous Apex in the Developer Console.


**Step 2. - _Component Description:_**

- [x] Create LWC _orderFilterComponent_ with OrderController to implement logic of picklists and order list
- [x] Create Lightning Page _Order Filter Page_ and add created LWC
- [x] Test for OrderController (test coverage: 80%, total: 84%)

**Step 3. - _Automation:_**

- [x] Create Button _Send Email_ (content Source: Visualforce Page)
- [x] Create Email Template using built-in-tools
- [x] Download company logo as Static Resourse  
- [x] Create Visualforce page _EmailConfirmation_
- [x] Create EmailConfirmationController to implement logic of email sending
- [x] Test for EmailConfirmationController (test coverage: 88%, total: 84%)

# Result Visualisation:

 **1)** First picklist that contains the names of all records from the Account object that have one or more related Orders.
 <img src="jetbitask\images\first_picklist.jpg"/>
 <img src="jetbitask\images\first_picklist1.jpg"/>

**2)** Second picklist that contains names of all months of Payment Due Date records filtered by the first one.
<img src="jetbitask\images\second_picklist.jpg"/>
<img src="jetbitask\images\seond_picklist1.jpg"/>

**3)** Order list with the chosen details. The records of the Order object displayed by the component is clickable
<img src="jetbitask\images\order_list.jpg"/>
<img src="jetbitask\images\order_details.jpg"/>

**4)** Button “Send Order” on the Order object that sends an email to current User with Order details after confirmation
<img src="jetbitask\images\button.jpg"/>
<img src="jetbitask\images\confirmation.jpg"/>

**5)** The email that contains information about payment due date, total sum, customer name and JetBI logo
<img src="jetbitask\images\email.jpg"/>




