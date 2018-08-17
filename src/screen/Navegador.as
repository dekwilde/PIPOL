package screen
{
	import caurina.transitions.Tweener;
	
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.filters.DropShadowFilter;
	import flash.text.*;

	public class Navegador extends MovieClip
	{
		private var language:Language = new Language()
		private var navegation:TextField;
		private var subtitle:TextField
		public var main:Main;
		private var shadow:DropShadowFilter = new DropShadowFilter(2,45, 0x000000, 0.8, 5, 5, 0.7, 1)
		public function Navegador()
		{
			this.alpha = 0.0
			createNavegation();
			createSubTitle();
			addEventListener( Event.ENTER_FRAME, loop );
		}
		private function createNavegation():void
		{
			navegation = new TextField();
			navegation.autoSize = TextFieldAutoSize.RIGHT;
			navegation.antiAliasType = AntiAliasType.ADVANCED
			navegation.embedFonts = true
			navegation.selectable = false
			navegation.background = true
			
			navegation.backgroundColor = 0xfcfcfc
			//navegation.border = true
			//navegation.borderColor = 0xcccccc
			navegation.filters = [shadow]
			navegation.blendMode = "layer"
			var Textformat:TextFormat = new TextFormat()
			Textformat.color = 0x000000
			Textformat.size = 18
			Textformat.font = "Arial"
			navegation.defaultTextFormat = Textformat;	
			addChild(navegation)
		}
		private function createSubTitle():void
		{
			subtitle = new TextField();
			subtitle.embedFonts = true
			subtitle.autoSize = TextFieldAutoSize.RIGHT;
			subtitle..antiAliasType = AntiAliasType.ADVANCED
			subtitle.selectable = false
			subtitle.background = true
			subtitle.backgroundColor = 0xfcfcfc
			//subtitle.border = true
			//subtitle.borderColor = 0xcccccc
			subtitle.filters = [shadow]
			subtitle.blendMode = "layer"
			subtitle.y = -18
			var Textformat:TextFormat = new TextFormat()
			Textformat.color = 0x000000
			Textformat.size = 10
			Textformat.font = "Arial"
			subtitle.defaultTextFormat = Textformat;	
			addChild(subtitle)
		}
		public function Year(BoxNumber:Number):void
		{
			subtitle.text = language.subtitleNavegationYear
			navegation.text = main.creatgallery.xml.projeto[BoxNumber].ano;
			FadeIN();
		}
		public function PresstoOpen():void
		{
			subtitle.text = language.subtitleNavegationOpen
			navegation.text = language.navegationOpen
			FadeIN();
		}
		public function Back():void
		{
			subtitle.text = language.subtitleNavegationViewMore
			navegation.text = language.navegationBack
			FadeOUT();
		}
		public function BackToClose():void
		{
			subtitle.text = language.subtitleNavegationBack
			navegation.text = language.navegationClose
			FadeIN();
		}
		///////////////////////////////////////////////////////////////////////////////////////////
		private function loop(event:Event):void {
			this.x = this.x + (stage.mouseX - this.x - 80)/12
			this.y = this.y + (stage.mouseY - this.y - 60)/12
		}
		public function FadeIN():void
		{
			main.buttonMode = true
			Tweener.addTween(this, {alpha: 1.0, 
									scaleX:1.0,
									scaleY:1.0,
									time:0.3, 
									transition:"linear"})	
		}
		public function FadeOUT():void
		{
			main.buttonMode = false
			Tweener.addTween(this, {alpha: 0, 
									scaleX:0.0,
									scaleY:0.0,
									time:0.5, 
									transition:"linear"})
		}

	}
}