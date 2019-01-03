# Extra Classes for Activity Timeline

 ### E-learning 
 <a href="https://githubsfdeploy.herokuapp.com?owner=brunadileo&repo=ExtraClasses&ref=fieloelr">
  <img alt="Deploy to Salesforce"
       src="https://raw.githubusercontent.com/afawcett/githubsfdeploy/master/deploy.png">
</a>

### Invoice 
 <a href="https://githubsfdeploy.herokuapp.com?owner=brunadileo&repo=ExtraClasses&ref=fieloprp">
  <img alt="Deploy to Salesforce"
       src="https://raw.githubusercontent.com/afawcett/githubsfdeploy/master/deploy.png">
</a>

### Test sth
 <a href="https://githubsfdeploy.herokuapp.com?owner=brunadileo&repo=ExtraClasses&ref=extraclasses">
  <img alt="Deploy to Salesforce"
       src="https://raw.githubusercontent.com/afawcett/githubsfdeploy/master/deploy.png">
</a>

### Activity Timeline Model

The model object contains those fields:

// All Records must have these informations
- RecordId (Id) : if of the member
- ActivityTimelineType (String) : type of the information shown. The default ones are: Transaction, MemberLevel, BadgeMember, Redemption,  CourseStatus, ModuleResponse and Invoice. You can set up any name as ActivityTimelineType, as long you use the same name for the Custom Setting, custom label and class. 
- Member (String) : name of the member
- ActualDate (DateTime) : date used to compare with the others and to be shown in the component

//Transactions
- Points (Decimal) 
- PointType (String)

//Member Level 
- Level (String)

//Course Status
- CourseName (String)

//Module Response
- ModuleName (String)
- GradePercent (Decimal)

//Badge Member
- BadgeName (String)

//Redemption 
- InvoiceNumber (String)
- Items (Integer)
- Status (String)

Imagine that the component builds an table where each item from the list above is a column. Each data gathered is a row. Not all fields are filled in all objects. When adding other object types not listed as default, keep in mind that you can reuse those fields to add information from this object. 


Other objects:

In order to add other objects to the Timeline, you need to:

- create a class called 'add' + 'Name-of-Object'. For example, if the goal is to get Event object data, the class should be called addEvent. The class must be global and implement an interface called **ActivityTimelineObject**.
- create a list in Activity Timeline Parameters custom setting (the name should be the same as the object used in class). This is used to customize how the object data is going to appear in the component.
- create a custom Label with the information you want to show. The name should also be the same from the object/class.

### Custom Setting - Activity Timeline Parameters

The custom setting has 3 fields:
- CustomLabelVariable1__c: field on ActivityTimelineModel that represents the information you want to show
- IconName__c: name of the icon that represeting the object
- IconSize__c: size of the chosen icon

### ActivityTimelineObject Interface
```
global interface ActivityTimelineObject {
	void addObject(List<ActivityTimelineModel> returnList,String objName, Id recordId, Date startDate, Date endDate);
}
```

- returnList - list of ActivityTimelineModel objects that should contain all activities to be shown in the component
- objName - name of the object to query
- recordId - id of the member to use as filter in query
- startDate/endDate - dates to use as filter in query


### Example class - Event Object

	global class addEvent implements ActivityTimelineObject {
    	
	public static void addObject(List<ActivityTimelineModel> returnList, String objName, Id recordId, Date startDate, Date endDate){
        
        String query = 'SELECT Id, FieloPLT__Type__c, Survey__c, FieloPLT__Member__c, ReferredMember__r.Name, CreatedDate FROM FieloPLT__Event__c ';
        String whereClause = 'WHERE FieloPLT__Member__c =: recordId ';
        
        if(!String.isBlank(String.valueOf(startDate))){
            whereClause += ' AND CreatedDate >=: startDate ';
        }
        if(!String.isBlank(String.valueOf(endDate))){
            whereClause += ' AND CreatedDate <=: endDate';
        }       

	List<FieloPLT__Event__c> eventList = Database.query(query+whereClause);
                
        if(eventList.size() > 0){
            for(FieloPLT__Event__c t: eventList){
                switch on t.FieloPLT__Type__c {
                    when 'Survey' {
                        ActivityTimelineModel timelineItem = new ActivityTimelineModel();
                        
                        timelineItem.RecordId = t.Id;
                        timelineItem.ActivityTimelineType = 'SurveyResponse';
                        timelineItem.ActualDate = t.CreatedDate;
                        timelineItem.Level = t.Survey__c;
                        timelineItem.Member = t.FieloPLT__Member__c;
                        
                        returnList.add(timelineItem);
                    }
                    when 'Referral' {
                        ActivityTimelineModel timelineItem = new ActivityTimelineModel();
                        
                        timelineItem.RecordId = t.Id;
                        timelineItem.ActivityTimelineType = 'MemberReferral';
                        timelineItem.ActualDate = t.CreatedDate;
                        timelineItem.Level = t.ReferredMember__r.Name;
                        timelineItem.Member = t.FieloPLT__Member__c;
                        
                        returnList.add(timelineItem);
                    }
                }
            }
        }
    }}

Don't forget to add the object name (same of class name) to the component's property in Community Builder. 




