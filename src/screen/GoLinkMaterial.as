package screen
{
	import flash.display.*;
	import flash.events.*;
	import flash.text.*;
	public class GoLinkMaterial extends MovieClip
	{
		
		private var FormatTxt:TextFormat
		private var TxtLink:TextField
		private var language:Language = new Language()
		public function GoLinkMaterial()
		{
            FormatTxt = new TextFormat()
			FormatTxt.color = 0x000000
			FormatTxt.size = 14
			FormatTxt.font = "Arial"
			FormatTxt.leading = 3
			FormatTxt.leftMargin = 3
			FormatTxt.rightMargin = 3
			FormatTxt.align = TextFormatAlign.LEFT
            //
            TxtLink = new TextField();
			TxtLink.antiAliasType = AntiAliasType.ADVANCED
			TxtLink.embedFonts = true
			TxtLink.selectable = false
			TxtLink.mouseEnabled = false
			TxtLink.defaultTextFormat = FormatTxt;
			
			TxtLink.blendMode = "layer"
			TxtLink.selectable = false
			TxtLink.background = true
			TxtLink.backgroundColor = 0xf5f5f5
			//TxtLink.border = true
			//TxtLink.borderColor = 0xcfcfcf
			TxtLink.text = language.gotoLink
			
			TxtLink.autoSize = TextFieldAutoSize.LEFT;
	
			addChild(TxtLink)
			
			var graf:MovieClip = new MovieClip()
			graf.graphics.beginFill(0xffffff, 0)
			graf.graphics.drawRect(0, 0, this.width, this.height)
			graf.graphics.endFill()
			this.addChild(graf)
            
            
		}
		
	}
}