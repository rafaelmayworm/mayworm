package br.mayworm.sociais {
	
	import flash.external.ExternalInterface;

	public class Navigation
	{
		
		//window.open ("http://www.javascript-coder.com",
		//"mywindow","location=1,status=1,scrollbars=1,
		//width=100,height=100");
		
		public static function openWindow(url:String, windowName:String = "_blank", windowFeatures:String = ""):Boolean {
			if (ExternalInterface.available) {
				try {
					//if(features.length > 0)
					return ExternalInterface.call("function openWindow(url, windowName, windowFeatures) { return window.open(url, windowName, windowFeatures) != null; }", url, windowName, windowFeatures);
				}
				catch (e:Error) {
					
				}
			}
			return false;
		}
		
	}

}