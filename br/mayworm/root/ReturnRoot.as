
/*****************************************************	 
     ___     Developer- Rafael Mayworm               
    (¤;¤)    Page- http://www.rafaelmayworm.com.br   
    -{=}-    Mail- rafaelmayworm@gmail.com           
     - -      Msn- rafaelmayworm@hotmail.com         
  ---------	                                     
  
  @USING  
  //para funcionar o "this" já deve ter sido adicionado - addChild()
  import br.mayworm.root.ReturnRoot;
  trace(ReturnRoot(this));
  //ReturnRoot(this).teste();
  //String(LoaderInfo(ReturnRoot(this).loaderInfo).parameters.usaVar)
  
*****************************************************/
  
package br.mayworm.root {	
	
	import flash.display.Stage;	
	
	public function ReturnRoot(obj:*):* {		
		
		var __root:*;	
			
		function search(obj:*):void {						
			__root = obj
			if(!(obj.parent is Stage)) search(obj.parent);			
		}
			
		search(obj);	
			
		return __root;		
		
	}
	
}