
/*****************************************************	 
     ___     Developer- Rafael Mayworm               
    (¤;¤)    Page- http://www.rafaelmayworm.com.br   
    -{=}-    Mail- rafaelmayworm@gmail.com           
     - -      Msn- rafaelmayworm@hotmail.com         
  ---------	  
  
  @Using
  
    import br.mayworm.fullscren.ForceFullscreen;
	var forceFullscreen:ForceFullscreen = new ForceFullscreen() as ForceFullscreen;
	forceFullscreen.init(stage, true);
	//forceFullscreen.remove();
  
*****************************************************/
  
package br.mayworm.fullscren {	
	
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.display.StageDisplayState;
	import flash.events.Event;
	import flash.events.FullScreenEvent;
	import flash.events.MouseEvent;
	
	public class ForceFullscreen extends Sprite {
		
		private var _stage:Stage;
		
		public function init(s:Stage, autoFullscreen:Boolean = false):void {			
			
			_stage = s;
			_stage.addEventListener(Event.FULLSCREEN, checarFullScreen);
			
			(autoFullscreen) ? full() : _stage.addEventListener(MouseEvent.CLICK, full);
			
		}
		
		public function remove():void {				
			if (_stage.willTrigger(Event.FULLSCREEN)) _stage.removeEventListener(Event.FULLSCREEN, checarFullScreen);
			if (_stage.willTrigger(MouseEvent.CLICK)) _stage.removeEventListener(MouseEvent.CLICK, full);			
		}
		
		private function checarFullScreen(e:FullScreenEvent = null):void {						
			(e.fullScreen) ? _stage.removeEventListener(MouseEvent.CLICK, full) : _stage.addEventListener(MouseEvent.CLICK, full);
			_stage.dispatchEvent(new Event(Event.RESIZE));			
		}
		
		public function full(e:* = null):void {				
			_stage.displayState = StageDisplayState.FULL_SCREEN;//StageDisplayState.FULL_SCREEN_INTERACTIVE;
			_stage.dispatchEvent(new Event(Event.RESIZE));
		}
		
	}
	
}