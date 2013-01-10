
/*****************************************************	 
     ___     Developer- Rafael Mayworm               
    (¤;¤)    Page- http://www.rafaelmayworm.com.br   
    -{=}-    Mail- rafaelmayworm@gmail.com           
     - -      Msn- rafaelmayworm@hotmail.com         
  ---------	                                     
*****************************************************/

package br.mayworm.ui {
	

	
	/*
	
	By Rafael Mayworm
	
	Using...
	
		
		import br.mayworm.ui.BtnSound;			
		
		//adicionar os sons  - necessário add o Som apenas uma vez
		BtnSound.addSoundEvent( "clickDefault", new MoveMenu(), 1 );
		BtnSound.addSoundEvent( "overDefault" , new ClickMenu(), 0.8 );	
		
		//addEvento		
		BtnSound.add( [this], [MouseEvent.ROLL_OVER, MouseEvent.ROLL_OUT], [overThumb, outThumb], ["overDefault", null], true, false );									
		
		@remove - BtnSound.remove( [this], [MouseEvent.ROLL_OVER, MouseEvent.ROLL_OUT], [overThumb, outThumb], ["overDefault", null], true, false );				
		
	*/
	
	import flash.events.MouseEvent;
	import flash.events.Event;
	import br.mayworm.sound.SoundSkin;
	import flash.utils.Dictionary;

	public class BtnSound {	
		
		public static var soundsEvents:Dictionary 	   = new Dictionary();
		public static var dadosSoundsEvents:Dictionary = new Dictionary();		
		
		public static function add(btns:Array, type:Array, func:Array, sons:Array = null, _buttonMode:Boolean = true, _mouseChildren:Boolean = false ):void {		
			
			var i:int, p:int;
			
			for (i = 0; i < btns.length; i++) {											

				for (p = 0; p < type.length; p++) {
					
					btns[i].addEventListener(type[p], func[p]);
					
					//addSound/////////////////////////////
					if (sons != null) {						
						if (sons[p] != null) {							
							
							var nam:String = btns[i].name + "_" + type[p];
							
							dadosSoundsEvents[nam] = { name:sons[p], func:evtMouseSound() };							
							btns[i].addEventListener( type[p], dadosSoundsEvents[nam].func );
							
						}						
					}
					///////////////////////////////////////
					
				}				
				
				btns[i].buttonMode = _buttonMode;
				btns[i].mouseChildren = _mouseChildren;
			
			}			
			
		}
		
		public static function addSoundEvent(name:String, sound:*, volume:Number = 1):void {
			soundsEvents[name] = { som:sound, vol:volume };
		}
		
		private static function evtMouseSound():Function {				
			return function(e:MouseEvent):void { 				
				var nam:String = e.currentTarget.name + "_" + e.type;				
				playSom(dadosSoundsEvents[nam].name);				
			};
		}
		
		public static function playSom(nam:String):void {			
			
			if (soundsEvents[nam] != null && soundsEvents[nam] != undefined) {				
				//var a = new SoundSkin(soundsEvents[nam].som, 1).play();				
				var a:SoundSkin = new SoundSkin(soundsEvents[nam].som, 1);				
				a.volume = soundsEvents[nam].vol;
				a.play();				
			}
			
		}
		
		public static function remove(btns:Array, type:Array, func:Array, sons:Array = null, _buttonMode:Boolean = true, _mouseChildren:Boolean = false ):void {
			
			var i:int, p:int;
			
			for (i = 0; i < btns.length; i++) {											
				
				for (p = 0; p < type.length; p++) {
					
					btns[i].removeEventListener(type[p], func[p]);									
					
					//addSound/////////////////////////////
					if (sons != null) {							
						if (sons[p] != null) {
							
							var nam:String = btns[i].name + "_" + type[p];						
							
							btns[i].removeEventListener( type[p], dadosSoundsEvents[nam].func );							
							delete dadosSoundsEvents[nam];				
							
						}						
					}
					///////////////////////////////////////
					
				}
				
				btns[i].buttonMode = _buttonMode;
				btns[i].mouseChildren = _mouseChildren;
				
			}		

		}	
		
	}
}