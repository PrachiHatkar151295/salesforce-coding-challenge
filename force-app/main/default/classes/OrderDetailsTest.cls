/*********************************
* Class Name: OrderDetailsTest
* Author: Prachi Hatkar
**********************************/
@IsTest
public class OrderDetailsTest {
	@TestSetup
    public static void setupMethod(){
        //TODO - We can maintain TestFactoryClass which can provide us with commonly used methods to create test data
        Account acc = new Account(name = 'Account123');
        insert acc;
        
        Contact con = new Contact(FirstName = 'Jane', LastName = 'Doe', Email = 'jane.doe@test.com');
        insert con;
        
        Product2 prod = new Product2(Name = 'Product123', ProductCode = 'Product123', IsActive = TRUE);
        insert prod;
        
        List<Order> orderList = new List<Order>();
        for(Integer i=0; i<5; i++){
            Order ord = new Order();
            ord.BillToContactId = con.Id;
            ord.AccountId = acc.Id;
            ord.EffectiveDate = System.today() + 5;
            ord.Status = 'Draft';
            orderList.add(ord);
        }
        insert orderList;
    }
    
    @isTest 
    static void testPostCallout() {
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new OrderDetailsCalloutMock()); 
        List<Id> idList = new List<Id>();
        for(Order ord : [SELECT Id FROM Order WHERE BillToContact.Email = 'jane.doe@test.com' LIMIT 5]){
            idList.add(ord.Id);
        }
        List<Integer> responseCode = OrderDetails.syncOrdersWithNPS(idList);
        System.assert(responseCode != NULL && responseCode[0] == 200);
        Test.stopTest();
    }
}