# Developer's comments over the implementation
* Two flows are developed, based on two separate solutions for the same problem statement:
    1. SyncNPSSystem flow is developed without using an invocable apex class. Instead, HTTP Callout Action provided by the  Salesforce Flows is used.
    2. SyncNPSSystem_Alternate flow is developed incorporating the invocable apex class.
  Any one of the two solutions/flows can be deployed to check the feature.
* The refinement points are mentioned inside the classes itself as a TODO comment.
* Assign 'NPS_Named_Credential' Permission Set to the user initiating the update of marking the Orders as Fulfilled and in turn, invoking the NPS API.
* A manifest file is maintained in GIT repository to keep a track of components.
