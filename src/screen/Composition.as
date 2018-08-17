package screen
{
	import caurina.transitions.Tweener;
	
	import flash.display.*;
	import flash.events.*;
	import flash.filters.GlowFilter;
	import flash.text.*;
	
	public class Composition extends MovieClip
	{
		
		public var main:Main
		private var tracker:Tracker = new Tracker()
		private var language:Language = new Language()
		private var TextMode:TextField = new TextField()
		
		private var mv_Mode:MovieClip = new MovieClip()
		
		private var gotoData :DisplayObject
		
		private var maxMinis :Number = 9
		private var num       :Number = 0;
		
		private var borderColor:uint  = 0xffffff;
		
		public var GRID:Number
		public var GRID_SPACING:Number
		public var cloudSize :Number;
		
		public var BoxScale:Number = 1.8
		public var BoxMeasure:Number = 5
		public var rotSize:Number = 360
		
		private var FormatText:TextFormat = new TextFormat()
		
		
		private var BlurGlow:Number = 1.5
		private var StrechGlow:Number = 0.8
		private var QualityGlow:Number = 100
		private var filterGlow:GlowFilter = new GlowFilter(borderColor, 1, BlurGlow, BlurGlow, StrechGlow, QualityGlow);
		
		public function Composition()
		{
			this.filters = [filterGlow];
			
			addEventListener( Event.ENTER_FRAME, loop );
			createTextFormat()
			createText();
			createMode();
		}
		private function createMode():void
		{
			var HitArea:Number = BoxScale * BoxMeasure * maxMinis
			mv_Mode.graphics.beginFill(0x000000, 0.0);
            mv_Mode.graphics.drawRect(-TextMode.width -20, -HitArea/5, TextMode.width + 40, HitArea/2);
            mv_Mode.graphics.endFill();
			addChild(mv_Mode)
		}
		private function createText():void
		{	
			FormatFont(TextMode)
			TextMode.text = language.viewMode
			TextMode.x = -TextMode.width -20
			TextMode.y = -7
		}
		private function createTextFormat():void
		{
			FormatText.color = borderColor
			FormatText.size = 12
			FormatText.font = "Arial"
			FormatText.align = "left"
			FormatText.leading = 0.5
		}
		private function FormatFont(tf:TextField):void
		{
			tf.embedFonts = true
			tf.selectable = false
			tf.mouseEnabled = false
			tf.autoSize = TextFieldAutoSize.RIGHT
			tf.antiAliasType = AntiAliasType.ADVANCED
			tf.blendMode = "layer"
			tf.height = 14
			tf.defaultTextFormat = FormatText;
			addChild(tf)
		}
		private function ActiveRandom():void
		{
			mv_Mode.removeEventListener(MouseEvent.MOUSE_DOWN, goGrid);
			mv_Mode.removeEventListener(MouseEvent.MOUSE_OVER, GridOver);
			mv_Mode.removeEventListener(MouseEvent.MOUSE_OUT, GridOut);
			//
			mv_Mode.addEventListener(MouseEvent.MOUSE_DOWN, goRandom);
			mv_Mode.addEventListener(MouseEvent.MOUSE_OVER, RandomOver);
			mv_Mode.addEventListener(MouseEvent.MOUSE_OUT, RandomOut);
		}
		private function ActiveGrid():void
		{
			mv_Mode.removeEventListener(MouseEvent.MOUSE_DOWN, goRandom);
			mv_Mode.removeEventListener(MouseEvent.MOUSE_OVER, RandomOver);
			mv_Mode.removeEventListener(MouseEvent.MOUSE_OUT, RandomOut);
			//
			mv_Mode.addEventListener(MouseEvent.MOUSE_DOWN, goGrid);
			mv_Mode.addEventListener(MouseEvent.MOUSE_OVER, GridOver);
			mv_Mode.addEventListener(MouseEvent.MOUSE_OUT, GridOut);
		}
		private function goRandom(event:MouseEvent):void
		{
			tracker.track("viewmode_random")
			main.managerbox.goRandom();
			ActiveGrid();
		}
		private function goGrid(event:MouseEvent):void
		{
			tracker.track("viewmode_grid")
			main.managerbox.goGrid();
			ActiveRandom();
		}
		private function RandomOver(event:MouseEvent):void
		{
			buttonMode = true
			RandomSpace()
		}
		private function RandomOut(event:MouseEvent):void
		{
			buttonMode = false
			GridSpace()
		}
		private function GridOver(event:MouseEvent):void
		{
			buttonMode = true
			GridSpace()
		}
		private function GridOut(event:MouseEvent):void
		{
			buttonMode = false
			RandomSpace()
		}
		private function createMiniBox():void
		{			
			var Box:MovieClip = new MovieClip()
			Box.graphics.beginFill(borderColor);
            Box.graphics.drawRect(0, 0, BoxMeasure, BoxMeasure);
            Box.graphics.endFill();
			Box.name = "Mini"+ String(num);
			Box.mouseEnabled = false
			addChild(Box)
			num++;
		}
		private function goMini(e:Event):void
		{
			e.target.x = Math.random() * cloudSize
			e.target.y = Math.random() * cloudSize
		}
		private function ChoiceView():void 
		{
			RandomSpace();
			ActiveGrid();
			//
			//GridSpace();
			//ActiveRandom();
		}
		private function loop(event:Event):void {
			if ( num < maxMinis ) {
				createMiniBox();
			}
			if (num == maxMinis) {
				ChoiceView();
				removeEventListener( Event.ENTER_FRAME, loop );
			}
		}
		private function RandomSpace():void
		{
			cloudSize = BoxMeasure * BoxScale * (Math.ceil(Math.sqrt(maxMinis)))
			
			var Box:DisplayObject
			for (var i:Number=0; Box = getChildByName("Mini"+String(i));  i++) 
			{
				Tweener.addTween(Box,{	x:Math.random() * cloudSize - cloudSize/2,
									 	y:Math.random() * cloudSize - cloudSize/2,
									 	rotation:Math.random() * rotSize,
									 	time:0.4,
									 	transition:"linear"
									 })
			}
		}
		private function GridSpace():void
		{
			var eixoX:Number=0;
			var eixoY:Number=0;
			GRID_SPACING = BoxMeasure*BoxScale;
			GRID = Math.ceil(Math.sqrt(maxMinis))
			var Box:DisplayObject
			for (var i:Number=0; Box = getChildByName("Mini"+String(i)); i++) 
			{
				eixoX++
				if (eixoX >= GRID) {
					eixoX=0;
					eixoY++;
				}
				if ( eixoY >= GRID){
					eixoY = 0;
				}
				Box.rotation = 0
				var GRIDX:Number = GRID_SPACING * eixoX - (GRID_SPACING*GRID)/2 + GRID_SPACING/2;
				var GRIDY:Number = -GRID_SPACING * eixoY + (GRID_SPACING*GRID)/2 - GRID_SPACING/2;
				//Box.x=GRIDX;
				//Box.y=GRIDY;
				Tweener.addTween(Box,{	x:GRIDX,
									 	y:GRIDY,
									 	rotation:0,
									 	time:0.4,
									 	transition:"linear"
									 })
			}

		}
	}
}