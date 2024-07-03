@isTest
public class OrderControllerTest {
    @isTest
    static void testGetAccounts() {
        Test.startTest();
        List<Account> accounts = OrderController.getAccounts();
        System.assert(accounts.size() > 0);
        Test.stopTest();
    }

    @isTest
    static void testGetOrders() {
        Test.startTest();
        List<Order__c> orders = OrderController.getOrders('someAccountId', 1);
        System.assert(orders.size() > 0);
        Test.stopTest();
    }
}


