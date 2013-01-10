package br.mayworm.sociais {
	
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	import flash.net.navigateToURL;
	import br.mayworm.sociais.Navigation;

	public class Delicious 
	{
		public static const SAVE_BASE_URL:String = "http://delicious.com/save";
		
		public static function save(title:String, shareURL:String, window:String = "_blank"):void
		{	
			var request:URLRequest = new URLRequest(SAVE_BASE_URL);
			var variables:URLVariables = new URLVariables();
			variables.v = 5;
			variables.noui = 1;
			variables.url = shareURL;
			variables.title = title;
			request.data = variables;
			request.method = URLRequestMethod.GET;
			
			// Tries posting using a pop-up. Uses navigateToURL upon failure.
			if(!Navigation.openWindow(request.url + "?" + variables.toString(), "_blank", "width=580, height=550, toolbar=0, status=0")){
				navigateToURL(request, window);
			}
		}
	}

}

//<img src="http://static.delicious.com/img/delicious.small.gif" height="10" width="10" alt="Delicious" />
//<a href="http://delicious.com/save" onclick="window.open('http://delicious.com/save?
//v=5&noui&jump=close&url='+encodeURIComponent(location.href)+'&title='+encodeURIComponent(document.title),
//'delicious','toolbar=no,width=550,height=550'); return false;"> Bookmark this on Delicious</a>