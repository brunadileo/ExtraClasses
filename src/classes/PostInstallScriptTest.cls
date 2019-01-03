@isTest
global class PostInstallScriptTest {
    
    @isTest static void testInstallScript() {
        PostInstallScript postinstall = new PostInstallScript();
        Test.testInstall(postinstall, null);
        List<ActivityTimelineParameters__c> a = [Select id, name from ActivityTimelineParameters__c];
        System.assertEquals(a.size(), 2);
    }
}