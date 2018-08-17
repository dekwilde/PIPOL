package screen
{
	import caurina.transitions.Tweener;
	
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.text.*;
	public class LinkBack extends MovieClip
	{
		
		public var main:Main
        private var language:Language = new Language()
        private var bgColor:uint      = 0x000000;
        private var borderColor:uint  = 0x666666;
        private var bg:MovieClip = new MovieClip()
        
        private var textToContinue:TextField = new TextField()
            
		public function LinkBack()
		{
			bg.graphics.beginFill(bgColor);
            bg.graphics.drawRect(0, 0, 480,240);
            bg.graphics.endFill();
            addChild(bg);
            bg.alpha = 0
            bg.blendMode = "multiply"
            //
			textToContinue.autoSize = TextFieldAutoSize.CENTER;
			textToContinue.antiAliasType = AntiAliasType.ADVANCED
			textToContinue.embedFonts = true
			textToContinue.selectable = false
			textToContinue.wordWrap = true
			textToContinue.width = 50
			textToContinue.x = bg.width/2 - textToContinue.width/2
			textToContinue.y = bg.height/2 - textToContinue.height/2
			textToContinue.focusRect = true
			var Textformat:TextFormat = new TextFormat()
			Textformat.color = 0xffffff
			Textformat.size = 6
			Textformat.font = "Arial"
			Textformat.align = "center";
			textToContinue.defaultTextFormat = Textformat;
			//
			bg.addChild(textToContinue);
			textToContinue.text = language.linkBack
		}
		public function Enable():void {
			main.stage.removeEventListener(Event.ENTER_FRAME, main.manager_scene.updateCamera)
			bg.addEventListener(MouseEvent.MOUSE_DOWN,Disable);
            main.buttonMode = true
            main.manager_positions.setPosition();
            FadeIN();
		}
		private function Disable(event:MouseEvent):void 
		{
			main.stage.addEventListener(Event.ENTER_FRAME, main.manager_scene.updateCamera);
			FadeOUT();
		}

		////////////////////////////////////////////////////////////////////////////////
		public function FadeIN():void
		{
			Tweener.addTween(bg, {alpha: 0.8, time:0.5, transition:"linear"})	
		}
		public function FadeOUT():void
		{
			Tweener.addTween(bg, {alpha: 0, time:0.7, transition:"linear", onComplete: function():void{ Destroy() }})
		}
		private function Destroy():void
		{
			main.stage.removeChild(this)
		}
	}
}