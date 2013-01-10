package br.mayworm.sociais {
	
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	import flash.net.navigateToURL;

	/**
	 * Provides a way to send a mailto message directly from Flash
	 * "mailto:" doesn't accept HTML entities, and UTF-8 is used as the default codepage.	 
	 */
	public class Email 
	{
		public static function post(toEmail:String, subject:String, message:String):void
		{
			var url:String = "mailto:" + toEmail;
			var request:URLRequest = new URLRequest(url);
			var variables:URLVariables = new URLVariables();
			variables.subject = subject;
			variables.body = message;
			request.data = variables;
			request.method = URLRequestMethod.GET;
			navigateToURL(request);
		}
	}

}

