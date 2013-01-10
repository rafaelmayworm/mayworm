package br.mayworm.sociais {
	
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	import flash.net.navigateToURL;
	import br.mayworm.sociais.Navigation;

	/**
	 * Utilities for the Orkut GET API
	 * http://code.google.com/apis/orkut/docs/orkutshareapidoc.html#getApi	 	 
	 */
	public class Orkut 
	{
		public static const BASE_URL:String = "http://promote.orkut.com/preview";
		
		public static function post(title:String, message:String, messageURL:String, comment:String = null, thumbnailURL:String = null, window:String = "_blank"):void
		{	
			var request:URLRequest = new URLRequest(BASE_URL);
			var variables:URLVariables = new URLVariables();
			variables.nt = "orkut.com";
			variables.du = messageURL;	                          // URL of content being shared.                           Required
			variables.tt = title;                                 // Title of the shared item, should be plain text.        Required
			if(message != null) variables.cn = message;           // Content to be shared.                                  Optional
			if(comment != null) variables.uc = comment;           // User comment on shared item.                           Optional
			if(thumbnailURL != null) variables.tn = thumbnailURL; // A thumbnail image to be included in the shared item.   Optional
			request.data = variables;
			request.method = URLRequestMethod.GET;
			
			// Tries posting using a pop-up. Uses navigateToURL upon failure.
			if(!Navigation.openWindow(request.url + "?" + variables.toString(), "_blank", "width=640, height=510, toolbar=0, status=0")){
				navigateToURL(request, window);
			}
		}
	}

}