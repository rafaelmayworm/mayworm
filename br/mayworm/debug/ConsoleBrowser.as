package br.mayworm.debug {
	
	import flash.external.ExternalInterface;
	
	public class ConsoleBrowser {		
		
		public static function log(s:String):void {
			if(ExternalInterface.available) ExternalInterface.call("console.log", s);
		}
		
		public static function debug(s:String):void {
			if(ExternalInterface.available) ExternalInterface.call("console.debug", s);
		}
		
		public static function info(s:String):void {
			if(ExternalInterface.available) ExternalInterface.call("console.info", s);
		}
		
		public static function error(s:String):void {
			if(ExternalInterface.available) ExternalInterface.call("console.error", s);
		}
		
		public static function warn(s:String):void {
			if(ExternalInterface.available) ExternalInterface.call("console.warn", s);
		}
		
		public static function clear():void {
			if(ExternalInterface.available) ExternalInterface.call("console.clear");
		}
		
	}
}