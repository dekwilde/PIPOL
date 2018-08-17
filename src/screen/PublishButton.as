package screen
{
	import flash.display.*;
	import flash.events.*;
	import flash.filters.GlowFilter;
	import flash.text.*;
	
	public class PublishButton extends MovieClip 
	{
		public var main:Main
		private var tracker:Tracker = new Tracker()
		private var language:Language = new Language()
		private var content:MovieClip = new MovieClip();
		private var TextPublish:TextField = new TextField()
		
		private var BlurGlow:Number = 1.6
		private var StrechGlow:Number = 0.8
		private var QualityGlow:Number = 100
		
		private var borderColor:uint  = 0xffffff;
		
		private var FormatText:TextFormat = new TextFormat()
		
		private var filterGlow:GlowFilter = new GlowFilter(borderColor, 1, BlurGlow, BlurGlow, StrechGlow, QualityGlow);
		
		function PublishButton()  
		{
			this.filters = [filterGlow];
			createTextFormat();
			createButton();
			
		}
		private function createButton():void
		{
			content.graphics.beginFill(0xcccccc, 0.0);
            content.graphics.drawRect(-5, -5, TextPublish.width, 14 + 10);
            content.graphics.endFill(); 
            addChild(content);
			
			FormatTitle(TextPublish)
			TextPublish.text = language.publishButton
			
			content.addEventListener(MouseEvent.MOUSE_DOWN, OpenUserLogin);
			content.addEventListener(MouseEvent.MOUSE_OVER, Over);
			content.addEventListener(MouseEvent.MOUSE_OUT, Out)
		}
		private function createTextFormat():void
		{
			FormatText.color = borderColor
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
			tf.height = 14
			tf.defaultTextFormat = FormatText;
			addChild(tf)
		}
		private function Over(event:MouseEvent):void
		{
			buttonMode = true;
		}
		private function Out(event:MouseEvent):void
		{
			buttonMode = false;
		}
		private function OpenUserLogin(event:MouseEvent):void
		{
			main.stage.addChild(main.linkback);
			main.linkback.Enable();
			Disable()
			main.manager_admin.init();
			main.manager_admin.ShowUserLogin();
			main.descricao.Dispose()
			main.managerbox.BoxesDisable()
			tracker.track("publishbutton")

			
			
			
		}
		public function Disable():void
		{
			content.removeEventListener(MouseEvent.MOUSE_DOWN, OpenUserLogin);
		}
		public function Enable():void
		{
			content.addEventListener(MouseEvent.MOUSE_DOWN, OpenUserLogin);
		}
	}
}