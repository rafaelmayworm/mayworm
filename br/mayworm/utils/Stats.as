/**
 *
 * How to use:
 * 
 *	addChild( new Stats() );
 *	
 *	or
 *	
 *	addChild( new Stats( { bg: 0x000000 } ) );
 * 
 **/

package br.mayworm.utils {
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.system.System;
	import flash.text.StyleSheet;
	import flash.text.TextField;
	import flash.utils.getTimer;	

	/**
	 * @private
	 */
	public class Stats extends Sprite
	{	
		protected const WIDTH : uint = 70;
		protected const HEIGHT : uint = 100;
		
		protected var xml : XML;

		protected var text : TextField;
		protected var style : StyleSheet;

		protected var timer : uint;
		protected var fs : uint;
		protected var ms : uint;
		protected var ms_prev : uint;
		protected var mem : Number;
		protected var mem_max : Number;
		
		protected var graph : Bitmap;
		protected var rectangle : Rectangle;
		
		protected var fs_graph : uint;
		protected var mem_graph : uint;
		protected var mem_max_graph : uint;
		
		protected var theme : Object = { bg: 0x000033, fs: 0xffff00, ms: 0x00ff00, mem: 0x00ffff, memmax: 0xff0070 }; 

		/**
		 * <b>Stats</b> FS, MS and MEM, all in one.
		 * 
		 * @param _theme         Example: { bg: 0x202020, fs: 0xC0C0C0, ms: 0x505050, mem: 0x707070, memmax: 0xA0A0A0 } 
		 */
		public function Stats( _theme : Object = null ) : void
		{
			if (_theme)
			{
				if (_theme.bg != null) theme.bg = _theme.bg;
				if (_theme.fs != null) theme.fs = _theme.fs;
				if (_theme.ms != null) theme.ms = _theme.ms;
				if (_theme.mem != null) theme.mem = _theme.mem;
				if (_theme.memmax != null) theme.memmax = _theme.memmax;
			}
			
			mem_max = 0;

			xml = <xml><fs>FS:</fs><ms>MS:</ms><mem>MEM:</mem><memMax>MAX:</memMax></xml>;
		
			style = new StyleSheet();
			style.setStyle("xml", {fontSize:'9px', fontFamily:'_sans', leading:'-2px'});
			style.setStyle("fs", {color: hex2css(theme.fs)});
			style.setStyle("ms", {color: hex2css(theme.ms)});
			style.setStyle("mem", {color: hex2css(theme.mem)});
			style.setStyle("memMax", {color: hex2css(theme.memmax)});
			
			text = new TextField();
			text.width = WIDTH;
			text.height = 50;
			text.styleSheet = style;
			text.condenseWhite = true;
			text.selectable = false;
			text.mouseEnabled = false;
			
			graph = new Bitmap();
			graph.y = 50;
			
			rectangle = new Rectangle( WIDTH - 1, 0, 1, HEIGHT - 50 );			
			
			addEventListener(Event.ADDED_TO_STAGE, init, false, 0, true);
			addEventListener(Event.REMOVED_FROM_STAGE, destroy, false, 0, true);
		}

		private function init(e : Event) : void
		{
			graphics.beginFill(theme.bg);
			graphics.drawRect(0, 0, WIDTH, HEIGHT);
			graphics.endFill();

			addChild(text);
			
			graph.bitmapData = new BitmapData(WIDTH, HEIGHT - 50, false, theme.bg);
			addChild(graph);
			
			addEventListener(MouseEvent.CLICK, onClick);
			addEventListener(Event.ENTER_FRAME, update);
		}
		
		private function destroy(e : Event) : void
		{
			graphics.clear();
			
			while(numChildren > 0)
				removeChildAt(0);			
			
			graph.bitmapData.dispose();
			
			removeEventListener(MouseEvent.CLICK, onClick);
			removeEventListener(Event.ENTER_FRAME, update);
		}		

		private function update(e : Event) : void
		{
			timer = getTimer();
			
			if( timer - 1000 > ms_prev )
			{
				ms_prev = timer;
				mem = Number((System.totalMemory * 0.000000954).toFixed(3));
				mem_max = mem_max > mem ? mem_max : mem;
				
				fs_graph = Math.min( graph.height, ( fs / stage.frameRate ) * graph.height );
				mem_graph =  Math.min( graph.height, Math.sqrt( Math.sqrt( mem * 5000 ) ) ) - 2;
				mem_max_graph =  Math.min( graph.height, Math.sqrt( Math.sqrt( mem_max * 5000 ) ) ) - 2;
				
				graph.bitmapData.scroll( -1, 0 );
				
				graph.bitmapData.fillRect( rectangle , theme.bg );
				graph.bitmapData.setPixel( graph.width - 1, graph.height - fs_graph, theme.fs);
				graph.bitmapData.setPixel( graph.width - 1, graph.height - ( ( timer - ms ) >> 1 ), theme.ms );
				graph.bitmapData.setPixel( graph.width - 1, graph.height - mem_graph, theme.mem);
				graph.bitmapData.setPixel( graph.width - 1, graph.height - mem_max_graph, theme.memmax);
				
				xml.fs = "FS: " + fs + " / " + stage.frameRate;
				xml.mem = "MEM: " + mem;
				xml.memMax = "MAX: " + mem_max;
				
				fs = 0;
			}

			fs++;
			
			xml.ms = "MS: " + (timer - ms);
			ms = timer;
			
			text.htmlText = xml;
		}
		
		private function onClick(e : MouseEvent) : void
		{
			mouseY / height > .5 ? stage.frameRate-- : stage.frameRate++;
			xml.fs = "FS: " + fs + " / " + stage.frameRate;
			text.htmlText = xml;
		}
		
		// .. Utils
		
		private function hex2css( color : int ) : String
		{
			return "#" + color.toString(16);
		}
	}
}