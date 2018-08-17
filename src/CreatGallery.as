package  
{
	
	/**
	 * ...
	 * @author  DekWilde
	 */
	import flash.display.*;
	import flash.events.*;
	import flash.net.*;
	 
	public class CreatGallery 
	{
		public var main:Main
		
		public var xml:XML;
		public var loader:Loader;
		public var xmlLoader:URLLoader;
		
		public function CreatGallery() 
		{

			super();
		}
		public function init():void {
			loader = new Loader();
			main.addChild(loader);
			xmlLoader = new URLLoader(new URLRequest("reader.php"));
			xmlLoader.addEventListener(Event.COMPLETE, parseXML);
		}
		
		protected function parseXML(event:Event):void 
		{
			xmlLoader.removeEventListener(Event.COMPLETE, parseXML);
			xml = new XML(event.currentTarget.data);
			main.managerbox.Init();
		}
		public function Reset():void
		{
			//main.removeChild(loader);
			//loader.unload();
			//loader.close();
			main.managerbox.Destroy();
			init();
		}
		
	}
	
}