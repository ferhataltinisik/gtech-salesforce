@RestResource(urlMapping='/student/*')
global class StudentController {
    

    @HttpGet
    global static Student__c getStudentById() {
        RestRequest req = RestContext.request;
        String studentId = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
        Student__c student = [SELECT Id, Name FROM Student__c WHERE Id = :studentId];
        return student;
    }
}