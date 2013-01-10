package br.mayworm.sociais {
	
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	import flash.net.navigateToURL;
	import br.mayworm.sociais.Navigation;

	/**
	 * Utilities for the Twitter public API	 
	 * 
	 * 
	 * Docs:
	 * http://dev.twitter.com/pages/tweet_button
	 * 
	 * url  	URL of the page to share
	 * via 	Screen name of the user to attribute the Tweet to
	 * text 	Default Tweet text
	 * related 	Related accounts
	 * count 	Count box position
	 * lang 	The language for the Tweet Button
	 * counturl 	The URL to which your shared URL resolves to
	 */
	public class Twitter 
	{
		public static const SHARE_URL:String = "http://twitter.com/share";
		public static const POST_URL:String = "http://twitter.com/home";
		public static const MAX_CHARS:int = 140;

		/**
		* Shares using new API (no 140 characters limit, URL shortener).
		*/
		public static function share(shareText:String, shareURL:String = null, via : String = null, related : String = null, window:String = "_blank"):void
		{
			var request:URLRequest = new URLRequest(SHARE_URL);
			var variables:URLVariables = new URLVariables();
		
			variables.text = shareText;
			if(shareURL)	variables.url = shareURL;
			if(via) 			variables.via = via;
			if(related)		variables.related = related;
			request.data = variables;
			request.method = URLRequestMethod.GET;

			// Tries posting using a pop-up. Uses navigateToURL upon failure.
			if(!Navigation.openWindow(request.url + "?" + variables.toString(), "_blank", "width=540, height=380, toolbar=0, status=0"))
				navigateToURL(request, window);
		}

		/**
		* Posts using old status API. Using the new API (share) is recommended over this.
*/
		public static function post(message:String, messageURL:String = "", window:String = "_blank"):void
		{
			if(messageURL.length > 0) messageURL = " " + messageURL;

			if(message.length > MAX_CHARS - messageURL.length)
				message = message.substr(0, MAX_CHARS - messageURL.length - 3) + "...";
		
			message = message + messageURL;

			var request:URLRequest = new URLRequest(POST_URL);
			var variables:URLVariables = new URLVariables();
		
			variables.status = message;
			request.data = variables;
			request.method = URLRequestMethod.GET;

			// Tries posting using a pop-up. Uses navigateToURL upon failure.
			if(!Navigation.openWindow(request.url + "?" + variables.toString(), "_blank", "width=820, height=430, toolbar=0, status=0"))
				navigateToURL(request, window);
		}
	
	}

}