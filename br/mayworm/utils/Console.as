package br.mayworm.utils {
	
	import flash.display.Sprite;	
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import flash.ui.Keyboard;
	
	import br.mayworm.events.ConsoleEvent;	
	
	public class Console extends Sprite{
		
		private static var _output_tf:TextField;
		private var _input_tf:TextField;
		private var _bg:Sprite;
		private var _titlebar:Sprite;
		private var _isMinimized:Boolean;
		
		private var INPUT_H:Number = 16;
		private var PADDING:Number = 5;
		private var TITLE_BAR_H:Number = 8;
		
		public function Console($w:Number, $h:Number){
			
			_titlebar = new Sprite();
			_titlebar.graphics.beginFill(0x000000, .8);
			_titlebar.graphics.drawRect(0,0,$w,TITLE_BAR_H);
			_titlebar.doubleClickEnabled = true;
			
			_bg = new Sprite();
			_bg.graphics.beginFill(0x000000, .7);
			_bg.graphics.drawRect(0,TITLE_BAR_H + 1,$w,$h-TITLE_BAR_H);
			
			var tFormat = new TextFormat("Verdana", 10, 0xffffff);			
			
			_output_tf = new TextField();
			_output_tf.width = $w - (PADDING * 2);
			_output_tf.height = $h - (INPUT_H - 2) - (PADDING * 2) - TITLE_BAR_H;
			_output_tf.x = PADDING;
			_output_tf.y = PADDING + TITLE_BAR_H;
			_output_tf.defaultTextFormat = tFormat;
			_output_tf.multiline = true;
			_output_tf.wordWrap = true;
			
			_input_tf = new TextField();
			_input_tf.width = $w - (PADDING * 2);
			_input_tf.height = INPUT_H;
			_input_tf.y = $h - INPUT_H - PADDING;
			_input_tf.x = PADDING;
			_input_tf.type = TextFieldType.INPUT;
			_input_tf.defaultTextFormat = tFormat;
			_input_tf.background = true;
			_input_tf.backgroundColor = 0x333333;
			
			addChild(_titlebar);
			addChild(_bg);
			addChild(_output_tf);
			addChild(_input_tf);
			
			_isMinimized = false;
			
			addEventListener(Event.ADDED_TO_STAGE, _onAddedToStage);
			addEventListener(ConsoleEvent.COMMAND, _onCommand);
			
		}
		
		public static function output($str:String):void{			
			if (_output_tf != null) {				
				_output_tf.appendText("\n" + $str);				
				_output_tf.scrollV = _output_tf.maxScrollV;				
			}else{				
				trace($str);
			}
		}		
		
		
		public function minimize():void{
			_isMinimized = false;
			_toggleMinimize();
		}
		
		private function _onAddedToStage($evt:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, _onAddedToStage);	
			_bg.addEventListener(MouseEvent.MOUSE_DOWN, _onPress);
			_titlebar.addEventListener(MouseEvent.MOUSE_DOWN, _onPress);
			_titlebar.addEventListener(MouseEvent.DOUBLE_CLICK, _toggleMinimize);
			stage.addEventListener(MouseEvent.MOUSE_UP, _onRelease);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, _onKeyDown);
		}
		
		private function _onPress($evt:MouseEvent):void { startDrag(); }		
		private function _onRelease($event:MouseEvent):void { stopDrag(); }		
		private function _onCommand(e:ConsoleEvent):void { if(e.cmd == "clear") _output_tf.text = ""; }
		
		private function _onKeyDown($evt:KeyboardEvent):void{
			if($evt.keyCode == Keyboard.ENTER && _input_tf.text != "" && stage.focus == _input_tf){
				output("> " + _input_tf.text);
				dispatchEvent(new ConsoleEvent(ConsoleEvent.COMMAND, _input_tf.text));
				_input_tf.text = "";			
			}
		}
		
		private function _toggleMinimize($evt:MouseEvent = null):void{
			_bg.visible = _isMinimized;
			_input_tf.visible = _isMinimized;
			_output_tf.visible = _isMinimized;
			_isMinimized = !_isMinimized;
		}
		
	}
}