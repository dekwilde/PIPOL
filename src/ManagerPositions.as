package  
{
	import flash.display.*;
	import flash.events.*;
	
	public class ManagerPositions 
	{
		
		public var main:Main
		public function ManagerPositions() 
		{
			
		}
		public function init():void {
			setPosition();
			main.stage.addEventListener( Event.RESIZE, onresize );
		}
		
		private function onresize(event:Event):void 
		{
			setPosition();
		}
		public function setPosition():void 
		{
			main.manager_scene.container.x = main.stage.stageWidth/2;
			main.manager_scene.container.y = main.stage.stageHeight/2;
//			container.scaleX = Scala;
//			container.scaleY = Scala;
			main.titlesite.x = main.stage.stageWidth/2 - main.titlesite.width/2 + 15
			main.titlesite.y = 20
			
			main.tituloprojeto.x = main.stage.stageWidth/2 - 55
			main.tituloprojeto.y = main.stage.stageHeight-main.tituloprojeto.height-30
			
			main.ifull.visible = main.stage.hasOwnProperty("displayState");
			main.ifull.x = main.stage.stageWidth-50
			main.ifull.y = main.stage.stageHeight-40
			
			main.bg.x = -main.stage.stageWidth/2;
			main.bg.y = -main.stage.stageHeight/2;
			main.bg.width = main.stage.stageWidth
			main.bg.height = main.stage.stageHeight
			
			//linkback.x = stage.stageWidth
			//linkback.y = stage.stageHeight
			main.linkback.width = main.stage.stageWidth
			main.linkback.height = main.stage.stageHeight
			
			main.manager_admin.userlogin.x = main.stage.stageWidth/2 - main.manager_admin.userlogin.width/2
			main.manager_admin.userlogin.y = main.stage.stageHeight/2 - main.manager_admin.userlogin.height/2
			
			main.manager_admin.userpublish.x = main.stage.stageWidth/2 - main.manager_admin.userpublish.width/2
			main.manager_admin.userpublish.y = main.stage.stageHeight/2 - main.manager_admin.userpublish.height/2
			
			main.manager_admin.usersucess.x = main.stage.stageWidth/2 - main.manager_admin.usersucess.width/2
			main.manager_admin.usersucess.y = main.stage.stageHeight/2 -main.manager_admin.usersucess.height/2
			
			main.manager_contact.contato.x = main.stage.stageWidth/2 - main.manager_contact.contato.width/2
			main.manager_contact.contato.y = main.stage.stageHeight/2 - main.manager_contact.contato.height/2
			
			main.manager_filter_year.filter_year.x = main.stage.stageWidth/2 - main.manager_filter_year.filter_year.width/2
			main.manager_filter_year.filter_year.y = main.stage.stageHeight/2 - main.manager_filter_year.filter_year.height/2
			
			main.descricao.x = main.stage.stageWidth/2 - main.descricao.width/2
			main.descricao.y =main.stage.stageHeight/2 - main.descricao.height/2
			
			
			main.publish_bt.x = 20
			main.publish_bt.y = main.stage.stageHeight - 30
			
			main.bt_contact.x = main.publish_bt.width + 30
			main.bt_contact.y = main.stage.stageHeight - 30
			
			main.bt_filter_year.x = main.stage.stageWidth - 380
			main.bt_filter_year.y = main.stage.stageHeight - 33
			
			main.composition.x = main.stage.stageWidth - 100
			main.composition.y = main.stage.stageHeight - 27
			//linkback.textToContinue.x = container.x
			//linkback.textToContinue.y = container.y
			//
//			var sW:Number = stage.stageWidth
//			var sH:Number = stage.stageHeight
//
//			var rtc:RectangleTriangleCuller = new RectangleTriangleCuller();
//			rtc.cullingRectangle = new Rectangle( -sW/2, -sH/2, sW, sH );
//			scene.triangleCuller = rtc;
		}
		
	}
	
}