public class addCourseStatus implements ActivityTimelineObject {
    public static void addObject(List<ActivityTimelineModel> returnList, String objName, Id recordId, Date startDate, Date endDate){
        System.debug ('entrou Course Status');
        List<String> standardFields = new List<String>{'Id', 'CreatedDate','FieloELR__Course_Accomplished__c', 'FieloELR__Course__r.Name', 'FieloELR__CompletedDate__c' };
            Map<String,List<String>> fieldMap = new Map<String,List<String>>{ objName => standardFields};
                
                List<FieloELR__CourseStatus__c> courseList = ActivityTimelineService.dynamicQuery(fieldMap, recordId, startDate, endDate);
        
        System.Debug('Course Status = '+courseList.size());
        
        if(courseList.size() > 0){
            for(FieloELR__CourseStatus__c t: courseList){
                if(t.FieloELR__Course_Accomplished__c == true){
                    ActivityTimelineModel timelineItem = new ActivityTimelineModel();
                    
                    timelineItem.RecordId = t.Id;
                    timelineItem.ActivityTimelineType = 'CourseStatus';
                    timelineItem.ActualDate = t.FieloELR__CompletedDate__c;
                    timelineItem.CourseName = t.FieloELR__Course__r.Name;
                    timelineItem.Member = t.FieloELR__Member__c;
                    returnList.add(timelineItem);
                }
            }
        }
        
        
    }
    
}