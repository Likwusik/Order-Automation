@isTest
private class TestEmailConfirmationController {

    // Helper method to create test data
    private static Account createTestAccount() {
        // Create a test Account record
        Account testAccount = new Account(
            Name = 'Test Account'
            // Add other required fields as necessary
        );
        insert testAccount;
        return testAccount;
    }

    // Helper method to create test Order__c record
    private static Order__c createTestOrder(Id accountId) {
        // Create a test Order__c record with required fields populated
        Order__c testOrder = new Order__c(
            Account__c = accountId,   // Assign the Account Id
            Total_Amount__c = 1000.00,    // Replace with appropriate amount
            Payment_Due_Date__c = Date.today()  // Replace with appropriate due date
            // Add other required fields as necessary
        );
        insert testOrder;
        return testOrder;
    }

    // Test method to simulate confirming and sending email
    @isTest
    static void testConfirmSendEmail() {
        // Create a test Account record
        Account testAccount = createTestAccount();

        // Create a test Order__c record related to the Account
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
        System.assertEquals('/' + testOrder.Id, resultPage.getUrl());

        // Optionally, you can add assertions for messages or other behaviors as needed
    }

    // Test method to simulate canceling
    @isTest
    static void testCancel() {
        // Create a test Account record
        Account testAccount = createTestAccount();

        // Create a test Order__c record related to the Account
        Order__c testOrder = createTestOrder(testAccount.Id);

        // Create a new page reference for the order detail page
        PageReference orderDetailPage = new PageReference('/' + testOrder.Id);
        Test.setCurrentPage(orderDetailPage);

        // Create a StandardController for the Order__c record
        ApexPages.StandardController stdController = new ApexPages.StandardController(testOrder);

        // Create an instance of the EmailConfirmationController
        EmailConfirmationController controller = new EmailConfirmationController(stdController);

        // Simulate canceling
        PageReference resultPage = controller.cancel();

        // Assert that the result page is redirected to the order detail page
        System.assertEquals('/' + testOrder.Id, resultPage.getUrl());

        // Optionally, you can add additional assertions for cancelation logic
    }
}