
/*****************************************************	 
     ___     Developer- Rafael Mayworm               |
 	(¤;¤)    Page- http://www.rafaelmayworm.com.br   |
    -{=}-    Mail- rafaelmayworm@gmail.com           |
 	 - -	 Msn- rafaelmayworm@hotmail.com          |
  ---------	                                
  
 @Using
 Btns.add( [teste1, teste2, teste3], [MouseEvent.CLICK, MouseEvent.ROLL_OVER, MouseEvent.ROLL_OUT], [clickThumb, overThumb, outThumb] );			
 
 @remove
 Btns.remove( [teste1, teste2, teste3], [MouseEvent.CLICK, MouseEvent.ROLL_OVER, MouseEvent.ROLL_OUT], [clickThumb, overThumb, outThumb] );			

 function clickThumb(e:MouseEvent):void{
	trace("click");
 }

 function overThumb(e:MouseEvent):void{	
	e.currentTarget.alpha = 0.4;
 }

 function outThumb(e:MouseEvent):void{	
	e.currentTarget.alpha = 1;
 }
 
*****************************************************/


package br.mayworm.ui {	
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.Event;	

	public class Btns{		
		
		public static function add(btns:Array, type:Array, func:Array, _buttonMode:Boolean = true, _mouseChildren:Boolean = false ):void {		
			
			var i:int, p:int;
			
			for (i = 0; i < btns.length; i++) {								
			
				for (p = 0; p < type.length; p++) btns[i].addEventListener(type[p], func[p]);				
				
				if( (btns[i] as Sprite) || (btns[i] as MovieClip) ){
					btns[i].buttonMode = _buttonMode;
					btns[i].mouseChildren = _mouseChildren;
				}
					
			}			
			
		}
		
		public static function remove(btns:Array, type:Array, func:Array, _buttonMode:Boolean = false, _mouseChildren:Boolean = false ):void {
			
			var i:int, p:int;
			
			for (i = 0; i < btns.length; i++) {											
				
				for (p = 0; p < type.length; p++) btns[i].removeEventListener(type[p], func[p]);									
				
				if( (btns[i] as Sprite) || (btns[i] as MovieClip) ){
					btns[i].buttonMode = _buttonMode;
					btns[i].mouseChildren = _mouseChildren;
				}
				
			}		

		}	
		
	}
}