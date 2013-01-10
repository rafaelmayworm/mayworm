
/*****************************************************	 
     ___     Developer- Rafael Mayworm               
    (¤;¤)    Page- http://www.rafaelmayworm.com.br   
    -{=}-    Mail- rafaelmayworm@gmail.com           
     - -      Msn- rafaelmayworm@hotmail.com         
  ---------	                                     
*****************************************************/	

package br.mayworm.utils {	

	import flash.ui.ContextMenu;
	import flash.ui.ContextMenuItem;
	import flash.events.ContextMenuEvent;
	import flash.utils.Dictionary;
	
	public class MenuContexto {
		
		private static var itens:Array = new Array();	
		private static var dic:Dictionary = new Dictionary();
		private static var menu:ContextMenu;
		
		public static function addMenuItem( caption:String, nameContexto:String, container:*, separator:Boolean = false, enabled:Boolean = true, visible:Boolean = true, call:Function = null ):void {		
			
			menu = container.contextMenu;
			var nam:ContextMenuItem = new ContextMenuItem( caption, separator, enabled, visible );
			
			if (call is Function) {				
				dic[nameContexto] = { nameContextMenuItem:nam, caption:caption, nameContexto:nameContexto, container:container, separator:separator, call:call };			
				dic[nameContexto].nameContextMenuItem.addEventListener( ContextMenuEvent.MENU_ITEM_SELECT, call );								
				itens.push( dic[nameContexto] );				
			}
			
			if (!menu) menu = new ContextMenu();
			
			menu.hideBuiltInItems();
			menu.customItems.push(dic[nameContexto].nameContextMenuItem);
			
			container.contextMenu = menu;								
			
		}
		
		public static function dadosContexto(str:Object):Object {
			
			var p:Object = {};		
			
			for (var i:int = 0; i < itens.length; i++) {								
				if (str == itens[i].nameContextMenuItem) {					
					p = itens[i];
					break;
				}
			}
			
			return p;
			
		}
		
		public static function ativeItem(str:String, p:Boolean = false):void {			
			if (dic[str] != null) dic[str].nameContextMenuItem.enabled = p;			
		}
		
		public static function removeItem(str:String):void {
			if (dic[str] != null) {				
				
				dic[str].nameContextMenuItem.removeEventListener( ContextMenuEvent.MENU_ITEM_SELECT, dic[str].call );								
				
				for (var i:int = 0; i < menu.customItems.length; i++) {								
					if (dic[str].nameContextMenuItem == menu.customItems[i]) {					
						menu.customItems.splice(i, 1);				
						break;
					}
				}				
				
			}
		}
		
	}
	
}
