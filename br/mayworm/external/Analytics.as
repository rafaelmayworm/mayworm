package br.mayworm.external {		
	
	import flash.external.ExternalInterface;
	
	public class Analytics {	
		
		//referência -> http://www.domicioneto.com/web-analytics/google-analytics/trackpageview-x-trackevent/		
		
		public static function trackPageview(str:String):void {	
			
			//<a href=”link” onclick=”_gaq.push(['_trackPageview', '/folder/file/'])”>texto</a>
			//ExternalInterface.call("function(){ _gaq.push(['_trackPageview','/produtos']); }");
			//ExternalInterface.call("function(){ _gaq.push(['_trackPageview','/produto/aeiou']); }");
			ExternalInterface.call("function(){ _gaq.push(['_trackPageview','" + str + "']); }");						
			trace("Analytics trackPageview -> " + str);			
			
		}
		
		public static function trackEvent(category:String, action:String, label:String = ""):void {							
			
			//<a href="#" onClick="_gaq.push(['_trackEvent', 'category', 'action', 'opt_label']);">texto</a>
			//ExternalInterface.call("function(){ _gaq.push(['_trackEvent','SITE AEIOU','Flash Carregou',''']); }");			
			ExternalInterface.call("function(){ _gaq.push(['_trackEvent','" + category + "','" + action + "','" + label + "'']); }");									
			trace("Analytics trackEvent -> " + category + " " + action + " " + label);						
			
		}
		
	}
	
}