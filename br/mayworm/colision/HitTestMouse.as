
/*****************************************************	 
     ___     Developer- Rafael Mayworm               
    (¤;¤)    Page- http://www.rafaelmayworm.com.br   
    -{=}-    Mail- rafaelmayworm@gmail.com           
     - -      Msn- rafaelmayworm@hotmail.com         
  ---------	                                     
*****************************************************/

package br.mayworm.colision {
	
	import flash.display.DisplayObject;
	import flash.geom.Point;

    public class HitTestMouse {
		
		public static function colision(target:DisplayObject):Boolean {
			
			var point:Point = target.stage.localToGlobal(new Point(target.stage.mouseX, target.stage.mouseY));						
			
			if (target.hitTestPoint(point.x, point.y, true)) {								
			    return true;
			}else{
			    return false;
			}			
			
		}

    }

}

