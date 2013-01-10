/*
@Usage


import br.mayworm.external.StatusInternet;

//Desconectado se servidor "url" estiver OFFLINE ou PC sem acesso internet
var statusInternet:StatusInternet = new StatusInternet() as StatusInternet;
statusInternet.addEventListener("ONLINE", online);
statusInternet.addEventListener("OFFLINE", offline);
statusInternet.url = "http://digfix.com.br/StatusInternet.html";
statusInternet.init();

function online(e:Event):void{
	trace("ONLINE");
}

function offline(e:Event):void{
	trace("OFFLINE");
}


stage.addEventListener(MouseEvent.CLICK, clickIt);
function clickIt(e:MouseEvent):void{
	statusInternet.remove();
}

*/
package br.mayworm.external {
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.setTimeout;
	import flash.utils.clearTimeout;
	import br.mayworm.external.LoadGetPost;
	
	public class StatusInternet extends Sprite {			
		
		private var sendGet:LoadGetPost;
		private var timeout:uint;
		private var timeout2:uint;
		private var carregando:Boolean = false;		
		public var url:String = "http://google.com/";
		public var delayConexao:Number = 2500;
		public var delayLimiteTimeConexao:Number = 8000;
		
		public function init():void {				
			sendGet = new LoadGetPost(url, null, "GET", "", false);
			sendGet.addEventListener("complete", onComplete);
			sendGet.addEventListener("ioError", onError);
			//sendGet.addEventListener("securityError", onError);
			//sendGet.addEventListener("httpStatus", onError);	
			//sendGet.addEventListener("httpResponseStatus", onError);		
			clearTimeout(timeout2);
			timeout2 = setTimeout(timeLimiteResponse, delayLimiteTimeConexao);
		}
		
		private function timeLimiteResponse():void{
			clearTimeout(timeout2);
			//trace("OFFLINE timeLimiteResponse");
			this.dispatchEvent(new Event("OFFLINE"));			
			init();
		}
		
		private function onComplete(e:Event):void {		
			//trace("ONLINE");
			//statusInternet.gotoAndStop(1);	
			clearTimeout(timeout);
			this.dispatchEvent(new Event("ONLINE"));
			timeout = setTimeout(init, delayConexao);
		}
		
		private function onError(e:Event):void {		
			//trace("OFFLINE");
			//statusInternet.gotoAndStop(2);
			this.dispatchEvent(new Event("OFFLINE"));
			clearTimeout(timeout);
			timeout = setTimeout(init, delayConexao);
		}
		
		public function remove():void {
			if (sendGet != null) sendGet.removeListeners();
			clearTimeout(timeout);
			clearTimeout(timeout2);
		}
		
	}
	
}