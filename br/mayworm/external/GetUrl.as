package br.mayworm.external {
	
	import flash.net.navigateToURL;
	import flash.net.URLRequest;

	public class GetUrl {

		public static function open(url:String, tgt:String = "_self"):void {			
			
			/*if(url.indexOf("http://")==-1){
			    trace("ERRO: URL sem http://");
				return;
			}*/
			
			var urlv:URLRequest = new URLRequest(url);			
			
			try {
				navigateToURL(urlv, tgt);
			} catch (e:Error) {
				trace("erro ao abrir a página", e);
			}
			
		}
		
	}
}