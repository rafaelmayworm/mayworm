package br.mayworm.textfield {
	
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.text.TextField;
	
	public function TextLabel(field:TextField, label:String):void {
		
		function setLabel(e:FocusEvent):void {
			if (e.type == "focusIn" && field.text == label) {
				field.text = "";				
			}else if (e.type == "focusOut" && field.text == "") {				
				field.text = label;
			}
		}		
		
		function remove(e:Event):void {			
			field.removeEventListener(FocusEvent.FOCUS_IN, setLabel);			
			field.removeEventListener(FocusEvent.FOCUS_OUT, setLabel);			
			field.removeEventListener(Event.REMOVED_FROM_STAGE, remove);
		}		
		
		field.addEventListener(FocusEvent.FOCUS_IN, setLabel);
		field.addEventListener(FocusEvent.FOCUS_OUT, setLabel);
		field.addEventListener(Event.REMOVED_FROM_STAGE, remove);
		field.text = label;
		
	}
	
}