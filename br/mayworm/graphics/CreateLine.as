
/*****************************************************	 
     ___     Developer- Rafael Mayworm               
    (¤;¤)    Page- http://www.rafaelmayworm.com.br   
    -{=}-    Mail- rafaelmayworm@gmail.com           
     - -      Msn- rafaelmayworm@hotmail.com         
  ---------	                                     
  
  @USING  
  import br.mayworm.graphics.CreateLine;
  CreateLine(linha1, 0, 500, dadosColision.x, dadosColision.y, true, 1, 0xFF0000);//cria uma linha
  CreateLine(linha1, dadosColision.x, dadosColision.y, teste1.x, teste1.y, false, 1, 0x00FF00);//cria uma segunda linha no msm objeto - clear = false
  
*****************************************************/
  
package br.mayworm.graphics {		
	
	
	public function CreateLine(obj:*, posXini:Number, posYini:Number, posXfim:Number, posYfim:Number, clear:Boolean = true, pxLine:Number = 1, color:Number = 0x000000):void {		
	
		if (clear) obj.graphics.clear();		
		obj.graphics.lineStyle(pxLine, color);
		obj.graphics.moveTo(posXini, posYini);		
		obj.graphics.lineTo(posXfim, posYfim);		
		
	}
	
}