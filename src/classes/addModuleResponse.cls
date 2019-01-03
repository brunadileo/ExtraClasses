public class addModuleResponse implements ActivityTimelineObject {
    public static void addObject(List<ActivityTimelineModel> returnList, String objName, Id recordId, Date startDate, Date endDate){
        System.debug ('entrou Module Response');
        List<String> standardFields = new List<String>{'Id', 'CreatedDate','FieloELR__IsApproved__c', 'FieloELR__Module__r.Name', 'FieloELR__GradePercent__c'};
        Map<String,List<String>> fieldMap = new Map<String,List<String>>{ objName => standardFields};
        List<FieloELR__ModuleResponse__c> moduleList = ActivityTimelineService.dynamicQuery(fieldMap, recordId, startDate, endDate);
        
        System.Debug('Module Response = '+moduleList.size());
        
        if(moduleList.size() > 0){
            for(FieloELR__ModuleResponse__c t: moduleList){
                if(t.FieloELR__IsApproved__c == true){
                    ActivityTimelineModel timelineItem = new ActivityTimelineModel();
                    
                    timelineItem.RecordId = t.Id;
                    timelineItem.ActivityTimelineType = 'ModuleResponse';
                    timelineItem.ActualDate = t.CreatedDate;
                    timelineItem.ModuleName = t.FieloELR__Module__r.Name;
                    timelineItem.Member = t.FieloELR__Member__c;
                    timelineItem.GradePercent = t.FieloELR__GradePercent__c;
                    returnList.add(timelineItem);
                }
            }
        }
 
        
    }
}