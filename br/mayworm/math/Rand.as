
/*****************************************************	 
     ___     Developer- Rafael Mayworm               
    (¤;¤)    Page- http://www.rafaelmayworm.com.br   
    -{=}-    Mail- rafaelmayworm@gmail.com           
     - -      Msn- rafaelmayworm@hotmail.com         
  ---------	                                     
*****************************************************/
  
package br.mayworm.math {
	public class Rand {			
		public static function random(min:Number, max:Number):Number{			
			return Math.floor(Math.random() * (max - min + 1)) + min;
		}		
	}	
}