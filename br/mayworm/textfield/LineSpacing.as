package br.mayworm.textfield {
	
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	public function LineSpacing(tf:TextField, space:Number = 0):void {
		var fmt:TextFormat = tf.getTextFormat();
		fmt.leading = space;
		tf.setTextFormat(fmt);
	}
	
}