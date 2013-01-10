package br.mayworm.validation {
	
	public function IsEmail(email:String):Boolean {
		var pattern:RegExp = /^[A-Z0-9._%+-]+@(?:[A-Z0-9-]+\.)+[A-Z]{2,4}$/i;
		return email.match(pattern) != null;
	}
}