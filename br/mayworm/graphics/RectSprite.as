package br.mayworm.graphics {
	
	public class RectSprite extends ShapeSprite
	{
		/**
		 * <code>Sprite</code> retangular com cor e fundo flexíveis.
		 * @param	width
		 * @param	height
		 * @param	fillColor
		 * @param	fillAlpha
		 * @param	lineSize
		 * @param	lineColor
		 * @param	lineAlpha
		 * @param	blendMode
		 */
		public function RectSprite(width:int, height:int, fillColor:uint = 0xff0000, fillAlpha:Number = 1, lineSize:Number = 1, lineColor:uint = 0x000000, lineAlpha:Number = 1, blendMode:String = "normal")
		{
			super(shape, width, height, fillColor, fillAlpha, lineSize, lineColor, lineAlpha, blendMode);
		}		
		
		private function shape():void
		{
			graphics.drawRect(0, 0, width, height);
		}
		
	}
	
}