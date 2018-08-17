package screen
{
	import caurina.transitions.Tweener;
	
	import flash.display.MovieClip;
	import flash.filters.DropShadowFilter;
	import flash.text.*;

	public class TitleProject extends MovieClip
	{
		private var shadow:DropShadowFilter = new DropShadowFilter(2, 45, 0x000000, 0.6, 5, 5, 0.8, 1)
		private var TituloProjeto:TextField;
		public var main:Main;
		public function TitleProject()
		{
			TituloProjeto = new TextField();
			TituloProjeto.embedFonts = true
			TituloProjeto.selectable = false
			//TituloProjeto.background = true
			//TituloProjeto.backgroundColor = 0xf6f6f6
			//TituloProjeto.border = true
			//TituloProjeto.borderColor = 0xcccccc
			TituloProjeto.autoSize = TextFieldAutoSize.CENTER
			TituloProjeto.antiAliasType = AntiAliasType.ADVANCED
			TituloProjeto.blendMode = "layer"
			TituloProjeto.alpha = 0
			TituloProjeto.filters = [shadow]
			//TituloProjeto.width = 300
			//TituloProjeto.height = 50
			var Textformat:TextFormat = new TextFormat()
			Textformat.color = 0xffffff
			Textformat.size = 28
			Textformat.font = "Arial"
			Textformat.align = TextFormatAlign.CENTER
			Textformat.letterSpacing = -2
			Textformat.leftMargin = 3
			Textformat.rightMargin = 3
			//Textformat.leading = 10
			TituloProjeto.defaultTextFormat = Textformat;
			addChild(TituloProjeto)	
		}
		public function Show(BoxNumber:Number):void {
			TituloProjeto.text = main.creatgallery.xml.projeto[BoxNumber].titulo;
			main.manager_positions.setPosition()
			FadeIN();
		}
		public function FadeIN():void
		{
			Tweener.addTween(TituloProjeto, {alpha: 1.0, time:0.6, transition:"linear"})	
		}
		public function FadeOUT():void
		{
			Tweener.addTween(TituloProjeto, {alpha: 0, time:0.5, transition:"linear"})
		}
		
	}
}