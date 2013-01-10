
/*****************************************************	 
     ___     Developer- Rafael Mayworm               
    (¤;¤)    Page- http://www.rafaelmayworm.com.br   
    -{=}-    Mail- rafaelmayworm@gmail.com           
     - -      Msn- rafaelmayworm@hotmail.com         
  ---------	                                     
  
  @USING  
  import br.mayworm.shape.ShapeRect;
  addChild(new ShapeRect(500, 500, 0xFFFFFF)) as ShapeRect;
  
*****************************************************/
  
package br.mayworm.shape {	
	
	import flash.display.Shape;	
	
	public class ShapeRect extends Shape {		
		
		public function ShapeRect(w:Number, h:Number, cor:Number, a:Number = 1):void {						
			
			this.graphics.beginFill(cor, a);
			this.graphics.drawRect(0, 0, w, h);
			this.graphics.endFill();			
			
		}
		
	}	
}