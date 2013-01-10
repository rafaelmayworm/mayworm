
/*****************************************************	 
     ___     Developer- Rafael Mayworm               |
 	(¤;¤)    Page- http://www.rafaelmayworm.com.br   |
    -{=}-    Mail- rafaelmayworm@gmail.com           |
 	 - -	 Msn- rafaelmayworm@hotmail.com          |
  ---------	                                
  
 @Using
 
 import com.greensock.*; 
 import com.greensock.easing.*;

 import br.mayworm.array.PositionSequence;

 var arr:Array = PositionSequence(this);

 var tl:TimelineMax = new TimelineMax( {repeat:-1, yoyo:true, repeatDelay:0} );
 tl.appendMultiple( TweenMax.allFrom( arr, 1, {  alpha:0, y:"+80", blurFilter:{ blurX:10, blurX:10 }, ease:Quint.easeInOut }, .02 ) );
 
*****************************************************/

package br.mayworm.array {	
	
	public function PositionSequence(obj:*):Array {
		
		var i:int;			
		var itensMc:Array = [];			
		var mcs_array:Array = [];			

		for (i = 0; i < obj.numChildren; i++) itensMc[i] = { mc:obj.getChildAt(i), x:obj.getChildAt(i).x, y:obj.getChildAt(i).y };

		itensMc.sortOn(["y", "x"], Array.NUMERIC);

		for (i = 0; i < itensMc.length; i++) mcs_array[i] = itensMc[i].mc;
		
		itensMc = null;

		return mcs_array;
		
	}
	
}