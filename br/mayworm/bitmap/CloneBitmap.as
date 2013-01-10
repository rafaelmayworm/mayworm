
/*****************************************************	 
     ___     Developer- Rafael Mayworm               |
 	(¤;¤)    Page- http://www.rafaelmayworm.com.br   |
    -{=}-    Mail- rafaelmayworm@gmail.com           |
 	 - -	 Msn- rafaelmayworm@hotmail.com          |
  ---------	                                
  
 @Using
 addChild(CloneBitmap.clone(e.currentTarget)); 
 OR
 addChild(CloneBitmap.clone(e.currentTarget, 10, 10, 0xFFFFFF)); 
 
*****************************************************/


package br.mayworm.bitmap {	
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.PixelSnapping;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;

	public class CloneBitmap{			
		
		public static function clone(str:*, w:Number = 0, h:Number = 0, c:Number = 0xFFFFFF):Bitmap {			
			
			if (w == 0) w = str.width;
			if (h == 0) h = str.height;		
			
			var tmp:BitmapData = new BitmapData(w, h, true, c);		
			tmp.draw(str, null, null, null, null, true);			
			
			var b:Bitmap = new Bitmap(tmp);
			b.smoothing = true;
			
			return b;			
			
		}	
		
		public static function crop(_x:Number, _y:Number, _width:Number, _height:Number, str:* = null):Bitmap{
			var cropArea:Rectangle = new Rectangle( 0, 0, _width, _height );			
			//var croppedBitmap:Bitmap = new Bitmap( new BitmapData( _width, _height ), PixelSnapping.ALWAYS, true );		
			var croppedBitmap:Bitmap = new Bitmap( new BitmapData( _width, _height, true, 0x00000000), PixelSnapping.ALWAYS, true);
			croppedBitmap.bitmapData.draw( (str != null) ? str : str.stage, new Matrix(1, 0, 0, 1, -_x, -_y) , null, null, cropArea, true );			
			return croppedBitmap;
		}
		
	}
}