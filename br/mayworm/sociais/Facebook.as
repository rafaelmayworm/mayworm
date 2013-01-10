package br.mayworm.sociais {
	
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	import flash.net.navigateToURL;
	import br.mayworm.sociais.Navigation;

	/**
	 * Utilities for the Facebook Share GET API
	 * http://wiki.developers.facebook.com/index.php/Connect/Implementing_Facebook_Share	 
	 */
	public class Facebook 
	{
		public static const BASE_URL:String = "http://www.facebook.com/sharer.php";
		
		public static function post(title:String, shareURL:String, window:String = "_blank"):void
		{	
			var request:URLRequest = new URLRequest(BASE_URL);
			var variables:URLVariables = new URLVariables();
			variables.u = shareURL;
			variables.t = title;
			request.data = variables;
			request.method = URLRequestMethod.GET;
			
			// Tries posting using a pop-up. Uses navigateToURL upon failure.
			if(!Navigation.openWindow(request.url + "?" + variables.toString(), "_blank", "width=680, height=500, toolbar=0, status=0")){
				navigateToURL(request, window);
			}
			
		}
	}

}