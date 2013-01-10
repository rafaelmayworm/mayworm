
/*****************************************************	 
     ___     Developer- Rafael Mayworm               |
 	(¤;¤)    Page- http://www.rafaelmayworm.com.br   |
    -{=}-    Mail- rafaelmayworm@gmail.com           |
 	 - -	 Msn- rafaelmayworm@hotmail.com          |
  ---------	                                
  
 @Using
 
 XMLLoader.load("xml/portfolio.xml", onCompleteXml);
 
 function onCompleteXml(xml:XML):void {
	trace(xml);
 }
 
*****************************************************/

package br.mayworm.xml {
	
	import flash.net.URLLoader;
	import flash.events.IOErrorEvent;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.events.ProgressEvent;

	public class XMLLoader {
		
		public static function load(url:String, onComplete:Function, onProgress:Function = null, onIoError:Function = null):void {
			
			var _loader:URLLoader = new URLLoader();
			_loader.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
			_loader.addEventListener(ProgressEvent.PROGRESS, onLoadProgress);
			_loader.addEventListener(Event.COMPLETE, onLoadComplete);
			
			function onLoadProgress(e:ProgressEvent):void {
				if(onProgress != null) onProgress(e.bytesLoaded / e.bytesTotal);
			}
			
			function onLoadComplete(e:Event):void {				
				onComplete(new XML(_loader.data)) as XML;
			}
			
			function onIOError(e:IOErrorEvent):void {
				trace("XMLLoader IOErrorEvent:" + e);
				if (onIoError != null) onIoError(e);				
			}
			
			try {	
				_loader.load(new URLRequest(url));
			} catch (e:SecurityError) {
				trace("XMLLoader SecurityError:" + e);
			}
			
		}
		
	}

}