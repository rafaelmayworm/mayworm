
/*****************************************************	 
     ___     Developer- Rafael Mayworm               
    (¤;¤)    Page- http://www.rafaelmayworm.com.br   
    -{=}-    Mail- rafaelmayworm@gmail.com           
     - -      Msn- rafaelmayworm@hotmail.com         
  ---------	                                     
*****************************************************/

package br.mayworm.modules {		
	
	import flash.display.MovieClip;			
	import br.mayworm.events.MaywormEvent;

	public class ModuleMc extends MovieClip {			
		public var params:Object;
		public var closeAtivo:Boolean = true;		
		public function init():void { }		
		public function remove():void {	}		
		public function close():void { if(closeAtivo) dispatchEvent(new MaywormEvent(MaywormEvent.CLOSEMODULE, { mc:this } )); }				
	}		

}