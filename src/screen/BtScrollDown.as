package screen 
{
	import flash.display.*;
	import flash.events.*;
	import flash.text.*;
	
	public class BtScrollDown extends MovieClip
	{
		
		private var sizeWidth:uint    = 22
        private var sizeHeigth:uint   = 22
		private var bgColor:uint      = 0x000000;
        private var borderColor:uint  = 0x000000;
        private var borderSize:uint   = 1;
        private var cornerRadius:uint = 8;
		
		private var X:MovieClip = new MovieClip();
		
		//private var rect1:Shape = new Shape();
		//private var rect2:Shape = new Shape();
		
		//private var radius:Number = 10
		//private var rounde:Number = 2
		
		private var Sign:TextField
		private var FormatSign:TextFormat
		
		public function BtScrollDown() 
		{			
			createTextFormat()
			createText();
			createBg()
			
			//this.graphics.beginFill(bgColor, 1);
           // this.graphics.lineStyle(borderSize, borderColor,1);
           // this.graphics.drawRoundRect(0, 0, sizeWidth, sizeHeigth, cornerRadius);
           // this.graphics.endFill();			
			/*
			
			addChild(X);
			//X.rotation = 45
			//X.y = this.y - 2
			//
			rect2.graphics.beginFill(0xff0000)
			rect1.graphics.drawRoundRect(0, 0, radius*2-rounde*2, rounde*2, rounde, rounde)
            rect1.graphics.endFill(); 
            X.addChild(rect1);

			rect2.graphics.beginFill(0xff0000)
			rect2.graphics.drawRoundRect(0, 0, rounde*2, radius*2-rounde*2, rounde, rounde)
            rect2.graphics.endFill()
			X.addChild(rect2);
			*/	
		}
		private function createTextFormat():void 
		{
			FormatSign = new TextFormat()
			FormatSign.color = 0xffffff
			FormatSign.size = 16
			FormatSign.leftMargin = 0.8
			FormatSign.rightMargin = 0.8
			FormatSign.align = "center"
			FormatSign.font = "Arial"
		}

		private function createText():void
		{
			Sign = new TextField()
			Sign.antiAliasType = AntiAliasType.ADVANCED
			Sign.defaultTextFormat = FormatSign;
			Sign.text = "»";
			Sign.blendMode = "layer"
			Sign.embedFonts = true
			Sign.selectable = false
			Sign.background = true
			Sign.backgroundColor = 0xc6c6c6c6
			//Sign.border = true
			//Sign.borderColor = 0xcc0000
			//Sign.autoSize = TextFieldAutoSize.LEFT;
			Sign.width = sizeWidth
			Sign.height = sizeHeigth
			
			addChild(Sign)
			//
			this.addEventListener(MouseEvent.MOUSE_OVER, Over)
			this.addEventListener(MouseEvent.MOUSE_OUT, Out)
		}
		private function createBg():void {
			var graf:MovieClip = new MovieClip()
			graf.graphics.beginFill(0xffffff, 0)
			graf.graphics.drawRect(0, 0, this.width, this.height)
			graf.graphics.endFill()
			this.addChild(graf)
		}
		
		private function Over(e:MouseEvent):void 
		{
			buttonMode = true;	
		}
		private function Out(e:MouseEvent):void 
		{
			buttonMode = false;	
		}
		
	}
	
}