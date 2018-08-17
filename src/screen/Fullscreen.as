package screen
{
	import caurina.transitions.Tweener;
	
	import flash.display.*;
	import flash.events.*;
	import flash.filters.GlowFilter;
	import flash.utils.Timer;
	
	public class Fullscreen extends MovieClip
	{
		public var main:Main;
		private var tracker:Tracker = new Tracker()
		
		private var sizeWidth:Number  = 40;
		private var sizeHeight:Number = 30
        private var bgColor:uint      = 0x222222;
        private var borderColor:uint  = 0xffffff;
        private var borderSize:uint   = 0;
        private var cornerRadius:uint = 5;
        private var gutter:uint       = 5;
		
		private var graf:Shape = new Shape()
		private var rect1:MovieClip = new MovieClip()
		private var rect2:MovieClip = new MovieClip()
		private var rect3:Shape = new Shape()
		
		private var myTimer:Timer = new Timer(500)
		
		private var BlurGlow:Number = 1.8
		private var StrechGlow:Number = 1.4
		private var QualityGlow:Number = 100
		
		private var filterGlow:GlowFilter = new GlowFilter(borderColor, 1, BlurGlow, BlurGlow, StrechGlow, QualityGlow);
		
		
		public function Fullscreen()
		{
			this.filters = [filterGlow];
			createRects();
			ActiveFull();
		}
		private function createRects():void
		{
			//graf.graphics.beginFill(bgColor, 0.0);
            //graf.graphics.lineStyle(borderSize, borderColor);
            graf.graphics.drawRect(-sizeWidth, -sizeHeight, sizeWidth*3, sizeHeight*3);
            graf.graphics.endFill();
            addChild(graf);
			
			//rect2.graphics.beginFill(bgColor, 0.0);
            rect2.graphics.lineStyle(borderSize, borderColor);
            rect2.graphics.drawRect(0, 0, sizeWidth, sizeHeight);
            rect2.graphics.endFill();
            addChild(rect2);
			//
			rect1.graphics.beginFill(bgColor, 0.0);
            rect1.graphics.lineStyle(borderSize, borderColor);
            rect1.graphics.drawRect(0, 0, sizeWidth, sizeHeight);
            rect1.graphics.endFill();
            addChild(rect1);
            
            rect3.graphics.lineStyle(borderSize, borderColor);
            rect3.graphics.drawRect(sizeWidth/4, sizeHeight/4, sizeWidth/2, sizeHeight/2);
            rect3.graphics.endFill();
            addChild(rect3);
			//rect1.scaleX = 0.90
			//rect1.scaleY = 0.90
			//
			rect1.addEventListener( MouseEvent.CLICK, goFull );
			
		}
		private function ActiveFull():void
		{
			myTimer.removeEventListener(TimerEvent.TIMER, timerClose);
			myTimer.addEventListener(TimerEvent.TIMER, timerFull);
			
			rect1.removeEventListener(MouseEvent.MOUSE_OVER, OverClose)
            rect1.removeEventListener(MouseEvent.MOUSE_OUT, OutClose)
			
			rect1.addEventListener(MouseEvent.MOUSE_OVER, OverFull)
            rect1.addEventListener(MouseEvent.MOUSE_OUT, OutFull)
			
		}
		private function ActiveClose():void
		{
			myTimer.removeEventListener(TimerEvent.TIMER, timerFull);
			myTimer.addEventListener(TimerEvent.TIMER, timerClose);
			
			rect1.addEventListener(MouseEvent.MOUSE_OVER, OverClose)
            rect1.addEventListener(MouseEvent.MOUSE_OUT, OutClose)
			
			rect1.removeEventListener(MouseEvent.MOUSE_OVER, OverFull)
            rect1.removeEventListener(MouseEvent.MOUSE_OUT, OutFull)
		}
		private function goFull(event:MouseEvent):void {
			if ( stage.hasOwnProperty("displayState") ) {
				if ( stage.displayState != StageDisplayState.FULL_SCREEN ) {
					stage.displayState = StageDisplayState.FULL_SCREEN;
					ActiveClose();
				} else {
					stage.displayState = StageDisplayState.NORMAL;
					ActiveFull();
					
				}
			}
			tracker.track("fullscreen")
			
		}
		private function OverFull(event:MouseEvent):void
		{
			buttonMode = true;
			TweenFull()
			myTimer.start();
		}
		private function OutFull(event:MouseEvent):void
		{
			buttonMode = false;
			//myTimer.reset();
			myTimer.stop();

		}
		private function OverClose(event:MouseEvent):void
		{
			buttonMode = true;
			TweenClose()
			myTimer.start();
		}
		private function OutClose(event:MouseEvent):void
		{
			buttonMode = false;
			//myTimer.reset();
			myTimer.stop();
		}
		private function timerFull(event:TimerEvent):void
		{
			TweenFull()
		}
		private function timerClose(event:TimerEvent):void
		{
			TweenClose()
		}
		private function TweenFull():void
		{
			Tweener.addTween(rect2, {
									scaleX:1.0,
									scaleY:1.0,
									x:0, 
									y:0,
									time:0.3, 
									transition:"linear",
									onComplete: function():void{ 
																rect2.scaleX = 0.0 
																rect2.scaleY = 0.0
																rect2.x = sizeWidth/2 
																rect2.y = sizeHeight/2
																}				
									})
		}
		private function TweenClose():void
		{
			Tweener.addTween(rect2, {
									scaleX:0.0,
									scaleY:0.0,
									x:sizeWidth/2, 
									y:sizeHeight/2,
									time:0.3, 
									transition:"linear",
									onComplete: function():void{ 
																rect2.scaleX = 1.0 
																rect2.scaleY = 1.0
																rect2.x = 0
																rect2.y = 0
																}				
									})
		}
		
	}
}