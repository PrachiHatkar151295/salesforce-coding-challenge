/*********************************
* Class Name: OrderDetailsCalloutMock
* Author: Prachi Hatkar
**********************************/
@isTest
global class OrderDetailsCalloutMock implements HttpCalloutMock {
    global HTTPResponse respond(HTTPRequest request) {
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/json;charset=UTF-8');
        response.setStatusCode(200); 
        return response; 
    }
}