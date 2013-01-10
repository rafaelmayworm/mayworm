package br.mayworm.graphics {
	
	import flash.display.BitmapData;	
	
	public class RectBitmapSprite extends RectSprite
	{
		
		public function get bitmap():BitmapData
		{
			return _bitmap;
		}
		public function set bitmap(value:BitmapData):void
		{
			_bitmap = value;
			draw();
		}
		private var _bitmap:BitmapData;
		
		
		public function get smooth():Boolean
		{
			return _smooth;
		}
		public function set smooth(value:Boolean):void
		{
			_smooth = value;
			draw();
		}
		private var _smooth:Boolean = false;
		
		/**
		 * <code>Sprite</code> retangular com um <code>BitmapData</code> multiplicado em sua superfície.
		 * @param	bitmap
		 * @param	width
		 * @param	height
		 * @param	smooth
		 * @param	lineSize
		 * @param	lineColor
		 * @param	lineAlpha
		 * @param	blendMode
		 */
		public function RectBitmapSprite(bitmap:BitmapData, width:Number, height:Number, smooth:Boolean = false, lineSize:Number = 1, lineColor:uint = 0x000000, lineAlpha:Number = 1, blendMode:String = "normal"):void
		{
			_bitmap = bitmap;
			_smooth = smooth;
			super(width, height, 0xff0000, 1, lineSize, lineColor, lineAlpha, blendMode);
		}		
		
		override public function fill():void
		{
			graphics.beginBitmapFill(bitmap, null, true, smooth);
		}
		
	}
	
}