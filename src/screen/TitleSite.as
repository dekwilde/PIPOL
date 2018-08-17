package screen
{
	import flash.display.MovieClip;
	import flash.filters.GlowFilter;
	import flash.text.*;
	import flash.events.*;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	
	public class TitleSite extends MovieClip
	{
		private var language:Language = new Language()
		private var Title:TextField;
		private var glow:GlowFilter = new GlowFilter(0xffffff, 1, 7, 7, 0.8, 1)
		public function TitleSite()
		{
			Title = new TextField();
			Title.embedFonts = true
			Title.selectable = true
			Title.mouseEnabled = true
			Title.autoSize = TextFieldAutoSize.CENTER;
			Title.antiAliasType = AntiAliasType.ADVANCED
			Title.blendMode = "layer"
			Title.filters = [glow]
			//TituloProjeto.width = 300
			//TituloProjeto.height = 50
			var Textformat:TextFormat = new TextFormat()
			Textformat.color = 0xffffff
			Textformat.size = 24
			Textformat.font = "Arial"
			Textformat.align = TextFormatAlign.CENTER
			//Textformat.leading = 10
			Title.defaultTextFormat = Textformat;
			addChild(Title)
			Title.text = language.titleSite
			var content:MovieClip = new MovieClip();
			content.graphics.beginFill(0xff0000, 0)
			content.graphics.drawRect(-15, 0, this.width, this.height)
			content.graphics.endFill()
			addChild(content);
			content.addEventListener(MouseEvent.MOUSE_OVER,GoLinkOver);
			content.addEventListener(MouseEvent.MOUSE_OUT,GoLinkOut);
			content.addEventListener(MouseEvent.MOUSE_DOWN,GoLinkPress);
		}
		private function GoLinkPress(e:MouseEvent):void
		{
			buttonMode = true
			var url:String= "http://www.faac.unesp.br/pesquisa/pipol"
			var targetURL:URLRequest = new URLRequest(url);
    		navigateToURL(targetURL, "_blank");
    		//
		}
		private function GoLinkOver(e:MouseEvent):void
		{
			buttonMode = true
		}
		private function GoLinkOut(e:MouseEvent):void
		{
			buttonMode = false
		}
		
	}
}