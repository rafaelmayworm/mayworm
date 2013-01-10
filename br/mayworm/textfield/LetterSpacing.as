package br.mayworm.textfield {
	
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	public function LetterSpacing(tf:TextField, spacing:Number = 0):void {
		var fmt:TextFormat = tf.getTextFormat();
		fmt.letterSpacing = spacing;
		tf.setTextFormat(fmt);
	}
	
}