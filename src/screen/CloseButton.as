package screen 
{
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.events.*
	
	import caurina.transitions.Tweener;
	
	
	/**
	 * ...
	 * @author DekWilde
	 */
	public class CloseButton extends MovieClip
	{
		private var Close:MovieClip = new MovieClip();
		private var X:MovieClip = new MovieClip();
		
		private var rect1:Shape = new Shape();
		private var rect2:Shape = new Shape();
		
		private var radius:Number = 10
		private var rounde:Number = 2
		
		public function CloseButton() 
		{
			Close.graphics.beginFill(0x880000);
            //Close.graphics.lineStyle(0.01, 0xff0000, 1, false);
            Close.graphics.drawCircle(8, 8, 8)
			Close.x = -Close.width/2
			Close.y = -Close.height/2
            Close.graphics.endFill(); 
            addChild(Close);
			Close.addEventListener(MouseEvent.MOUSE_OVER, Over);
			Close.addEventListener(MouseEvent.MOUSE_OUT, Out)
			/*
			addChild(X);
			X.rotation = 45
			X.y = Close.y - 2

			
			rect1.graphics.beginFill(0x000000)
			rect1.graphics.drawRoundRect(0, 0, radius*2-rounde*2, rounde*2, rounde, rounde)
            rect1.graphics.endFill(); 
            X.addChild(rect1);

			rect2.graphics.beginFill(0x000000)
			rect2.graphics.drawRoundRect(0, 0, rounde*2, radius*2-rounde*2, rounde, rounde)
            rect2.graphics.endFill(); 
            X.addChild(rect2);

			rect1.x = 1+Close.width/2 - rect1.width/2-rounde/2
			rect1.y = 1+Close.height/2 - rect1.height/2-rounde/2
			//
			rect2.x = 1+Close.width/2 - rect2.width/2-rounde/2
			rect2.y = 1+Close.height/2 - rect2.height/2-rounde/2
			*/
			
			
			
		}

		private function Over(event:MouseEvent):void
		{
			buttonMode = true;
			Tweener.addTween(this, {scaleX:1.4,
									scaleY:1.4,
									time:0.3, 
									transition:"linear" })
		}
		private function Out(event:MouseEvent):void
		{
			buttonMode = false;
			Tweener.addTween(this, {scaleX:1.0,
				 					scaleY:1.0,
									time:0.3, 
									transition:"linear" })
		}
	}
	
}