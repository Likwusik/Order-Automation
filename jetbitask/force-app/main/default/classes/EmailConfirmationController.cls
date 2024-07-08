public with sharing class EmailConfirmationController {
    
	private ApexPages.StandardController stdController;
    private static String templateName = 'Order_Information_Email';
    public Order__c order;

    // Constructor accepting standard controller
    public EmailConfirmationController(ApexPages.StandardController stdController) {
        this.stdController = stdController;
        this.order = (Order__c) stdController.getRecord();
    }

    // Method to confirm email sending
    public PageReference confirmSendEmail() {
        Boolean sendEmailConfirmed = true; 
        if (sendEmailConfirmed) {
            try {
                sendEmail();
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'Email sent successfully!'));
            } catch (Exception e) {
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Failed to send email: ' + e.getMessage()));
            }
            return new PageReference('/' + order.Id);
        } else {
            return null; 
        }
    }

    // Method to handle cancelation
    public PageReference cancel() {
        return new PageReference('/' + order.Id);
    }

    // Private method to send email
    private void sendEmail() {
        EmailTemplate emailTemplate = getTemplate(templateName);
        
        Messaging.SingleEmailMessage email = Messaging.renderStoredEmailTemplate(
            emailTemplate.Id,
            UserInfo.getUserId(),  // whoId - the user who will receive the email
            order.Id               // whatId - the record to use for merge fields
        );
        
        // Set recipient email address
        email.setToAddresses(new String[] { UserInfo.getUserEmail() }); 
        email.setSaveAsActivity(false);
        // Send the email
        Messaging.sendEmail(new List<Messaging.Email>{email});
    }
    
    private static EmailTemplate getTemplate(String templateName) {
        return [SELECT Id, Subject, HtmlValue FROM EmailTemplate WHERE DeveloperName =: templateName WITH SECURITY_ENFORCED];
    }


}