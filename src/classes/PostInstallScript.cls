global class PostInstallScript implements InstallHandler {
    global void onInstall(InstallContext context) {
        if(context.previousVersion() == null) {
            List<ActivityTimelineParameters__c> atpList = new List<ActivityTimelineParameters__c>();
            
            ActivityTimelineParameters__c atp1 = new ActivityTimelineParameters__c();
            atp1.Name = 'MemberReferral2';
            atp1.CustomLabelVariable1__c = 'Level'; 
            atp1.IconName__c='standard:team_member';
            atpList.add(atp1);
            
            ActivityTimelineParameters__c atp2 = new ActivityTimelineParameters__c();
            atp2.Name = 'SurveyResponse2';
            atp2.CustomLabelVariable1__c = 'Level'; 
            atp2.IconName__c='standard:survey';
            atpList.add(atp2);
            
            System.debug(atpList);
            insert atpList;
            
        }
    }
    
    
}