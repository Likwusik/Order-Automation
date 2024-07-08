@isTest
private class TestEmailConfirmationController {

    // Helper method to create test data
    private static Account createTestAccount() {
        Account testAccount = new Account(
            Name = 'Test Account'
        );
        insert testAccount;
        return testAccount;
    }

    // Helper method to create test Order__c record
    private static Order__c createTestOrder(Id accountId) {
        Order__c testOrder = new Order__c(
            Account__c = accountId,   
            Total_Amount__c = 1000.00,    
            Payment_Due_Date__c = Date.today() 
        );
        insert testOrder;
        return testOrder;
    }

    // Test method to simulate confirming and sending email
    @isTest
    static void testConfirmSendEmail() {
        Account testAccount = createTestAccount();
        Order__c testOrder = createTestOrder(testAccount.Id);

        // Create a new page reference for the order detail page
        PageReference orderDetailPage = new PageReference('/' + testOrder.Id);
        Test.setCurrentPage(orderDetailPage);

        // Create a StandardController for the Order__c record
        ApexPages.StandardController stdController = new ApexPages.StandardController(testOrder);

        // Create an instance of the EmailConfirmationController
        EmailConfirmationController controller = new EmailConfirmationController(stdController);

        // Simulate confirming and sending email
        Test.startTest();
        PageReference resultPage = controller.confirmSendEmail();
        Test.stopTest();

        // Assert that the result page is redirected to the order detail page
        System.assertEquals('/' + testOrder.Id, resultPage.getUrl(), 'The confirmSendEmail method should return the order detail page.');
    }

    // Test method to simulate canceling
    @isTest
    static void testCancel() {
        Account testAccount = createTestAccount();
        Order__c testOrder = createTestOrder(testAccount.Id);

        PageReference orderDetailPage = new PageReference('/' + testOrder.Id);
        Test.setCurrentPage(orderDetailPage);
        ApexPages.StandardController stdController = new ApexPages.StandardController(testOrder);
        EmailConfirmationController controller = new EmailConfirmationController(stdController);
        PageReference resultPage = controller.cancel();

        System.assertEquals('/' + testOrder.Id, resultPage.getUrl(), 'The cancel method should return the order detail page URL.');
    }
}