
/*****************************************************	 
     ___     Developer- Rafael Mayworm               
    (¤;¤)    Page- http://www.rafaelmayworm.com.br   
    -{=}-    Mail- rafaelmayworm@gmail.com           
     - -      Msn- rafaelmayworm@hotmail.com         
  ---------	                                     
  
  @USING  
  import br.mayworm.ui.MouseEnabled;
  import flash.display.DisplayObjectContainer;
  MouseEnabled(presencaMarcosaFiol, false);
  
*****************************************************/
  
package br.mayworm.ui {		
	
	import flash.display.DisplayObjectContainer;
	
	public function MouseEnabled(obj:*, _enabled:Boolean = false, allChildren:Boolean = false):void {		
		
		for (var i:int = 0; i < obj.numChildren; i++) {		
			
			if (obj.getChildAt(i) is DisplayObjectContainer) {				
				obj.getChildAt(i).mouseEnabled = _enabled;
				if (allChildren) MouseEnabled(obj.getChildAt(i), _enabled, allChildren);				
			}
			
		}
		
		//if (obj is DisplayObjectContainer) obj.mouseEnabled = _enabled;		
		
		obj.mouseEnabled = _enabled;
		
	}
	
}