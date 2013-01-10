
/*****************************************************	 
     ___     Developer- Rafael Mayworm               
    (¤;¤)    Page- http://www.rafaelmayworm.com.br   
    -{=}-    Mail- rafaelmayworm@gmail.com           
     - -      Msn- rafaelmayworm@hotmail.com         
  ---------	                                     
  
 @Using
 Key.init(stage);
 if (Key.isDown(Keyboard.LEFT)) trace("LEFT")
 if (Key.isDown("W".charCodeAt())) trace("W press");
 
 stage.addEventListener(KeyboardEvent.KEY_DOWN, keyPressed);			

		
private function keyPressed(event:KeyboardEvent):void {         
            
	if ( Key.isDown( "P".charCodeAt() ) ) {				
		trace("P");	
	}
		
}
 
*****************************************************/

package br.mayworm.keyboard {
	
	import flash.display.Stage;
    import flash.events.Event;
    import flash.events.KeyboardEvent;    
	
    public class Key {	
       
        private static var initialized:Boolean = false;
        private static var keysDown:Object = new Object();       
        
        public static function init(stage:Stage):void {
            if (!initialized) {                
                stage.addEventListener(KeyboardEvent.KEY_DOWN, keyPressed);
                stage.addEventListener(KeyboardEvent.KEY_UP, keyReleased);
                stage.addEventListener(Event.DEACTIVATE, clearKeys);               
                initialized = true;
            }
        }       
		
		public static function remove(stage:Stage):void {                      
			if (initialized) {
				stage.removeEventListener(KeyboardEvent.KEY_DOWN, keyPressed);
				stage.removeEventListener(KeyboardEvent.KEY_UP, keyReleased);
				stage.removeEventListener(Event.DEACTIVATE, clearKeys);               
				initialized = false;            	
			}            
        }  
        
        public static function isDown(keyCode:uint):Boolean {
            if (!initialized) throw new Error("Keyboard não iniciado");			
            return Boolean(keyCode in keysDown);			
        }       
        
        private static function keyPressed(event:KeyboardEvent):void {         
            keysDown[event.keyCode] = true;
        }       
        
        private static function keyReleased(event:KeyboardEvent):void {
            if (event.keyCode in keysDown) delete keysDown[event.keyCode];            
        }       
        
        private static function clearKeys(event:Event):void {            
            keysDown = new Object();
        }
		
    }
	
}