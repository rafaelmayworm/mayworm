
/*****************************************************	 
     ___     Developer- Rafael Mayworm               
    (¤;¤)    Page- http://www.rafaelmayworm.com.br   
    -{=}-    Mail- rafaelmayworm@gmail.com           
     - -      Msn- rafaelmayworm@hotmail.com         
  ---------	                                     
  
  @USING  
  //para funcionar o "this" já deve ter sido adicionado - addChild()
  import br.mayworm.stage.ReturnStage;
  trace(ReturnStage(this));
  ReturnStage(this).addEventListener(Event.RESIZE, function(e:*):void { trace("Teste: " + Math.random()) } );
  
*****************************************************/
  
package br.mayworm.stage {	
	
	import flash.display.Stage;	
	
	public function ReturnStage(obj:*):Stage {
		
		var _stage:Stage;			
		
		function isStage(obj:*):void {			
			(obj is Stage) ? _stage = obj : isStage(obj.parent);
		}
		
		isStage(obj);	
		
		return _stage;
		
	}
	
}