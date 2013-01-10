package br.mayworm.string {
	
	public class StringUtils {
		
		public static function strReplace(string:String, search:String, replace:String):String {
			
			//return string.split(search).join(replace)
			
			var array:Array = string.split(search);
			return array.join(replace);
			
		}

		public static function stripHTML(string:String):String {
			return string.replace(/<.*?>/g, "");
		}

		public static function stripWhiteSpaces(string:String):String {
			return string.replace(/ \t/g, "");
		}
		
		public static function removeQuebra(string:String):String {			
			string = strReplace(string, "\n", "");
			string = strReplace(string, "\t", "");
			string = strReplace(string, "\r", "");			
			return string;			
		}
		
		public static function decodeHtml(string:String):String {			
			var htmlString:String = string.split("&lt;").join("<");     
			htmlString = htmlString.split("&gt;").join(">");     
			htmlString = htmlString.split("&quot;").join("\"");     
			htmlString = htmlString.split("&apos;").join("\'");
			htmlString = htmlString.split("&amp;").join("&");
			return htmlString;		
		}
		
		
	}
}