package br.mayworm.shape 
{
	import flash.display.Sprite;
	
	public class GenericShape extends Sprite
	{
		
		public function GenericShape(w:Number, h:Number, cor:Number, a:Number=1) 
		{
			
			this.graphics.beginFill(cor, a);
			this.graphics.drawRect(0, 0, w, h);
			this.graphics.endFill();
			
		}
		
	}

}