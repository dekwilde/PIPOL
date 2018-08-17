package screen
{
	import flash.display.MovieClip;
	import flash.text.*
	import settings.*
	import flash.filters.*

	public class GoLink extends MovieClip
	{
		private var language:Language = new Language()
		private var colors:Colors = new Colors();
		private var Fonte:Fontes = new Fontes();
		
		private var content:MovieClip = new MovieClip();
		
		private var FormatText:TextFormat = new TextFormat()
		private var Text:TextField = new TextField()
		
		public function GoLink()
		{
			createTextFormat();
			//			
			FormatTitle(Text)
			Text.text = language.goLink
			
			content.graphics.beginFill(0x00ff00, 0);
            content.graphics.drawRect(0,0,Text.textWidth, Text.textHeight)
            content.graphics.endFill(); 
            addChild(content);   
			
			
		}
		private function createTextFormat():void
		{
			FormatText.color = colors.go_link
			FormatText.size = 20
			FormatText.font = Fonte.goLink
			FormatText.align = "left"
			FormatText.leading = 0.5
		}
		private function FormatTitle(tf:TextField):void
		{
			tf.selectable = false
			tf.mouseEnabled = false
			tf.autoSize = TextFieldAutoSize.LEFT
			tf.blendMode = "layer"
			tf.height = 14
			tf.defaultTextFormat = FormatText;
			addChild(tf)
		}
		
		
		
	}
}