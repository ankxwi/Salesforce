public class AccountTriggerHandler extends TriggerHandler {
    protected override void beforeUpdate(){  
        for(Account account : (List<Account>)trigger.new){            
            account.Name = account.Name + 'beforeInsert';
    	}
    }
        protected override void afterInsert(){
            List<Contact> contacts = new List <Contact>();
			for(Sobject account : trigger.new){
				Account acc = (Account)account;
				Contact contact = new Contact(LastName = acc.name, AccountId=acc.id);
				contacts.add(contact);
			}
		insert contacts;
		}
    protected override void  afterUpdate(){
        
        List<Account> accounts = [SELECT Name,
                                             (SELECT FirstName FROM Contacts)
                                             FROM Account
                                             WHERE Id IN :Trigger.new];
        
        List<Contact> contacts = new List<Contact>();
        for(Account account : accounts){
            List<Contact> contact = account.Contacts;
            for(Integer i = 0; i < contact.Size(); i++){
                if(account.Name != contact[i].FirstName){
                    contact[i].FirstName = account.Name;
                    contacts.add(contact[i]);
                }
            }
        }
        update contacts;        	
    }    	
}