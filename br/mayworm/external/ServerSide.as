package br.mayworm.external {
	
	import flash.net.NetConnection;
	import flash.net.ObjectEncoding;
	import flash.net.Responder;

	public class ServerSide {
		
		public static var connection:NetConnection;		
		
		public static function setConnection( command :String, ...arguments ) :void {
			
			connection = new NetConnection();
			connection.objectEncoding = ObjectEncoding.AMF3//ObjectEncoding.AMF0;
			connection.connect( command, arguments );
			
		}
		
		
		public static function call( command:String, result:Function, status:Function = null, params:Object = null, ...args ) :void
		{
			
			if (connection) {				
				
				var responder :Responder = new Responder( result, status );
				
				try
				{
					
					if(params != null) {
						
						trace("tem params");						
						connection.call( command, responder, params );
						
					} else {
						
						trace("não tem params",command, responder, args);
						connection.call(command, responder, args);
						
					}
					
				}catch ( e :Error ) {
					trace( "'call' ERRO AO CONSULTAR O REMOTING" );
				}
				
			}else trace( "'call' A CONEXÃO NÃO FOI DEFINIDA" );
			
		}
		
		
	}
	
}
