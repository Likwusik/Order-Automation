@isTest
public class OrderControllerTest {
    @isTest
    static void testGetAccountsWithOrders() {
        // Set up test data
        Account testAccount = new Account(Name = 'Test Account');
        insert testAccount;

        Order__c testOrder = new Order__c(
            Account__c = testAccount.Id,
            Payment_Due_Date__c = Date.today(),
            Total_Amount__c = 100.00 
        );
        insert testOrder;

        Test.startTest();
        // Call the method
        List<Account> accounts = OrderController.getAccountsWithOrders();
        Test.stopTest();

        // Verify results
        System.assertNotEquals(0, accounts.size(), 'Accounts with orders should be returned');
        System.assertEquals('Test Account', accounts[0].Name, 'The account name should match the test data');
    }

    @isTest
    static void testGetOrderMonthsByAccountId() {
        // Set up test data
        Account testAccount = new Account(Name = 'Test Account');
        insert testAccount;

        Order__c testOrder1 = new Order__c(
            Account__c = testAccount.Id,
            Payment_Due_Date__c = Date.newInstance(2023, 1, 15),
            Total_Amount__c = 100.00 
        );
        insert testOrder1;

        Order__c testOrder2 = new Order__c(
            Account__c = testAccount.Id,
            Payment_Due_Date__c = Date.newInstance(2023, 2, 20),
            Total_Amount__c = 200.00 
        );
        insert testOrder2;

        Test.startTest();
        // Call the method
        List<Integer> months = OrderController.getOrderMonthsByAccountId(testAccount.Id);
        Test.stopTest();

        // Verify results
        System.assertNotEquals(0, months.size(), 'Months with orders should be returned');
        System.assert(months.contains(1), 'Month 1 (January) should be in the result');
        System.assert(months.contains(2), 'Month 2 (February) should be in the result');
    }

    @isTest
    static void testGetOrdersByAccountIdAndMonth() {
        // Set up test data
        Account testAccount = new Account(Name = 'Test Account');
        insert testAccount;

        Order__c testOrder = new Order__c(
            Account__c = testAccount.Id,
            Payment_Due_Date__c = Date.newInstance(2023, 1, 15),
            Total_Amount__c = 100.00 // Set the required Total_Amount__c field
        );
        insert testOrder;

        Test.startTest();
        // Call the method
        List<Order__c> orders = OrderController.getOrdersByAccountIdAndMonth(testAccount.Id, '1');
        Test.stopTest();

        // Verify results
        System.assertNotEquals(0, orders.size(), 'Orders for the given account and month should be returned');
        System.assertEquals(testOrder.Id, orders[0].Id, 'The order ID should match the test data');
        System.assertEquals(100.00, orders[0].Total_Amount__c, 'The total amount should match the test data');
    }

    
}