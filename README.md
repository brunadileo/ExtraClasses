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

### Interface
```
global interface ActivityTimelineObject {
	void addObject(List<ActivityTimelineModel> returnList,String objName, Id recordId, Date startDate, Date endDate);
}
```
