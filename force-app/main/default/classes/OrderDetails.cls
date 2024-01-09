/*********************************
* Class Name: OrderDetails
* Test Class Name: OrderDetailsTest
* Author: Prachi Hatkar
**********************************/
//TODO - Can have a Constants class to avoid hardcoded values below and to store all such values as constants at a central location
//TODO - Can have an error handling framework. Errors and failed API calls can be logged as a custom object(say error_log__c) record for the ease of debugging for the admins.
//TODO - The API can handle only 30 records as mentioned in the API documentation. We may have to iterate the API call in multiples of 30 if more than 30 records are encountered. 
public class OrderDetails {
    
    //This method will take order record Ids as input and will send the retrieved OrderNumber and Bill-to-Email details to the NPS system 
    @InvocableMethod(label='Sync Order Details With NPS' description='Returns the order details of a specific Order Id' category='Order' callout = true)
    public static List<Integer> syncOrdersWithNPS(List<Id> orderIdList){
        try{
            //retrieve the order details based on the order Id and format the data for API Request body
            List<OrderDetailWrapper> ordDetailWrapperList = new List<OrderDetailWrapper>();
            for(Order ord : [SELECT Id, OrderNumber, BillToContact.Email FROM Order WHERE Id IN :orderIdList LIMIT 30]){
                OrderDetailWrapper ordWrap = new OrderDetailWrapper();
                ordWrap.sfId = ord.Id;
                ordWrap.orderNumber = ord.OrderNumber;
                ordWrap.customerEmail = ord.BillToContact.Email;
                ordDetailWrapperList.add(ordWrap);
            }
            String requestInput = JSON.serialize(ordDetailWrapperList);
            
            //send details to NPS API
            if(ordDetailWrapperList != NULL && ordDetailWrapperList.size() > 0){
                Http http = new Http();
                HttpRequest request = new HttpRequest();
                request.setEndpoint('callout:NPS_Named_Credential/orders');
                request.setMethod('POST');
                request.setHeader('Content-Type', 'application/json;charset=UTF-8');
                request.setBody(requestInput.substring(1,requestInput.length()-1));
                HttpResponse response = http.send(request);
                if(response.getStatusCode() != 200) {
                    //Error Handling framework statements
                }
                return new List<Integer>{response.getStatusCode()};
            }
            
        }
        catch(Exception e){
            //Error Handling framework statements
        }
        return null;
    }
    
    public class OrderDetailWrapper{
        public String sfId;
        public String orderNumber;
        public String customerEmail;
    }
}