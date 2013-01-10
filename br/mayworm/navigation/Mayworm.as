
/*****************************************************	 
     ___     Developer- Rafael Mayworm               
    (¤;¤)    Page- http://www.rafaelmayworm.com.br   
    -{=}-    Mail- rafaelmayworm@gmail.com           
     - -      Msn- rafaelmayworm@hotmail.com         
  ---------	                                     
*****************************************************/

package br.mayworm.navigation {		
	
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.utils.Dictionary;
	import flash.utils.setTimeout;
	
	import br.mayworm.external.SWFAddress;
	import br.mayworm.utils.MenuContexto;
	import br.mayworm.events.MaywormEvent;
	import br.mayworm.events.SWFAddressEvent;
		
	public class Mayworm {		
		
		
		public static var modules:Dictionary = new Dictionary();
		public static var menuItens:Dictionary = new Dictionary();
		
		public static var percent:int = 0;
		
		public static var moduleAtual:String;				
		public static var mcAtual:*;
		public static var mcsOld:Array = [];
		
		public static var index:*;
		
		public static var carregando:Boolean = false;
		private static var mcLoader:Loader;		
		
		public static var dispatcher:EventDispatcher = new EventDispatcher();
		
		private static var pagInicial:String;	
		public static var params:Object;		
		
		
		//Mayworm.addModule( { nome:"home",      module:Home,      	 container:this, title:"Home",       menuContexto:true } );
		public static function addModule( obj:Object ):void {							
			if ((modules[obj.nome] as Object) == null) {				
				modules[obj.nome] = obj;	
				if (obj.menuContexto && index != null) MenuContexto.addMenuItem( obj.title, obj.nome, index, false, true, true, clickContext );								
			}else {				
				trace("Esse Modulo já foi adicionado!");							
			}			
		}
		
		public static function addMenuItem( obj:Object ):void { menuItens[obj.nome] = obj; }
		
		public static function removeModule(str:String) {			
			if (modules[str].menuContexto) {
				MenuContexto.removeItem(str);
				//modules[str] = null;
				delete modules[str];
			}		
		}
		
		public static function setIndex(e:*):void { 
			index = e;
			index.stage.addEventListener(MaywormEvent.OPENMODULE, openModule);
			SWFAddress.addEventListener(SWFAddressEvent.CHANGE, SWFAddressChange);
		}
		
		public static function setPagInicial(e:String):void { pagInicial = e; }
		
		private static function SWFAddressChange(e:SWFAddressEvent):void {													
			
			var arrDiv:Array = e.value.split("/");			
			
			params = { };			
			if (arrDiv.length > 3) {								
				params.arr = [];
				for (var i:int = 2; i < arrDiv.length - 1; i++) params.arr.push(arrDiv[i]);												
			}	

			
			if (moduleAtual == arrDiv[1]) {				
				//modulo já aberto insert apenas p/ enviar params
				if (mcAtual.init as Function) {
					//if (params.arr != null) trace("Params: ", params.arr);			
					mcAtual.params = params;
					mcAtual.init();		
				}
				dispatchEvent(new MaywormEvent(MaywormEvent.OPEN));
				return;
			}
			
			if (moduleAtual != null) {				
				MenuContexto.ativeItem(moduleAtual, true);				
				if (mcAtual != null) {					
					mcAtual.addEventListener(MaywormEvent.CLOSEMODULE, addContainer);				
					mcAtual.remove();
				}				
			}			
			
			var transfer:String = moduleAtual;			
			
			
			
			
			
			//ATIVA MENU
			if (modules[moduleAtual] != null) {				
				if (menuItens[modules[moduleAtual].nome] != null) {					
					menuItens[modules[moduleAtual].nome].mc.mouseEnabled = true;
					menuItens[modules[moduleAtual].nome].mc.dispatchEvent(new MouseEvent(MouseEvent.ROLL_OUT));				
				}
			}
			
			moduleAtual = arrDiv[1];			
			
			removeLoader();
			
			
			
			if (e.value == "/") moduleAtual = pagInicial;			
			if (e.value == "/" && pagInicial == null) return;//nenhum modulo como default, não abrir nada		
			
			dispatchEvent(new MaywormEvent(MaywormEvent.OPEN));
			
			if (transfer == null || carregando) addContainer();			
			
			//DESATIVA ITEM MENU MODULE
			desativeItemMenuModule();
			
		}
		
		public static function desativeItemMenuModule():void {
			if (modules[moduleAtual] != null) {												
				if (menuItens[modules[moduleAtual].nome] != null) {					
					menuItens[modules[moduleAtual].nome].mc.mouseEnabled = false;
					setTimeout(function():void { menuItens[modules[moduleAtual].nome].mc.dispatchEvent(new MouseEvent(MouseEvent.ROLL_OVER)); }, 50);				
				}
			}
		}
		
		public static function addContainer(e:MaywormEvent = null):void {					
			
			carregando = false;
			removeLoader();		
			
			if (modules[moduleAtual] == null) {
				trace("Erro: Esse modulo não existe!");
				return;
			}
			
			if (e != null) {				
				if (e.params.mc.parent != null) {
					
					//trace("mcsOld", mcsOld);							
					//trace("removeu", e.params.mc);
					
					e.params.mc.removeEventListener(MaywormEvent.CLOSEMODULE, addContainer);					
					e.params.mc.parent.removeChild( e.params.mc );			
					e.params.mc = null;
					
					
					
					if (mcsOld.length > 1) {
						for (var i:int = 1; i < mcsOld.length; i++) {
							if (mcsOld[i] != null) {								
								mcsOld[i].closeAtivo = false;
								mcsOld[i].remove();
							}
						}
					}
					
					mcsOld = [];
					
				}				
			}					

			if (typeof(modules[moduleAtual].module) == "string") {				
				
				removeLoader();	

				carregando = true;	
				
				mcLoader = new Loader() as Loader;
				mcLoader.load(new URLRequest(modules[moduleAtual].module));					
				mcLoader.contentLoaderInfo.addEventListener( Event.COMPLETE, onCompleteSwf, false, 0, true );								
				mcLoader.contentLoaderInfo.addEventListener( ProgressEvent.PROGRESS, onProgressSwf, false, 0, true );
				mcLoader.contentLoaderInfo.addEventListener( IOErrorEvent.IO_ERROR, onErroSwf, false, 0, true );					
				
			}else{
				
				if (mcAtual != null) mcsOld.push(mcAtual);
				
				mcAtual = modules[moduleAtual].container.addChild( new modules[moduleAtual].module() );		
				insertModule();
			
			}					
			
			MenuContexto.ativeItem(moduleAtual, false);
			
		}
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
//=========================================================================== INÍCIO LOAD SWF EXTERNO
		
		public static function insertModule():void {							
			dispatchEvent(new MaywormEvent(MaywormEvent.COMPLETE));			
			if (mcAtual.init as Function) {
				//if (params.arr != null) trace("Params: ", params.arr);			
				mcAtual.params = params;
				mcAtual.init();		
			}
		}
		
		private static function onErroSwf(e:IOErrorEvent):void { trace("Arquivo não encontrado: ", modules[moduleAtual].module); }		
		
		private static function removeLoader():void {						
			
			if (mcLoader != null) {
				
				carregando = false;				
				mcLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE, onCompleteSwf);
				mcLoader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS, onProgressSwf);
				mcLoader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, onErroSwf);					
				
				try {					
					mcLoader.close();
				} catch (error:Error) {
					
				}
				
				mcLoader = null;				
				
			}
			
			
		}
		
		private static function onProgressSwf(e:ProgressEvent):void {				
			/*if(mcLoader!=null){
				mcLoader.close();
				mcLoader = null;
			}*/
			percent = int((e.bytesLoaded / e.bytesTotal) * 100);
			dispatchEvent(new MaywormEvent(MaywormEvent.PROGRESS));
		}
		
		private static function onCompleteSwf(e:Event):void {			
			
			removeLoader();
			carregando = false;	
			
			if (mcAtual != null) mcsOld.push(mcAtual);
			
			mcAtual = e.target.content;			
			modules[moduleAtual].container.addChild(mcAtual);			
			insertModule();		
			
			
			
			//// *******************  DEIXA SWF EXTERNO NA MEMÓRIA - DEPOIS DE CARREGADO PELA PRIMEIRA VEZ ////		
			if (modules[moduleAtual].includeMemory != null) {				
				var newClass:Class = e.target.applicationDomain.getDefinition(getQualifiedClassName(e.target.content)) as Class;				
				if(modules[moduleAtual].includeMemory) modules[moduleAtual].module = newClass;				
			}
            
			
			
		}
		
		import flash.utils.getDefinitionByName;
		import flash.utils.getQualifiedClassName;
		
//=========================================================================== FIM LOAD SWF EXTERNO		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		

		public static function openModule(e:MaywormEvent):void {																		
			params = e.params.params;			
			if (index != null) {
				(e.params.module == pagInicial) ? SWFAddress.setValue("/") : SWFAddress.setValue("/" + e.params.module + "/");				
			}			
		}
		
		public static function clickContext(e:Object = null):void {	index.stage.dispatchEvent( new MaywormEvent( MaywormEvent.OPENMODULE, { module:MenuContexto.dadosContexto(e.target).nameContexto } ) );	}
		
		public static function dispatchEvent(e:Event):Boolean { return dispatcher.dispatchEvent(e); }
		
	}		
	
}