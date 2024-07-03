// Importing necessary modules
import { LightningElement, wire, track } from 'lwc';
import getAccountsWithOrders from '@salesforce/apex/OrderController.getAccountsWithOrders';
import getOrderMonthsByAccountId from '@salesforce/apex/OrderController.getOrderMonthsByAccountId';
import getOrdersByAccountIdAndMonth from '@salesforce/apex/OrderController.getOrdersByAccountIdAndMonth';



export default class OrderFilterComponent extends LightningElement {
    @track accounts = [];
    @track months = [];
    @track orders = [];
    @track selectedAccount = '';
    @track selectedMonth = '';


    // Map the accounts to a format suitable for the lightning-combobox options
    @wire(getAccountsWithOrders)
    wiredAccounts({ error, data }) {
        if (data) {
            this.accounts = data.map(account => ({ label: account.Name, value: account.Id }));
        } else if (error) {
            console.error(error);
        }
    }

    // The months are mapped to a format suitable for the lightning-combobox options
    handleAccountChange(event) {
        this.selectedAccount = event.detail.value;
        this.selectedMonth = '';
        this.orders = [];
        getOrderMonthsByAccountId({ accountId: this.selectedAccount })
            .then(result => {
                this.months = result.map(month => ({ label: `Month ${month}`, value: month.toString() }));
            })
            .catch(error => {
                console.error(error);
            });
    }

    //Fetch orders for the selected account and month.
    handleMonthChange(event) {
        this.selectedMonth = event.detail.value;
        getOrdersByAccountIdAndMonth({ accountId: this.selectedAccount, month: parseInt(this.selectedMonth) })
            .then(result => {
                this.orders = result;
            })
            .catch(error => {
                console.error(error);
            });
    }

    handleOrderClick(event) {
        const orderId = event.target.dataset.id;
        window.open(`/lightning/r/Order__c/${orderId}/view`, "_blank");
    }
}
