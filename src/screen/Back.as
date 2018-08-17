package screen
{
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*

	public class Back extends MovieClip
	{
		public var main:Main
		private var size:uint         = 80;
        private var bgColor:int      = 0xcccccc
        private var borderColor:uint  = 0x666666;
        private var colors:Array = [0xffffff,0xcccccc];
        private var alphas:Array = [1, 1];
        private var ratios:Array = [0, 255];
        private var matr:Matrix = new Matrix();
        private var spreadMethod:String = SpreadMethod.PAD;
        private var bg:MovieClip = new MovieClip()
        
		public function Back()
		{
            //bg.graphics.beginFill(bgColor);
            matr.createGradientBox(size, size, 0, 0, 0);
            bg.graphics.beginGradientFill (GradientType.RADIAL, colors, alphas, ratios, matr,spreadMethod,InterpolationMethod.LINEAR_RGB) 

            bg.graphics.drawRect(0, 0, size, size);
            bg.graphics.endFill();
            addChild(bg);
			//Enable();
		}
		private function CameraBack(event:MouseEvent):void
		{
			main.manager_scene.CameraBack();
			Disable();
		}
		private function showback(event:MouseEvent):void
		{
			main.navegador.Back()
		}
		public function showBack():void
		{
			Enable();
            main.navegador.FadeOUT()
		}
		public function Disable():void
		{
			bg.removeEventListener(MouseEvent.MOUSE_DOWN,CameraBack);
            bg.removeEventListener(MouseEvent.MOUSE_OVER, showback);
		}
		public function Enable():void
		{
			bg.addEventListener(MouseEvent.MOUSE_DOWN,CameraBack);
            bg.addEventListener(MouseEvent.MOUSE_OVER, showback);
		}	
	}
}