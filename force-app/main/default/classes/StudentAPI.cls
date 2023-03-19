@RestResource(urlMapping='/student/all/*')
global class StudentAPI {
    

    @HttpGet
    global static List<Student__c> getAllStudents() {
        List<Student__c> students = [SELECT Id, Name, Surname__c, Phone_Number__c FROM Student__c];
        return students;
    }
    
}