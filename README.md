# OracleCodeChallenge

OracleCodeChallenge

OracleCodeChallenge project is a sample code test project mainly focused on displaying the data from StackOverflow questions and its details from Open JSON.

Design Pattern: 
 
The design Pattern followed in this project is MVVM. We are using the Combine framework to fetch data with subscribers and publishers. I felt the ViewModel pattern would be helpful and organized to maintain this project.

Views:
  there are two views in this project
            1. Top Questions View
            2. Question View
   

 Top Questions View: Will display the questions given by view modal, where each question will contain its title, tags, date published, views count, comments.
               This view has functionalities paging; we display more data as we scroll, "Pull to refresh" to refresh the data, and reload view are added; also, it shows alert incase of errors while fetching data.
  Question View: This is more like a question detail view, which will display the question given by the view modal. The question will contain its title, tags, date published, views count, comments and description, publisher name, and image.

ViewModel:
       The view modal in this project is generic. Its primary purpose is to call NetworkManager and get data and update the view by configuring accordingly or returning an error and showing an alert in view.

Modal:
       The modal of this project is also generic because the exact modal is used to call both top questions and question API. So we are reusing the modal to serve both purposes like view modal. This modal is a modal object replicating the Json Object data from the cloud to help the view display data.
               
Utilities:
     Network Manager is built to get the JSON object from the cloud and decode it as per the modal. Urlsession is used to make API call, and Combine is the framework mainly used to publish the results to the subscriber.

Extensions:
     UIImageview extension is added with functionalities to do round corner of the image and lazy load the picture and update image view
     using Data extension to handle HTML data
    using string extension to convert HTML data into readable text
     using Int extension to convert Unix time into a date string
     
Apis used:
https://api.stackexchange.com/2.2/questions?site=stackoverflow&order=desc&sort=votes&tagged=swiftui&pagesize=10
 https://api.stackexchange.com/2.2/questions/56433665?site=stackoverflow&order=desc&sort=votes&tagged=swiftui&pagesize=10&filter=!9_bDDxJY5


Unit Testing: 
  we created 2 test cases to test the happy path and error scenario:
  Happy Path will test the NetworkManager, ViewModel, and modal
  Error case will test if errors are handled properly
  
  Mock Data: Mock URL Protocol is designed to take local JSON and return the same when a network call is made; it prevents getting actual data. a
  
  Also, Unit test measuring of network call is added.
