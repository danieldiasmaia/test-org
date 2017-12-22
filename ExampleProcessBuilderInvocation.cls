public with sharing class ExampleProcessBuilderInvocation {
	public ExampleProcessBuilderInvocation() {
		
	}

	@InvocableMethod(label='Inform Contacts on Opportunity Won' description='Sends one email to each contact of a given account informing the civen opportunity was closed')
	public static void informContatsOnOpportunityWon(List<Opportunity> opportunitieList){

		List<Id> accountId = new List<Id>();

		for(Opportunity oppty : opportunitieList){
			accountIdList.add(oppty.accountId);
		}

		List<Contact> contacts = [SELECT Id, Email, FirstName, LastName, AccountId FROM Contact WHERE accountId = :accountIdList LIMIT 200];

		for (Opportunity oppty : opportunitieList){
			for(Contact contact : contacts){
				if (contact.AccountId == oppty.AccountId){
					sendEmail(contact, 'We\'re in buisiness, congratulations', 'We closed your opportunity \'' + oppty.Name + '\', congratulations.\nYou\'re the best');
				}
			}
		}
	}


	private static void sendEmail(Contact contact, String subject, String body){

		Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
		message.toAddresses = new String[] { contact.Email};
		message.optOutPolicy = 'FILTER';
		message.subject = subject;
		message.plainTextBody = body;
		Messaging.SingleEmailMessage[] messages =   new List<Messaging.SingleEmailMessage> {message};
		Messaging.SendEmailResult[] results = Messaging.sendEmail(messages);

		System.debug(results);
	}
}