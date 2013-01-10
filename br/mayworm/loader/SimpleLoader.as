
/*****************************************************	 
     ___     Developer- Rafael Mayworm               
    (¤;¤)    Page- http://www.rafaelmayworm.com.br   
    -{=}-    Mail- rafaelmayworm@gmail.com           
     - -      Msn- rafaelmayworm@hotmail.com         
  ---------	                                     
  
  @USING  
  
  addChild(SimpleLoader("peao.swf"));
  
    OR
  
  var teste:Loader = SimpleLoader("peao.swf");
  teste.contentLoaderInfo.addEventListener(Event.COMPLETE, onComplete);				
  function onComplete( e:Event ):void {
    trace("carregou", e.target.content);											
  }
  addChild(teste);  
  
  
*****************************************************/
  
package br.mayworm.loader {		
	
	import flash.display.Loader;
	import flash.net.URLRequest;
	
	public function SimpleLoader(str:String):Loader {
		
		var l:Loader = new Loader() as Loader;				
		l.load(new URLRequest(str));	
		
		return l;
		
	}
	
}