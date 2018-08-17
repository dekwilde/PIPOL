package  
{
	
	import admin.*;
	
	public class ManagerAdmin 
	{
		
				//ADMIN
		public var main:Main
		public var userlogin:UserLogin = new UserLogin();
		public var userpublish:UserPublish = new UserPublish();
		public var usersucess:UserSucess = new UserSucess();
		
		public function ManagerAdmin() 
		{
			super();

		}
		public function init():void 
		{
			// admin
			userlogin.main = main
			userpublish.main = main
			usersucess.main = main
		}
		// ADMIN SETUP
		public function ShowUserLogin():void
		{
			main.stage.addChild(userlogin)
			userlogin.FadeIN();
		}
		public function HideUserLogin():void
		{
			main.stage.removeChild(userlogin)
		}
		public function OpenUserPublish():void
		{
			
			userlogin.FadeOUT();
			main.stage.addChild(userpublish)
			userpublish.FadeIN()
		}
		public function CloseUserPublish():void
		{
			main.stage.removeChild(userpublish)
		}
		public function OpenUserSucess():void
		{
			userpublish.FadeOUT();
			main.stage.addChild(usersucess)
			usersucess.FadeIN()
		}
		public function CloseUserSucess():void
		{
			main.stage.removeChild(usersucess)
		}
		public function CloseAdmin():void
		{

			userpublish.FadeOUT();
			userlogin.FadeOUT();
			main.managerbox.BoxesEnable();
			main.publish_bt.Enable()
		}
		
		public function Destroy():void 
		{
			
		}
	}
	
}