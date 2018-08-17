package screen
{
	import flash.display.*

	public class BoxMaterial extends MovieClip
	{
		public var  Image:MovieClip = new MovieClip();
		
		private var size:uint         = 120;
        private var bgColor:uint      = 0xcc0000;
        private var borderColor:uint  = 0x666666;
        private var borderSize:uint   = 0;
        private var cornerRadius:uint = 9;
        private var gutter:uint       = 5;
		
		public function BoxMaterial()
		{
			var bg:Shape = new Shape();
            bg.graphics.beginFill(bgColor);
            bg.graphics.lineStyle(borderSize, borderColor);
            bg.graphics.drawRect(0, 0, size, size);
            bg.graphics.endFill();
            addChild(bg);
		}
		
	}
}