
/*****************************************************	 
     ___     Developer- Rafael Mayworm               
    (¤;¤)    Page- http://www.rafaelmayworm.com.br   
    -{=}-    Mail- rafaelmayworm@gmail.com           
     - -      Msn- rafaelmayworm@hotmail.com         
  ---------	                                     
*****************************************************/
  
package br.mayworm.utils {
	import flash.utils.ByteArray;
	
	public class ArrayUtils {	
		
		public static function randomSort(array:Array):Array {			
			var tempArray:Array = [];
			while (array.length > 0) tempArray.push(array.splice(Math.round(Math.random() * (array.length - 1)), 1)[0]);			
			return tempArray;
		}

		public static function searchArray(value:*, array:Array):Boolean {			
			for (var i : int = 0; i != array.length; i++) {
				if (array[i] == value) return true;				
			}
			return false;
		}

		public static function removeFromArray(value:*, array:Array):Array {
			if(array.length > 0) {				
				for (var i:int = 0; i != array.length; i++) {
					if (array[i] == value) array.splice(i, 1);					
				}
			}
			return array;
		}
		
		public static function removeDuplicates(array:Array):Array {
			var tempArray:Array = [];
			for each(var i:* in array) {
				if(!searchArray(i, tempArray)) tempArray.push(i);				
			}
			return tempArray;
		}
		
		public static function clone(source:Array):Array{ 
			var myBA:ByteArray = new ByteArray();
			myBA.writeObject(source); 
			myBA.position = 0; 
			return(myBA.readObject());
		}
		
	}
}
