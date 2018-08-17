package screen
{
	import caurina.transitions.Tweener;
	import flash.filters.GlowFilter;
	
	import flash.display.MovieClip;
	import flash.display.Shape;

	public class PlacaMaterial extends MovieClip
	{
		
		public var main:Main
		private var size:uint         = 241;
        private var bgColor:uint      = 0xFFFFFF;
        private var borderColor:uint  = 0x000000;
        private var borderSize:uint   = 1;
        private var cornerRadius:uint = 15;
        private var gutter:uint       = 5;
		public var graf:Shape = new Shape()
		public var border:Shape = new Shape()
		
		public function PlacaMaterial()
		{
			graf.graphics.beginFill(bgColor);
            graf.graphics.drawRect(0, 0, size, size);
            graf.graphics.endFill();
            addChild(graf);
            graf.alpha = 0.0
            //
            border.graphics.lineStyle(borderSize, borderColor);
            border.graphics.drawRect(0, 0, size, size);
            border.graphics.endFill();
            addChild(border);
            border.alpha = 0.0
           	//border.blendMode = "add"
		}
	}
}