package admin 
{
	import caurina.transitions.Tweener;
	
	import flash.display.*;
	import flash.events.*;
	import flash.net.*;
	import flash.text.*;
	
	import screen.CloseButton;
	
	public class UserLogin extends MovieClip
	{
		public var main:Main
		private var tracker:Tracker = new Tracker()
		public var language:Language = new Language()
		public var hexacolor:Colors = new Colors()
		
		private var content:MovieClip = new MovieClip();
		public var Close:CloseButton = new CloseButton();
		private var LoginTitle:TextField = new TextField()
		private var Login:TextField = new TextField();
		private var PassTitle:TextField = new TextField();
		private var Pass:TextField = new TextField();
		private var Submit:MovieClip = new MovieClip();
		private var SubmitText:TextField = new TextField();
		private var UserAdminText:TextField = new TextField()
		private var ErrorText:TextField = new TextField();
		private var FormatText:TextFormat = new TextFormat()
		private var Borda:Number = 5
		private var SpaceTitle:Number = 20
		
		private var xml:XML;
		private var loader:Loader;
		private var xmlLoader:URLLoader;
		
		public function UserLogin()
		{
			init()
			this.alpha = 0.0
			
		}
		public function init():void
		{
			//
			createTextFormat();
			createContent();
			createLogin();
			createPass()
			createSubmit();
			createLogError();
			createUserAdmin();
			createClose()
			goPass();
			Position();			
		}
		// INTERFACE
		private function createTextFormat():void
		{
			FormatText.color = 0xffffff
			FormatText.size = 12
			FormatText.font = "Arial"
			FormatText.align = "left"
			FormatText.leading = 0.5
		}
		private function FormatTitle(tf:TextField):void
		{
			tf.embedFonts = true
			tf.selectable = false
			tf.mouseEnabled = false
			tf.autoSize = TextFieldAutoSize.LEFT
			tf.antiAliasType = AntiAliasType.ADVANCED
			tf.blendMode = "layer"
			tf.defaultTextFormat = FormatText;
			addChild(tf)
		}
		private function FormatInput(tf:TextField):void
		{
			tf.embedFonts = true
			tf.blendMode = "layer"
			tf.background = true
			tf.backgroundColor = 0x000000
			tf.border = true
			tf.borderColor = 0xffffff
			tf.type = TextFieldType.INPUT;
			tf.antiAliasType = AntiAliasType.ADVANCED
			//Pass.autoSize = TextFieldAutoSize.LEFT;
			//tf.displayAsPassword = true
			tf.defaultTextFormat = FormatText;
			addChild(tf)
		}
		private function createContent():void
		{
			content.graphics.beginFill(0x00000, 0.85);
            content.graphics.lineStyle(1, 0xcc0000);
            content.graphics.drawRoundRect(0, 0, 250, 300, 15, 15);
            content.graphics.endFill(); 
            addChild(content);
		}
		private function createLogin():void
		{
			FormatTitle(LoginTitle)
			LoginTitle.text = language.AdminLogin
			FormatInput(Login)
		}
		private function createPass():void
		{
			FormatTitle(PassTitle)
			PassTitle.text = language.AdminPass
			Pass.displayAsPassword = true
			FormatInput(Pass)
		}
		private function createSubmit():void
		{
			SubmitText.selectable = false
			SubmitText.mouseEnabled = false
			SubmitText.blendMode = "layer"
			SubmitText.autoSize = TextFieldAutoSize.RIGHT;
			SubmitText.defaultTextFormat = FormatText;
			SubmitText.text = language.AdminSubmit
			
			Submit.graphics.beginFill(hexacolor.ButtonSubmit, 1);
            Submit.graphics.lineStyle(1, 0xcc0000);
            Submit.graphics.drawRect(0, 0, SubmitText.width+Borda, SubmitText.height+Borda);
            Submit.graphics.endFill(); 
			
			addChild(Submit);
			addChild(SubmitText)
			
			Submit.addEventListener(MouseEvent.MOUSE_DOWN, Send);
			Submit.addEventListener(MouseEvent.MOUSE_OVER, Over);
			Submit.addEventListener(MouseEvent.MOUSE_OUT, Out)
		}
		private function createLogError():void
		{
			ErrorText.selectable = false
			ErrorText.mouseEnabled = false
			ErrorText.width = 200
			ErrorText.wordWrap = true
			ErrorText.multiline = true
			ErrorText.autoSize = TextFieldAutoSize.LEFT
			ErrorText.blendMode = "layer"
			ErrorText.defaultTextFormat = FormatText;
			addChild(ErrorText)
			ErrorText.text = language.AdminReportWelcome
		}
		private function createUserAdmin():void {

			UserAdminText.selectable = false
			UserAdminText.mouseEnabled = true
			UserAdminText.blendMode = "layer"
			UserAdminText.autoSize = TextFieldAutoSize.RIGHT;
			UserAdminText.defaultTextFormat = FormatText;
			UserAdminText.text = language.UserAdmin
			

		
			addChild(UserAdminText)
			
			UserAdminText.addEventListener(MouseEvent.MOUSE_DOWN, Open);
			UserAdminText.addEventListener(MouseEvent.MOUSE_OVER, Over);
			UserAdminText.addEventListener(MouseEvent.MOUSE_OUT, Out)
		}
		
		private function createClose():void
		{
            addChild(Close);
			Close.addEventListener(MouseEvent.MOUSE_DOWN, Hide);
		}
		private function Hide(event:MouseEvent):void
		{
			main.manager_admin.CloseAdmin();
		}
		private function Position():void
		{
			LoginTitle.x = content.width/2 - Login.width
			LoginTitle.y = 20 + SpaceTitle
			
			Login.x = content.width/2 - Login.width
			Login.y = 40 + SpaceTitle
			Login.width = 200
			Login.height = 20
			
			PassTitle.x = content.width/2 - Pass.width
			PassTitle.y = 60 + SpaceTitle
			
			Pass.x = content.width/2 - Pass.width
			Pass.y = 80 + SpaceTitle
			Pass.width = 200
			Pass.height = 20
			
			SubmitText.x = Pass.x + Pass.width - SubmitText.width - Borda
			SubmitText.y = 110 + SpaceTitle
			Submit.x = SubmitText.x + SubmitText.width/2 - Submit.width/2
			Submit.y = SubmitText.y + SubmitText.height/2 - Submit.height/2
			
			Close.x = content.width - 12 
			Close.y = 12
			
			ErrorText.x = content.width/2 - ErrorText.width/2
			ErrorText.y = 140 + SpaceTitle
				
			UserAdminText.x = content.width/2 - UserAdminText.width/2
			UserAdminText.y = ErrorText.y + ErrorText.height + 60
			
		}
		private function Over(event:MouseEvent):void
		{
			buttonMode = true;
		}
		private function Out(event:MouseEvent):void
		{
			buttonMode = false;
		}
		
		public function FadeIN():void
		{
			Tweener.addTween(this, {alpha:1.0,
									time:0.6,
									transition:"linear"
								    })
		}
		public function FadeOUT():void
		{
			Tweener.addTween(this, {alpha:0.0,
									time:0.6,
									transition:"linear",
									onComplete: function():void{ Destroy() }
								    })
		}
		private function Destroy():void
		{
			Login.text = ""
			Pass.text = ""
			ErrorText.text = ""
			main.stage.removeChild(this)
			main.manager_admin.HideUserLogin()
		}
		
		
		
		// BACK END
		private function goPass():void
		{
			loader = new Loader();
			addChild(loader);
			xmlLoader = new URLLoader(new URLRequest("login.php"));
			xmlLoader.addEventListener(Event.COMPLETE, parseXML);
		}
		protected function parseXML(event:Event):void 
		{
			xml = new XML(event.currentTarget.data);
		}
		
		
		private function Send(event:MouseEvent):void
		{
			if (Login.text == xml.username && Pass.text == xml.password)
			{
				ErrorText.text = language.AdminReportOK
				OpenUserPublish()
			} else {
				ErrorText.text = language.AdminReportError
			}
			tracker.track("login")
		}
		private function OpenUserPublish():void
		{
			main.manager_admin.OpenUserPublish()
			tracker.track("login_ok")
		}
		private function Open(event:MouseEvent):void
		{
			var url:String= "user_login.php"
			var targetURL:URLRequest = new URLRequest(url);
			navigateToURL(targetURL, "_self");	
		}
		
	}
}