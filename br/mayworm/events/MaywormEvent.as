
/*****************************************************	 
     ___     Developer- Rafael Mayworm               
    (¤;¤)    Page- http://www.rafaelmayworm.com.br   
    -{=}-    Mail- rafaelmayworm@gmail.com           
     - -      Msn- rafaelmayworm@hotmail.com         
  ---------	                                     
*****************************************************/

package br.mayworm.events {
	
	import flash.events.Event;

	public class MaywormEvent extends Event {					
		
		public static const OPENMODULE:String = "openmodule";
		public static const CLOSEMODULE:String = "openmodule";
		
		public static const OPEN:String = "open";
		public static const PROGRESS:String = "progress";
		public static const COMPLETE:String = "complete";		
		
		private var _params				:Object;
		
		public function MaywormEvent( type :String, params :Object = null ) {			
			super(type);			
			_params = params;			
		}
		
		
		public function get params():Object{
            return _params;
        }
		
	}
	
}
