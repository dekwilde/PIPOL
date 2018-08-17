package screen
{
	import flash.display.*

	public class FloorMaterial extends MovieClip
	{
		public var  Image:MovieClip = new MovieClip();
		
		private var size:uint         = 400;
        private var bgColor:uint      = 0xcccccc;
        private var borderSize:uint   = 0;
        private var cornerRadius:uint = 9;
        private var gutter:uint       = 5;
		
		public function FloorMaterial()
		{
			var bg:Shape = new Shape();
            bg.graphics.beginFill(bgColor,0);
            bg.graphics.drawRect(0, 0, 320, 240);
            bg.graphics.endFill();
            addChild(bg);
		}
		
	}
}