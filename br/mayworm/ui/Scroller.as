package br.mayworm.ui {
    
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import caurina.transitions.Tweener;
	
	public class Scroller extends Sprite {

		private var yOffset:Number = 0;		
		private var yMin:Number = 0;
		private var yMax:Number;

		private var mask_sc:*;
		private var content_sc:*;
		private var barra_sc:*;
		private var drag_sc:*;

		public function Scroller(_mask_sc:*, _content_sc:*, _barra_sc:*, _drag_sc:*) {					
				
			mask_sc = _mask_sc;		
			content_sc = _content_sc;		
			barra_sc = _barra_sc;
			drag_sc = _drag_sc;

			drag_sc.addEventListener(MouseEvent.MOUSE_DOWN, thumbDown);			
			drag_sc.stage.addEventListener(MouseEvent.MOUSE_UP, thumbUp);			
			content_sc.addEventListener(MouseEvent.MOUSE_WHEEL, onUpdate);			
			barra_sc.addEventListener(MouseEvent.MOUSE_DOWN, onUpdate);			
				
			yMin = barra_sc.y;
			yMax = barra_sc.height - drag_sc.height;			
			content_sc.mask = mask_sc;								
			
		}

		private function thumbDown(e:MouseEvent):void {
			this.dispatchEvent(new Event("MOUSE_DOWN_DRAG"));
			drag_sc.stage.addEventListener(MouseEvent.MOUSE_MOVE, onUpdate);
			yOffset = drag_sc.parent.mouseY - drag_sc.y;
		}

		private function thumbUp(e:MouseEvent):void {
			drag_sc.stage.removeEventListener(MouseEvent.MOUSE_MOVE, onUpdate);						
		}

		public function remove():void {
			drag_sc.removeEventListener(MouseEvent.MOUSE_DOWN, thumbDown);			
			drag_sc.stage.removeEventListener(MouseEvent.MOUSE_UP, thumbUp);			
			content_sc.removeEventListener(MouseEvent.MOUSE_WHEEL, onUpdate);			
			barra_sc.removeEventListener(MouseEvent.MOUSE_DOWN, onUpdate);			
		}
		
		public function onUpdate(e:MouseEvent = null):void {						
			
			if (content_sc.height <= mask_sc.height) {				
				drag_sc.y = yMin;
				barra_sc.visible = false;
				drag_sc.visible = false;
			}else {
				barra_sc.visible = true;
				drag_sc.visible = true;				
			}
		
			if (e != null) (e.delta != 0) ? drag_sc.y = drag_sc.y - e.delta : drag_sc.y = drag_sc.parent.mouseY - yOffset;			
			
			if (drag_sc.y < barra_sc.y) drag_sc.y = barra_sc.y;						
			if (drag_sc.y > barra_sc.y + yMax) drag_sc.y = barra_sc.y + yMax;						
			
			var sp:Number = (drag_sc.y - barra_sc.y) / yMax;
			
			Tweener.addTween(content_sc, { y:( -sp * (content_sc.height - mask_sc.height)) + mask_sc.y, time:1 } );						
			
			if (e != null) e.updateAfterEvent();	
			
		}
		
		/*public function onUpdate(e:MouseEvent = null):void {						
			
			if (content_sc.height <= mask_sc.height) {				
				drag_sc.y = yMin;
				barra_sc.visible = false;
				drag_sc.visible = false;
			}else {
				barra_sc.visible = true;
				drag_sc.visible = true;				
			}
						
			if (e != null) (e.delta != 0) ? drag_sc.y = drag_sc.y - e.delta : drag_sc.y = mouseY - yOffset;			
			
			if (drag_sc.y <= mask_sc.y) drag_sc.y = mask_sc.y;						
			if (drag_sc.y >= mask_sc.y + yMax) drag_sc.y = mask_sc.y + yMax;						
			
			var sp:Number = (drag_sc.y - mask_sc.y) / yMax;			
			
			Tweener.addTween(content_sc, { y:( -sp * (content_sc.height - mask_sc.height)) + mask_sc.y, time:1 } );						
			
			if (e != null) e.updateAfterEvent();	
			
		}*/
		
	}
	
}