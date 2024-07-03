public with sharing class OrderController {
   
   // Get accounts with orders for the first picklist
    @AuraEnabled(cacheable=true)
    public static List<Account> getAccountsWithOrders() {
        
        List<Account> accounts;
        
        // Catching errors
        try {  
            accounts = [SELECT Id, Name FROM Account WHERE Id IN (SELECT Account__c FROM Order__c) WITH SECURITY_ENFORCED ORDER BY Name];
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
        
        return accounts;
    }
    
    // Get months of orders for the second picklist
    @AuraEnabled(cacheable=true)
    public static List<Integer> getOrderMonthsByAccountId(Id accountId) {
        
        // Look up for orders and its payment due date
        List<Order__c> orders = [
            SELECT Payment_Due_Date__c 
            FROM Order__c 
            WHERE Account__c = :accountId
            WITH SECURITY_ENFORCED
        ];
        
        // Catching errors
        if (orders.size() == 0) {
            throw new AuraHandledException('There is no orders for this account');
        }

        // Get the months
        Set<Integer> months = new Set<Integer>();
        for(Order__c order : orders) {
            if (order.Payment_Due_Date__c != null) {
                months.add(order.Payment_Due_Date__c.month());
            }
        }

        return new List<Integer>(months);
    }


    // Get Orders by accountsID and month for orders list
    @AuraEnabled(cacheable=true)
    public static List<Order__c> getOrdersByAccountIdAndMonth(ID accountId, String month) {
        List<Order__c> orders;
        Integer selectedMonth = Integer.valueOf(month);
       
        // Catching errors
        try {
            orders = [
            SELECT Id, Name, Total_Amount__c, Payment_Due_Date__c
            FROM Order__c
            WHERE Account__c = :accountId AND CALENDAR_MONTH(Payment_Due_Date__c) = :selectedMonth
            WITH SECURITY_ENFORCED 
        ];
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }

        return orders;
    }
}
