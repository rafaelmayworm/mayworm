package br.mayworm.utils {
	
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.Shape;
	import flash.display.InteractiveObject;
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.Stage;
	import flash.text.StaticText;
	import flash.text.TextField;
	import flash.events.Event;
	
	public final class CloneMc {
		
		private var lLoad:Loader;
		private var dTarget:DisplayObject;
		private var fCall:Function;
		
		private var nDig:uint;
		private var vIndex:Vector.<int>;
		private var vFrame:Vector.<int>;
		
		public function CloneMc() {
			lLoad = new Loader();
		}
		
		public function cloneMovie(mc:DisplayObject, callback:Function):DisplayObject {
			fCall = callback;
			nDig = 0;
			vIndex = new Vector.<int>();
			vFrame = new Vector.<int>();			
			var d:DisplayObject = duplicateMovie(mc);			
			if (d == null && mc.root != null) {				
				lLoad.contentLoaderInfo.addEventListener(Event.COMPLETE,onClone);
				lLoad.loadBytes(mc.root.loaderInfo.bytes);
			}
			return d;
		}
		
		private function duplicateMovie(mc:DisplayObject):DisplayObject {
			
			if (mc == mc.root) return null;			
			
			switch((mc as Object).constructor) {
				case DisplayObject:
				case Sprite:
				case DisplayObjectContainer:
				case MovieClip:
				case Shape:
				case StaticText:
				case InteractiveObject:
				case TextField:
				case Bitmap:
				case Loader:
				case Stage:
					break;
				default:
					return new (mc as Object).constructor();
			}
			
			if (mc.parent == null) return null;			
			var p:DisplayObjectContainer = mc.parent;			
			if (p is MovieClip) vFrame.push( (p as MovieClip).currentFrame );			
			vIndex.push( p.getChildIndex(mc) );
			var o:DisplayObject = duplicateMovie(p);
			if (o == null) return null;			
			if (p is MovieClip) (o as MovieClip).gotoAndStop(vFrame.pop());			
			o = (o as DisplayObjectContainer).getChildAt(vIndex.pop()) as MovieClip;			
			return o;
			
		}
		
		private function onClone(e:Event):void {
			fCall(reverseClone(lLoad.content));
		}
		
		private function reverseClone(mc:DisplayObject):DisplayObject {
			if (vIndex.length == 0) return mc;			
			if (mc is MovieClip) (mc as MovieClip).gotoAndStop(vFrame.pop());			
			mc = (mc as DisplayObjectContainer).getChildAt(vIndex.pop()) as MovieClip;			
			return reverseClone(mc);			
		}
		
	}
}
