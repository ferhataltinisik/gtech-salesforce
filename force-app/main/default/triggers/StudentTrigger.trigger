trigger StudentTrigger on Student__c (before insert) {
    
    // Generate a unique random string or number
	String uniqueId = String.valueOf(System.currentTimeMillis()).substring(6);
	String domain = 'gmail.com';
    String email = 'user' + uniqueId + '@' + domain;
    
    // Define a list of common first names
    List<String> firstNames = new List<String>{'John', 'Jane', 'David', 'Sarah', 'Emily', 'Michael', 'Christopher', 'Jessica', 'Amanda', 'Daniel'};
    
    // Define a list of common last names
    List<String> lastNames = new List<String>{'Smith', 'Johnson', 'Brown', 'Davis', 'Wilson', 'Taylor', 'Jones', 'Clark', 'Hall', 'Walker'};
    
    // Generate a random first name index and last name index
    Integer firstNameIndex = (Integer)Math.floor(Math.random() * firstNames.size());
    Integer lastNameIndex = (Integer)Math.floor(Math.random() * lastNames.size());
    
    // Get the random first and last names
    String firstName = firstNames[firstNameIndex];
    String lastName = lastNames[lastNameIndex];
    
    // Combine the first and last names to create the full name
    String fullName = firstName + ' ' + lastName;
    

    
        
    
    for(Student__c st: Trigger.new){
        st.Name = firstName;
        st.Surname__c = lastName;
        st.Email__c = email;
        st.Phone_Number__c = uniqueId;
        st.Gender__c = 'Male';
        st.Country__c = 'America';
        
    }

}