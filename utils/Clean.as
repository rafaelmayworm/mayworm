
/*****************************************************	 
     ___     Developer- Rafael Mayworm               
    (¤;¤)    Page- http://www.rafaelmayworm.com.br   
    -{=}-    Mail- rafaelmayworm@gmail.com           
     - -      Msn- rafaelmayworm@hotmail.com         
  ---------	                                     
*****************************************************/
  
package br.mayworm.utils {
	
	import flash.display.DisplayObjectContainer;	
	import flash.events.Event;
	
	public class Clean {
		
		public function Clean():void{ }		
		
		public static function cleanTarget(obj:DisplayObjectContainer, removePai:Boolean=false):void {
						
			while (obj.numChildren != 0) {
				
				var child = obj.getChildAt(0);
				
				/*if (obj.getChildAt(0) is DisplayObjectContainer) {					
					cleanTarget(DisplayObjectContainer(child));
				}*/
				
				var t = obj.removeChildAt(0);				
				t = null;//liberando memória	
				child = null;
				
			}
			
			if (removePai) {
				obj.parent.removeChild(obj);
				obj = null;
			}
			
		}
		
	}
	
}