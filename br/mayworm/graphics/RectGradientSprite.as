package br.mayworm.graphics {
	
	public class RectGradientSprite extends RectSprite
	{
		public static const LINEAR:String = "linear";
		public static const RADIAL:String = "radial";
		
		public function get type():String
		{
			return _type;
		}
		public function set type(value:String):void
		{
			_type = value;
			draw();
		}
		private var _type:String;		
	
		public function get fillColors():Array
		{
			return _fillColors;
		}
		public function set fillColors(value:Array):void
		{
			_fillColors = value;
		}
		private var _fillColors:Array;
				
		public function get fillAlphas():Array
		{
			return _fillAlphas;
		}
		public function set fillAlphas(value:Array):void
		{
			_fillAlphas = value;
		}
		private var _fillAlphas:Array;
		
		public function get fillRatios():Array
		{
			return _fillRatios;
		}
		public function set fillRatios(value:Array):void
		{
			_fillRatios = value;
		}
		private var _fillRatios:Array;
		
		/**
		 * <code>Sprite</code> retangular com preenchimento gradiente.
		 * @param	width
		 * @param	height
		 * @param	type
		 * @param	fillColors
		 * @param	fillAlphas
		 * @param	fillRatios
		 * @param	lineSize
		 * @param	lineColor
		 * @param	lineAlpha
		 * @param	blendMode
		 */
		public function RectGradientSprite(width:Number, height:Number, type:String = "linear", fillColors:Array = null, fillAlphas:Array = null, fillRatios:Array = null, lineSize:Number = 1, lineColor:uint = 0x000000, lineAlpha:Number = 1, blendMode:String = "normal"):void
		{
			_type = type;
			
			if(_fillColors != null)
				_fillColors = fillColors;
			else
				_fillColors = [0xff0000, 0xffffff];
			
			if (fillAlphas != null)
				_fillAlphas = fillAlphas;
			else
				_fillAlphas = [];
				
			while (_fillAlphas.length < fillColors.length)
				_fillAlphas.push(1);
				
			if (_fillRatios != null)
				_fillRatios = fillRatios;
			else
				_fillRatios = [];
				
			while (_fillRatios.length < fillColors.length)
				_fillRatios.push(1);
				
			super(width, height, 0xff0000, 1, lineSize, lineColor, lineAlpha, blendMode);
		}
				
		override public function fill():void
		{
			graphics.beginGradientFill(type, fillColors, fillAlphas, fillRatios);
		}
		
	}
	
}