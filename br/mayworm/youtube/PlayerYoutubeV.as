/*****************************************************	 
     ___     Developer- Rafael Mayworm               |
 	(¤;¤)    Page- http://www.rafaelmayworm.com.br   |
    -{=}-    Mail- rafaelmayworm@gmail.com           |
 	 - -	 Msn- rafaelmayworm@hotmail.com          |
  ---------	                                
  
 @Using
 playerYoutube = box.addChild(new PlayerYoutubeV()) as PlayerYoutubeV;
 playerYoutube.init("q4qhQ8DaJoU", 392, 294);
 
*****************************************************/


package br.mayworm.youtube {				
	
	import br.mayworm.utils.Clean;
	import flash.display.Loader;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLRequest;
	import br.mayworm.shape.ShapeRect;	
	import flash.system.Security;
	
	
	//http://code.google.com/intl/pt-BR/apis/youtube/flash_api_reference.html
	
	
	public class PlayerYoutubeV extends Sprite {
		
		private var loaderVidYoutube:Loader;
		private var player:*;
		private var _width:int;
		private var _height:int;		
		private var mascara:Shape;
		
		public function init(id:String = "NCSxxQyh3to", w:int = 600, h:int = 450):void {												
			
			_width = w;
			_height = h;
			
			Security.allowDomain('www.youtube.com');
            Security.allowDomain('youtube.com');
            Security.allowDomain('s.ytimg.com');
            Security.allowDomain('i.ytimg.com');
			
			
			loaderVidYoutube = addChild(new Loader()) as Loader;
			loaderVidYoutube.contentLoaderInfo.addEventListener(Event.INIT, onLoaderInit);
			//loaderVidYoutube.load(new URLRequest("http://www.youtube.com/apiplayer?version=3"));
			//loaderVidYoutube.load(new URLRequest("http://www.youtube.com/v/q4qhQ8DaJoU?version=3"));
			loaderVidYoutube.load(new URLRequest("http://www.youtube.com/v/" + id + "?version=3"));
			
			
			
		}
		
		private function onLoaderInit(e:Event):void {				
			loaderVidYoutube.content.addEventListener("onReady", onPlayerReady);
			loaderVidYoutube.content.addEventListener("onError", onPlayerError);
			loaderVidYoutube.content.addEventListener("onStateChange", onPlayerStateChange);
			loaderVidYoutube.content.addEventListener("onPlaybackQualityChange", onVideoPlaybackQualityChange);
		}
		
		private function onPlayerReady(e:Event):void {			
			
			player = loaderVidYoutube.content;
			player.version = 3;
			
			//player.videoId = "kRxeDk-3Po0#!";			
			//player.cueVideoById("kRxeDk-3Po0#!", 0, 1);
			//player.playVideo();
			
			resize(_width, _height);
			
			mascara = addChild(new ShapeRect(_width, _height, 0xFFFFFF)) as ShapeRect;
			
			player.mask = mascara;			
			
		}
		
		public function resize(w:int, h:int):void {
			if (player != null) player.setSize(w, h);			
		}

		private function onPlayerError(e:Event):void {    
			trace("player error:", Object(e).data);
		}

		private function onPlayerStateChange(e:Event):void {    
			//trace("player state:", Object(e).data);
		}

		private function onVideoPlaybackQualityChange(e:Event):void {    
			trace("video quality:", Object(e).data);
		}		
		
		public function remove():void {			
			
			if (player != null) {
				Clean.cleanTarget(player);
				player.stopVideo();
				player.destroy();
			}
			
			if (loaderVidYoutube != null) {
				loaderVidYoutube.content.removeEventListener("onReady", onPlayerReady);
				loaderVidYoutube.content.removeEventListener("onError", onPlayerError);
				loaderVidYoutube.content.removeEventListener("onStateChange", onPlayerStateChange);
				loaderVidYoutube.content.removeEventListener("onPlaybackQualityChange", onVideoPlaybackQualityChange);
				removeChild(loaderVidYoutube);	
			}			
			
			loaderVidYoutube = null;
			
		}
		
	}
	
}