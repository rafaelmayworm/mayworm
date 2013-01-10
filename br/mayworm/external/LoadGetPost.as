

/*

//teste.php
<?php

if(@$_GET['teste'] != ""){
	echo "method=get&retorno=".@$_GET['teste'];
}

if(@$_POST['teste'] != ""){
	echo "method=post&retorno=".@$_POST['teste'];
}

?>


import br.mayworm.external.LoadGetPost;
import br.mayworm.external.URLVariablesDecoder;

//POST 

var loadVars:Object = new Object();
loadVars.teste = "RAFAEL_MAYWORM";

var sendPost:LoadGetPost = new LoadGetPost("http://localhost/teste.php", loadVars, "POST", "", false);
sendPost.addEventListener("complete", onCompletePost);

function onCompletePost(e:Event):void {	
	trace(e.target.data);	
	var tt = URLVariablesDecoder.decode(e.target.data);
	trace(tt.method, tt.retorno);
}

//GET **********************************************************************************
var sendGet:LoadGetPost = new LoadGetPost("http://localhost/teste.php?teste=rafael", null, "GET", "", false);
sendGet.addEventListener("complete", onCompleteGet);

function onCompleteGet(e:Event):void {		
	trace(e.target.data);	
	var tt = URLVariablesDecoder.decode(String(e.target.data));
	trace(tt.method, tt.retorno);	
}

*/
package br.mayworm.external {
	
        import flash.events.Event;
        import flash.events.HTTPStatusEvent;
        import flash.events.IEventDispatcher;
        import flash.events.IOErrorEvent;
        import flash.events.ProgressEvent;
        import flash.events.SecurityErrorEvent;
        import flash.net.URLLoader;
        import flash.net.URLRequest;
        import flash.net.URLRequestMethod;
        import flash.net.URLVariables;
		import flash.net.navigateToURL;
        
        public class LoadGetPost extends URLLoader {

            public var myURL:URLRequest = new URLRequest();
            public var LoadingState:String = "";

            public function LoadGetPost(URL:String, postData:Object = null, method:String = "GET", window:String = "", cache:Boolean = false):void {						
						
				var rnd:String = "";			
				if (cache == false) {					
					(URL.indexOf("?") >= 0) ? rnd = "&" : rnd = "?";					
					rnd += "rnd=" + Math.random();					
					URL = URL + rnd;					
				}					
				
				
				var loadVars:URLVariables = new URLVariables();				
				for (var key:String in postData) loadVars[key] = postData[key];
				
				configureListeners(this);				
				myURL.url = URL;
				
				(method == "POST") ? myURL.method = URLRequestMethod.POST : myURL.method = URLRequestMethod.GET;				
                myURL.data = loadVars;
                
				(window == "") ? this.load(myURL) : navigateToURL(myURL, window);
				
            }

            public function configureListeners(dispatcher:IEventDispatcher):void {
                dispatcher.addEventListener(Event.COMPLETE, completeHandler);
                dispatcher.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
                dispatcher.addEventListener(ProgressEvent.PROGRESS, progressHandler);
                dispatcher.addEventListener(Event.OPEN, openHandler);
                dispatcher.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
                dispatcher.addEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatusHandler);
            }
			
			public function removeListeners():void {					
                this.removeEventListener(Event.COMPLETE, completeHandler);
                this.removeEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
                this.removeEventListener(ProgressEvent.PROGRESS, progressHandler);
                this.removeEventListener(Event.OPEN, openHandler);
                this.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
                this.removeEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatusHandler);				
            }

            public function progressHandler(event:ProgressEvent):void {
                LoadingState = "ProgressHandler loaded:" + event.bytesLoaded + " total: " + event.bytesTotal;
            }

            public function completeHandler(event:Event):void {     
				this.close();
                LoadingState = "Loaded complete.";
            }

            public function ioErrorHandler(event:Event):void {
                this.close();
                LoadingState = "Unable to load requested.";
            }

            public function openHandler(event:Event):void {
                LoadingState = "openHandler: " + event;
            }

            public function httpStatusHandler(event:HTTPStatusEvent):void {
                LoadingState = "httpStatusHandler: " + event;
            }

            public function securityErrorHandler(event:SecurityErrorEvent):void {
                LoadingState = "securityErrorHandler: " + event;
            }
			
        }
}
