/**
 * Cricket Design AS3 Framework
 * @version 2.0
 * @since 2010
 */
package cricketdesign.display.graphics
{
	/**
	 * <code>Sprite</code> circular com cor e fundo flexíveis.
	 * @version 1.0
	 * @since 24/03/2010
	 * 
	 * @author Will Soares @ willsoares.com
	 */
	public class CircSprite extends ShapeSprite
	{
		/**
		 * Largura do <code>Sprite</code>.
		 */
		override public function get  width():Number
		{
			return _width;
		}
		override public function set width(value:Number):void
		{
			_width = value;
			radius = value / 2;
		}
		private var _width:Number = 0;
		
		/**
		 * Altura do <code>Sprite</code>.
		 */
		override public function get height():Number
		{
			return _height;
		}
		override public function set height(value:Number):void
		{
			_height = value;
			radius = value / 2;
		}
		private var _height:Number = 0;
		
		/**
		 * 
		 */
		public function get radius():uint
		{
			return _radius;
		}
		public function set radius(value:uint):void
		{
			_radius = value;
			draw();
		}
		private var _radius:uint;
		
		/**
		 * 
		 */
		public function get getCenter():Boolean
		{
			return _getCenter;
		}
		private var _getCenter:Boolean;
		
		/**
		 * <code>Sprite</code> circular com cor e fundo flexíveis.
		 * @param	radius
		 * @param	getCenter
		 * @param	fillColor
		 * @param	fillAlpha
		 * @param	lineSize
		 * @param	lineColor
		 * @param	lineAlpha
		 * @param	blendMode
		 */
		public function CircSprite(radius:uint,	getCenter:Boolean = true, fillColor:uint = 0xff0000, fillAlpha:Number = 1, lineSize:Number = 1, lineColor:uint = 0x000000, lineAlpha:Number = 1, blendMode:String = "normal")
		{
			_radius = radius;
			_getCenter = getCenter;
			
			super(shape, radius * 2, radius * 2, fillColor, fillAlpha, lineSize, lineColor, lineAlpha, blendMode);
		}
		
		/**
		 * Cria / recria o preenchimento do <code>ShapeSprite</code>.
		 */
		private function shape():void
		{
			var _x:int = 0;
			var _y:int = 0;
			
			if (!getCenter)
			{
				_x = radius;
				_y = radius;
			}
			
			_width = radius * 2;
			_height = radius * 2;
			
			graphics.drawCircle(_x, _y, radius);
		}
		
	}
	
}