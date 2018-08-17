package admin
{
	import caurina.transitions.Tweener;
	
	import flash.display.*;
	import flash.events.*;
	import flash.net.*;
	import flash.text.*;
	
	public class UserSucess extends MovieClip {
		
		public var main:Main
		private var language:Language = new Language()
		private var Title:TextField = new TextField();
		private var FormatText:TextFormat = new TextFormat()
		private var FormatBrowser:TextFormat = new TextFormat()
		private var Browser:MovieClip = new MovieClip();
		private var content:MovieClip = new MovieClip();
		private var BrowserText:TextField = new TextField();
		private var contentWidth:Number = 400
		private var contentHeight:Number = 200
		private var Borda:Number = 5
		
		public function UserSucess()
		{	
			this.alpha = 0.0
			init()
		}
		private function init():void
		{
			createBrowserFormat();
			createTextFormat();
			createContent();
			createMessage();
			createOK();
			Position()
			
		}
		private function createBrowserFormat():void
		{
			FormatBrowser.color = 0xffffff
			FormatBrowser.size = 12
			FormatBrowser.font = "Arial"
			FormatBrowser.align = "center"
			FormatBrowser.leading = -10
		}
		private function createTextFormat():void
		{
			FormatText.color = 0xffffff
			FormatText.size = 12
			FormatText.font = "Arial"
			FormatText.align = "center"
			FormatText.leading = 0.5
		}
		private function FormatTitle(tf:TextField):void
		{
			tf.embedFonts = true
			tf.selectable = false
			tf.mouseEnabled = false
			tf.wordWrap = true
			tf.multiline = true
			tf.autoSize = TextFieldAutoSize.LEFT
			tf.antiAliasType = AntiAliasType.ADVANCED
			tf.blendMode = "layer"
			tf.width = 300
			tf.defaultTextFormat = FormatText;
			addChild(tf)
		}
		private function createContent():void
		{
			content.graphics.beginFill(0x00000, 0.8);
            content.graphics.lineStyle(1, 0xcc0000);
            content.graphics.drawRoundRect(0, 0, contentWidth, contentHeight, 15, 15);
            content.graphics.endFill(); 
            addChild(content);
		}
		private function createMessage():void
		{
			FormatTitle(Title)
			Title.text = language.UserSucess
		}
		private function createOK():void
		{
			BrowserText.selectable = false
			BrowserText.mouseEnabled = false
			BrowserText.background = true
			BrowserText.backgroundColor = 0x000000
			BrowserText.border = true
			BrowserText.borderColor = 0xcc0000
			BrowserText.blendMode = "layer"
			//BrowserText.autoSize = TextFieldAutoSize.CENTER;
			BrowserText.defaultTextFormat = FormatBrowser;

			BrowserText.text = language.UserClose
			
			BrowserText.width = BrowserText.textWidth+8 
			BrowserText.height = BrowserText.textHeight+8
			
			addChild(BrowserText)
			
			this.addEventListener(MouseEvent.MOUSE_DOWN, Reset);
			this.addEventListener(MouseEvent.MOUSE_OVER, Over);
			this.addEventListener(MouseEvent.MOUSE_OUT, Out)
		}
		private function Position():void
		{
			Title.x = contentWidth/2 - Title.width/2 
			Title.y = contentHeight/2 - Title.height/2
				
			BrowserText.x = contentWidth/2 - BrowserText.width/2
			BrowserText.y = contentHeight/2 - BrowserText.height/2 + Title.height + 20
		}
		
		private function Hide(event:MouseEvent):void
		{
			main.managerbox.BoxesEnable()
			main.publish_bt.Enable()
			FadeOUT()
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
									time:0.8,
									transition:"linear"
								    })
		}
		public function FadeOUT(event:MouseEvent=null):void
		{
			Tweener.addTween(this, {alpha:0.0,
									time:0.5,
									transition:"linear",
									onComplete: function():void{ Destroy() }
								    })
		}
		private function Reset(event:MouseEvent):void
		{
			var url:String= "index.html"
			var targetURL:URLRequest = new URLRequest(url);
    		navigateToURL(targetURL, "_self");
			main.publish_bt.Enable();
			//main.Reset();
			FadeOUT();
		}
		
		private function Destroy():void
		{
			main.manager_admin.CloseUserSucess()
		}
	}
}