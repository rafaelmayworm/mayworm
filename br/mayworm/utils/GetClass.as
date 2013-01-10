
/*****************************************************	 
     ___     Developer- Rafael Mayworm               
    (¤;¤)    Page- http://www.rafaelmayworm.com.br   
    -{=}-    Mail- rafaelmayworm@gmail.com           
     - -      Msn- rafaelmayworm@hotmail.com         
  ---------	                                     
*****************************************************/

package br.mayworm.utils {
	
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	
	public function GetClass(obj:*):Class {
		return getDefinitionByName(getQualifiedClassName(obj)) as Class;
	}
	
}