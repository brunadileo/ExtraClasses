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

Other objects:

You just need to create a class called 'add' + 'Name-of-Object'. For example, if the goal is to get Event object data, the class should be called addEvent. 

The class must be global and implement an interface called **ActivityTimelineObject**. 

### ActivityTimelineObject Interface
```
global interface ActivityTimelineObject {
	void addObject(List<ActivityTimelineModel> returnList,String objName, Id recordId, Date startDate, Date endDate);
}
```

returnList - list of ActivityTimelineModel objects that should contain all activities to be shown in the component

objName - name of the object to query

recordId - id of the member to use as filter in query

startDate/endDate - dates to use as filter in query


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
    }
}






