package br.mayworm.events {	
	
	import flash.events.Event;
	
	public class ConsoleEvent extends Event {		
		
		public static var COMMAND:String = "onCommand";
		
		public var cmd:String;

		public function ConsoleEvent($type:String, $cmd:String){
			super($type);
			cmd = $cmd;
		}
		
		public override function clone():Event {			
			return new ConsoleEvent(type, cmd);			
		}		

	}

}