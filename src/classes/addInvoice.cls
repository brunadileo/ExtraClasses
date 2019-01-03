public class addInvoice  implements ActivityTimelineObject {
    public static void addObject(List<ActivityTimelineModel> returnList, String objName, Id recordId, Date startDate, Date endDate){
        System.debug ('entrou Invoice');
        List<String> standardFields = new List<String>{'Id', 'CreatedDate','FieloPRP__InvoiceNumber__c','FieloPRP__Status__c','FieloPRP__ApprovedDate__c', 'SystemModstamp'};
            Map<String,List<String>> fieldMap = new Map<String,List<String>>{ objName => standardFields};
                
                List<FieloPRP__Invoice__c> invoiceList = ActivityTimelineService.dynamicQuery(fieldMap, recordId, startDate, endDate);
               
        System.Debug('Invoices = '+invoiceList.size());
        
        if(invoiceList.size() > 0){
            for(FieloPRP__Invoice__c t: invoiceList){
                if(t.FieloPRP__Status__c == 'Open'){
                    ActivityTimelineModel timelineItem = new ActivityTimelineModel();
                    
                    timelineItem.RecordId = t.Id;
                    timelineItem.ActivityTimelineType = 'Invoice';
                    timelineItem.ActualDate = t.CreatedDate;
                    timelineItem.Member = t.FieloPRP__Member__c;
                    timelineItem.Status = t.FieloPRP__Status__c;
                    timelineItem.InvoiceNumber = t.FieloPRP__InvoiceNumber__c;
                    returnList.add(timelineItem);
                }else{
                    ActivityTimelineModel timelineItem = new ActivityTimelineModel();
                    
                    timelineItem.RecordId = t.Id;
                    timelineItem.ActivityTimelineType = 'Invoice';
                    timelineItem.ActualDate = t.CreatedDate;
                    timelineItem.Member = t.FieloPRP__Member__c;
                    timelineItem.Status = 'Open';
                    timelineItem.InvoiceNumber = t.FieloPRP__InvoiceNumber__c;
                    returnList.add(timelineItem);
                    
                    ActivityTimelineModel timelineItem2 = new ActivityTimelineModel();
                    
                    timelineItem2.RecordId = t.Id;
                    timelineItem2.ActivityTimelineType = 'Invoice';
                    timelineItem2.ActualDate = t.SystemModstamp;
                    timelineItem2.Member = t.FieloPRP__Member__c;
                    timelineItem2.Status = t.FieloPRP__Status__c;
                    timelineItem2.InvoiceNumber = t.FieloPRP__InvoiceNumber__c;
                    returnList.add(timelineItem2);
                }
            }
        }
        
        
        
    }
    
}