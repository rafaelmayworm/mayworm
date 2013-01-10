package br.mayworm.navigation {	
	
	import flash.display.Sprite;		
	import flash.events.MouseEvent;	
		
	import com.greensock.TweenMax; 
	import com.greensock.easing.Expo;

	public class NavigationArrows extends Sprite {					
		
		private var container:Sprite;
		private var setaRight:Sprite;
		private var setaLeft:Sprite;
		
		public var delayMove:Number = 1;
		
		private var atual:int;
		private var total:int;		
		private var posXini:int;
		private var moveClick:int;	
		private var itensView:int;			
		
		public function init(_container:Sprite, _atual:int = 0, _total:int = 0, _posXinit:int = 0, _moveClick:int = 0, _itensView:int = 0, _cache:Boolean = false):void {							
			
			container = _container;			
			
			atual = _atual;
			total = _total;
			posXini = _posXinit;
			moveClick = _moveClick;	
			itensView = _itensView;			
			
			container.x = posXini;
			
			if(_cache) container.cacheAsBitmap = true;			
			
			initStatusArrows();
			
		}
		
		public function initArrows(_setaLeft:Sprite, _setaRight:Sprite):void {			
			
			setaLeft = _setaLeft;
			setaRight = _setaRight;
			
			setaLeft.addEventListener(MouseEvent.CLICK, clickSeta);
			setaRight.addEventListener(MouseEvent.CLICK, clickSeta);			
			setaRight.buttonMode = setaLeft.buttonMode = true;
			setaRight.mouseChildren = setaLeft.mouseChildren = true;			
			
		}
		
		public function remove():void {			
			setaLeft.removeEventListener(MouseEvent.CLICK, clickSeta);
			setaRight.removeEventListener(MouseEvent.CLICK, clickSeta);
		}
		
		private function clickSeta(e:MouseEvent):void {								
			(e.currentTarget == setaLeft) ?	atual-- : atual++;			
			move();			
		}		
		
		public function move():void {			
			initStatusArrows();						
			TweenMax.to(container, delayMove, { x:( -(atual * moveClick) + posXini), ease:Expo.easeInOut } );							
		}
		
		private function initStatusArrows():void {
			
			setaRight.visible = true;
			setaLeft.visible = true;
			
			if (atual <= 0) setaLeft.visible = false;
			if (atual >= total - itensView) setaRight.visible = false;
			
			if (total < itensView) setaLeft.visible = setaRight.visible = false;							
		
		}

	}

}