package br.mayworm.graphics {
	
	import flash.display.Sprite;
	
	public class ShapeSprite extends Sprite
	{
		
		override public function get  width():Number
		{
			return _width;
		}
		override public function set width(value:Number):void
		{
			_width = value;
			draw();
		}
		private var _width:Number = 0;
		
		
		override public function get height():Number
		{
			return _height;
		}
		override public function set height(value:Number):void
		{
			_height = value;
			draw();
		}
		private var _height:Number = 0;
		
		
		public function get fillColor():uint
		{
			return _fillColor;
		}
		public function set fillColor(value:uint):void
		{
			_fillColor = value;
			draw();
		}
		private var _fillColor:uint;
				
		public function get fillAlpha():Number
		{
			return _fillAlpha;
		}
		public function set fillAlpha(value:Number):void
		{
			_fillAlpha = value;
			draw();
		}
		private var _fillAlpha:Number;
				
		public function get lineSize():Number
		{
			return _lineSize;
		}
		public function set lineSize(value:Number):void
		{
			_lineSize = value;
			draw();
		}
		private var _lineSize:Number;
				
		public function get lineColor():uint
		{
			return _lineColor;
		}
		public function set lineColor(value:uint):void
		{
			_lineColor = value;
			draw();
		}
		private var _lineColor:uint;
				
		public function get lineAlpha():Number
		{
			return _lineAlpha;
		}
		public function set lineAlpha(value:Number):void
		{
			_lineAlpha = value;
			draw();
		}
		private var _lineAlpha:Number;
				
		private var drawShape:Function;
		
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
		public function ShapeSprite(shapeFunction:Function, width:uint, height:uint, fillColor:uint = 0xff0000, fillAlpha:Number = 1, lineSize:Number = 1, lineColor:uint = 0x000000, lineAlpha:Number = 1, blendMode:String = "normal")
		{
			_fillColor = fillColor;
			_fillAlpha = fillAlpha;
			
			_lineSize = lineSize;
			_lineColor = lineColor;
			_lineAlpha = lineAlpha;
			
			_width = width;
			_height = height;
			
			this.blendMode = blendMode;
			cacheAsBitmap = true;
			
			drawShape = shapeFunction;
			
			draw();
		}		
		
		public function draw():void
		{
			graphics.clear();
			
			if(lineSize > 0)
				graphics.lineStyle(lineSize, lineColor, lineAlpha, false, "none", "square", "miter");
			
			fill();
			
			drawShape();
			
			graphics.endFill();
		}
		
		public function fill():void
		{
			graphics.beginFill(fillColor, fillAlpha);
		}
		
	}
	
}