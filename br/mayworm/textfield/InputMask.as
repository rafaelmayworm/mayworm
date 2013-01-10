/****************************************************

@Usage:
import br.mayworm.textfield.InputMask;
var inputMask:InputMask = new InputMask(box.telefone.txt, "(99) 9999-9999");

'phone'     : { mask : '(99) 9999-9999' }, //Telefone
'phone-us'  : { mask : '(999) 9999-9999' }, //Telefone dos USA
'cpf'       : { mask : '999.999.999-99' }, //CPF
'cnpj'      : { mask : '99.999.999/9999-99' }, //CNPJ
'date'      : { mask : '39/19/9999' }, //Data
'date-us'   : { mask : '19/39/9999' }, //Data dos USA
'cep'       : { mask : '99999-999' }, //CEP
'time'      : { mask : '29:69' }, //Hora
'cc'        : { mask : '9999 9999 9999 9999' }, //Cartão de Crédito
'integer'   : { mask : '999.999.999.999', type : 'reverse' }, //Número inteiro
'decimal'   : { mask : '99,999.999.999.999', type : 'reverse', defaultValue: '000' }, //Decimal
'decimal-us'    : { mask : '99.999,999,999,999', type : 'reverse', defaultValue: '000' }, //Decimal dos USA
'signed-decimal'    : { mask : '99,999.999.999.999', type : 'reverse', defaultValue : '+000' }, //Decimal Positivo
'signed-decimal-us' : { mask : '99,999.999.999.999', type : 'reverse', defaultValue : '+000' } //Decimal dos USA

*****************************************************/

package br.mayworm.textfield {

	import flash.events.TextEvent;
	import flash.text.TextField;

	public class InputMask {

		private var obj:TextField;
		private var msk:String;
		private var charMap:Object = { num:"[0-9]", char:"[A-Za-z]", all:"[A-Za-z0-9]" };

		public function InputMask(_obj:TextField,_mask:String="") {
			this.obj=_obj;
			this.obj.addEventListener(TextEvent.TEXT_INPUT,this.tecla);
			this.msk=_mask;
		}
		
		private function setCaretPosition(pos:int):void {
			this.obj.setSelection(pos,pos);
		}
		
		private function tecla(ev:TextEvent):void {
			
			var key:uint = ev.text.charCodeAt(0);			
			var char:String=ev.text;
			var texto:Array=new Array(this.msk.length);
			var pos:int=this.obj.selectionBeginIndex;
			var igual:Object=null;
			var reChar:RegExp;

			for (var i:int=0; i < texto.length; i++) {
				if (this.obj.text.length < i) {
					texto[i]="";
				} else {
					texto[i]=this.obj.text.charAt(i);
				}
			}
			
			if (key >= 48 && key <= 122) {
				while (pos < this.msk.length) {

					// verifica se o caracter na posicao do cursor é um elemento da máscara
					if (this.msk.charAt(pos) != "9" && this.msk.charAt(pos) != "a" && this.msk.charAt(pos) != "*") {
						// se for um elemento da msk, adiciona no texto e passa para a próxima posição
						texto[pos]=this.msk.charAt(pos);
						pos++;
						continue;
					} else {
						// se não for um caracter da msk, verifica se é permitido
						switch (this.msk.charAt(pos)) {
							case "9" :
								reChar=new RegExp(charMap.num);
								break;
							case "a" :
								reChar=new RegExp(charMap.char);
								break;
							case "*" :
								reChar=new RegExp(charMap.all);
								break;
							default :
								break;
						}
						igual=reChar.exec(char);

						if (igual) {
							texto[pos]=char;
							pos++;
						}
						break;
					}
				}
				// devolve o texto para o input
				this.obj.text=texto.join("");

				// seta a nova posição do cursor
				setCaretPosition(pos);
				ev.preventDefault();
			} else {
				ev.preventDefault();
			}
			
		}
	}
}