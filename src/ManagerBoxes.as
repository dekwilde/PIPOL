package
{
	import caurina.transitions.Tweener;
	
	import flash.display.*;
	import flash.events.*;
	import flash.external.ExternalInterface;
	import flash.filters.GlowFilter;
	import flash.net.*;
	
	import org.papervision3d.cameras.*;
	import org.papervision3d.core.proto.*;
	import org.papervision3d.events.InteractiveScene3DEvent;
	import org.papervision3d.materials.*;
	import org.papervision3d.materials.shaders.PhongShader;
	import org.papervision3d.materials.shaders.ShadedMaterial;
	import org.papervision3d.materials.utils.MaterialsList;
	import org.papervision3d.objects.*;
	import org.papervision3d.objects.primitives.*;
	import org.papervision3d.scenes.*;
	
	import screen.*;
	
	public class ManagerBoxes
	{
		public var main:Main;
		private var tracker:Tracker = new Tracker()
		
		public var Box:Cube
		public var cubes:DisplayObject3D = new DisplayObject3D();
		
		public var boxmaterial:BoxMaterial = new BoxMaterial();
		public var material_box:MaterialsList=new MaterialsList;
		private var ms: MovieMaterial
		//private var texture:GouraudMaterial;
		//private var texture:PhongMaterial;
		
		//private var swirlMaterial:SwirlMaterial;
		//private var swirlMaterialBump:SwirlMaterialBump;
		private var phongShader:PhongShader;
		private var phongShaderMat:ShadedMaterial;
		
		
		private var gotoData :DisplayObject3D
		public var SelectBox:DisplayObject3D;
		
		public var currentImg:Number = 0;
		public var lastImg:Number;
		public var GRID:Number
		public var GRID_SPACING:Number
		public var cloudSize :Number;
		
		public var BoxScale:Number = 1.1
		public var PlacaMeasure:Number = 240
		public var BoxMeasure:Number = 200
		
		
		private var rotSize   :Number = 360;
		public var maxAlbums :Number;
		private var num       :Number = 0;
		public var BoxNumber:Number;
		private var BoxCount:Number = 4.5
		
		private var eixoX:Number=0;
		private var eixoY:Number=0;
		private var eixoZ:Number=0;
		
		public var gridview:Boolean
		public var randomview:Boolean
		
		
		private var borderColor:uint  = 0xffffff;
		private var BlurGlow:Number = 1.8
		private var StrechGlow:Number = 1.4
		private var QualityGlow:Number = 100
		
		private static const DISTANCE_FROM_BOX:Number = 700;
		
		private var filterGlow:GlowFilter = new GlowFilter(borderColor, 1, BlurGlow, BlurGlow, StrechGlow, QualityGlow);
		
		public function ManagerBoxes()
		{
			super();
		}
		public function Init():void
		{
			lastImg = main.creatgallery.xml.projeto.length() - 1;
			maxAlbums = main.creatgallery.xml.projeto.length();
			
			setCameraDistance();

			creatCubes();
			loadImg();
		}
		public function setCameraDistance():void {
			main.WordPosition = -(maxAlbums/(maxAlbums/3))*1000
			main.manager_scene.cameraStart.z = main.WordPosition
			main.manager_scene.createTween(main.manager_scene.cameraStart, main.manager_scene.target_null);	
			main.manager_scene.l.z = -main.WordPosition
		}
		
		public function creatCubes():void {
			 main.manager_scene.scene.addChild(cubes);
		}
		
		public function loadImg():void 
		{
			main.creatgallery.loader.load(new URLRequest(main.creatgallery.xml.projeto[currentImg].thumbs));
			boxmaterial.addChild(main.creatgallery.loader);
			main.creatgallery.loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loop);
		}
		public function createAlbum():void
		{
			//texture = new GouraudMaterial(main.manager_scene.l, 0xffffff, 0x555555, 1)
			//texture = new PhongMaterial(main.manager_scene.l,0xffffff,0x444444,1)
			ms = new MovieMaterial(boxmaterial, false, false);
			
			phongShader = new PhongShader(main.manager_scene.l, 0xFFFFFF, 0x474747, 40);
			phongShaderMat = new ShadedMaterial(ms, phongShader, 1); 
			
			phongShaderMat.interactive = true
			//ms.doubleSided = true;
			material_box.addMaterial(phongShaderMat,"all");
			Box = new Cube(material_box, BoxMeasure, BoxMeasure, BoxMeasure, 1, 1, 1);
			
			ChoiceView()
			
			Box.extra ={goto: gotoData};
			
			//Box.filters = [filterGlow];
			
			
			cubes.addChild( Box, "Album" + String( num ) );
			Box.addEventListener(InteractiveScene3DEvent.OBJECT_OVER,BoxesOver);
			Box.addEventListener(InteractiveScene3DEvent.OBJECT_OUT,BoxesOut);
			
			currentImg = (currentImg < lastImg)? currentImg + 1 : 0;
			loadImg();
			goBox();
			trace("projeto:" + ((Number(Box.name)/2)-BoxCount));
			//trace("projeto:" + String( num ))
			num++;
			
			
		}
		private function loop(event:Event):void {
			if ( num < maxAlbums ) {
				createAlbum();
			}
			if (num == maxAlbums) {
				//goGrid();
			}
			if (num == 0){
				main.manager_scene.createTween(main.manager_scene.cameraStart, main.manager_scene.target_null);
			}
		}
		// Positions //////////////////////////////////////////////////////////
		private function ChoiceView():void 
		{
			RandomSpace();
			//GridSpace();
			randomview = true
			gridview = false
		}
		
		public function goRandom():void
		{
			randomview = true
			gridview = false
			main.manager_scene.createTween(main.manager_scene.cameraStart, main.manager_scene.target_null);
			main.manager_scene.RandomView()
			main.descricao.Dispose()
			var Boxes :DisplayObject3D;
			for (var i:Number=0; Boxes = cubes.getChildByName( "Album"+i ); i++) 
			{
				RandomSpace();
				Boxes.extra ={goto: gotoData};
			}
			goBox();
		}
		public function goGrid():void
		{
			randomview = false
			gridview = true
			main.manager_scene.createTween(main.manager_scene.cameraStart, main.manager_scene.target_null);
			main.manager_scene.GridView()
			main.descricao.Dispose()
			var Boxes :DisplayObject3D;
			for (var i:Number=0; Boxes = cubes.getChildByName( "Album"+i ); i++) 
			{
				GridSpace();
				Boxes.extra ={goto: gotoData};
			}
			goBox();
		}
		private function RandomSpace():void
		{
			cloudSize = 0.8 * BoxMeasure * BoxScale * (Math.ceil(Math.sqrt(maxAlbums)))
			
			gotoData = new DisplayObject3D();
			gotoData.x = Math.random() * cloudSize - cloudSize/2;
			gotoData.y = Math.random() * cloudSize - cloudSize/2;
			gotoData.z = Math.random() * cloudSize - cloudSize/2;
			gotoData.rotationX = Math.random() * rotSize;
			gotoData.rotationY = Math.random() * rotSize;
			gotoData.rotationZ = Math.random() * rotSize;
			gotoData.scaleX = 1.0;
			gotoData.scaleY = 1.0;
			gotoData.scaleZ = 1.0;
		}
		private function GridSpace():void
		{
			GRID_SPACING = BoxMeasure*BoxScale;
			GRID = Math.ceil(Math.sqrt(maxAlbums))
			eixoX++
			if (eixoX >= GRID) {
				eixoX=0;
				eixoY++;
			}
			if ( eixoY >= GRID){
				eixoY = 0;
			}
			
			gotoData = new DisplayObject3D();
			gotoData.rotationX = 45
			gotoData.rotationY = 0
			gotoData.rotationZ = 0
			gotoData.scaleX = 1.0;
			gotoData.scaleY = 1.0;
			gotoData.scaleZ = 1.0;
			
			
			gotoData.x=GRID_SPACING * eixoX - (GRID_SPACING*GRID)/2 + GRID_SPACING/2;
			gotoData.z=-GRID_SPACING * eixoY + (GRID_SPACING*GRID)/2 - GRID_SPACING/2;
			gotoData.y=-(BoxMeasure*BoxScale)/2

		}
		public function goBox():void
		{
			var paper :DisplayObject3D;
			for (var i:Number=0; paper = cubes.getChildByName( "Album"+i ); i++) {
				var goto :DisplayObject3D = paper.extra.goto;
				Tweener.addTween(paper, {x:goto.x,
									  	 y:goto.y,
									  	 z:goto.z,
									  	 scaleX:goto.scaleX,
									  	 scaleY:goto.scaleY,
									  	 scaleZ:goto.scaleZ,
									  	 rotationX:goto.rotationX,
									  	 rotationY:goto.rotationY,
									  	 rotationZ:goto.rotationZ,
									  	 time:Math.random() * 3 + 1,
									  	 transition:"easeOutCirc"
									  	 })			
			}
		}
		// Listerner's ///////////////////////////////////////////////////////////////////////////////
		private function BoxesPress(e:InteractiveScene3DEvent):void 
		{
			
			var BoxPress:Cube = Cube(e.target);
			
			
			main.manager_scene.cameraTarget.copyTransform(BoxPress);
			main.manager_scene.cameraTarget.moveBackward(DISTANCE_FROM_BOX);
			
			//main.manager_scene.CameraZoom = 5
			//main.manager_scene.CameraFocus = 180
			main.manager_scene.createTween(main.manager_scene.cameraTarget, BoxPress);
			
			BoxNumber = (Number(BoxPress.name)/2)-BoxCount
			main.manager_scene.SelectView();
			main.floor.Enable();
			main.bg.Enable();
			
			//
			BoxesEnable();
			//
			BoxPress.removeEventListener(InteractiveScene3DEvent.OBJECT_PRESS,BoxesPress);
			BoxPress.removeEventListener(InteractiveScene3DEvent.OBJECT_OVER,BoxesOver);
			BoxPress.removeEventListener(InteractiveScene3DEvent.OBJECT_OUT,BoxesOut);
			//
			BoxPress.addEventListener(InteractiveScene3DEvent.OBJECT_OVER,BoxOver);
			BoxPress.addEventListener(InteractiveScene3DEvent.OBJECT_OUT,BoxOut);
			BoxPress.addEventListener(InteractiveScene3DEvent.OBJECT_PRESS,BoxSelected);
			//
			main.tituloprojeto.Show(BoxNumber);
			main.navegador.PresstoOpen();
			trace(BoxNumber)
			Tweener.addTween(BoxPress, {scaleX: 1.0,
								   scaleY: 1.0,
								   scaleZ: 1.0, 
								   time:0.3, 
								   transition:"easeOutCirc"})
								

		}
		
		private function BoxesOver(e:InteractiveScene3DEvent):void {
			var BoxOver:DisplayObject3D=e.displayObject3D;
			var BoxOverNumber:Number = (Number(BoxOver.name)/2)-BoxCount
			//trace(BoxNumber);
			main.navegador.Year(BoxOverNumber);
			BoxOver.addEventListener(InteractiveScene3DEvent.OBJECT_PRESS,BoxesPress);

			var positionX:Number = Math.random() * 160 - 80 +  BoxOver.x
			var positionY:Number = Math.random() * 160 - 80 +  BoxOver.y
			var positionZ:Number = Math.random() * 160 - 80 +  BoxOver.z
			var RotationX:Number = Math.random() * 90 
			var RotationY:Number = Math.random() * 90
			var RotationZ:Number = Math.random() * 90
			
			Tweener.addTween(BoxOver, {scaleX: BoxScale,
								   scaleY: BoxScale,
								   scaleZ: BoxScale,
								   x:positionX,
								   y:positionY,
								   z:positionZ,
								   rotationX:RotationX,
								   rotationY:RotationY,
								   rotationZ:RotationZ,
								   time:2, 
								   transition:"easeOutBack"})
			
		}

		
		
		private function BoxesOut(e:InteractiveScene3DEvent):void {
			var BoxOut:DisplayObject3D=e.displayObject3D;
			BoxOut.removeEventListener(InteractiveScene3DEvent.OBJECT_PRESS,BoxesPress);
			main.navegador.FadeOUT();
			Tweener.addTween(BoxOut, {scaleX: 1.0,
								   scaleY: 1.0,
								   scaleZ: 1.0, 
								   time:0.3, 
								   transition:"easeOutCirc"})
		}
		private function BoxSelected(e:InteractiveScene3DEvent):void {
			BoxesDisable();
			SelectBox = e.displayObject3D;
			main.bg.Disable();
			main.floor.Disable();
			main.navegador.FadeOUT();
			Tweener.addTween(SelectBox, 	{scaleX:0.0,
											scaleY:0.0,
											scaleZ:0.0,
											time:0.7,
											transition:"easeOutCirc"})
			
			main.manager_scene.cubeLigth();								
			main.openbox.createPlane();
			main.manager_scene.InfoView();
			tracker.track("box_open" + SelectBox.name)
		}
		public function BoxOver(e:InteractiveScene3DEvent):void {
			var BoxOver:DisplayObject3D=e.displayObject3D;
			main.navegador.PresstoOpen();
			BoxOver.addEventListener(InteractiveScene3DEvent.OBJECT_PRESS,BoxSelected);			
		}
		public function BoxOut(e:InteractiveScene3DEvent):void {
			var BoxOut:DisplayObject3D=e.displayObject3D;
			main.navegador.FadeOUT()
			BoxOut.removeEventListener(InteractiveScene3DEvent.OBJECT_PRESS,BoxSelected);

		}
		// FILTER ////////////////////////////////////////////////////////////////////////////////
		public function BoxesFilter(str:String):void {
			//ExternalInterface.call("console.log", "String ano " + str);
			var Boxes :DisplayObject3D;
			for (var i:Number=0; Boxes = cubes.getChildByName( "Album"+i ); i++) 
			{				
				var str_xml:String = main.creatgallery.xml.projeto[i].ano
				//ExternalInterface.call("console.log", "XML ano " + str_xml);
				
				if(str != str_xml) {
					
					Boxes.removeEventListener(InteractiveScene3DEvent.OBJECT_PRESS,BoxSelected);
					Boxes.removeEventListener(InteractiveScene3DEvent.OBJECT_OVER,BoxOver);
					Boxes.removeEventListener(InteractiveScene3DEvent.OBJECT_OUT,BoxOut);
					Boxes.removeEventListener(InteractiveScene3DEvent.OBJECT_PRESS,BoxesPress);
					Boxes.removeEventListener(InteractiveScene3DEvent.OBJECT_OVER,BoxesOver);
					Boxes.removeEventListener(InteractiveScene3DEvent.OBJECT_OUT,BoxesOut);
					
					//ExternalInterface.call("console.log", "Filter Box " + i);
					
					var RotationX:Number = Math.random() * 90 
					var RotationY:Number = Math.random() * 90
					var RotationZ:Number = Math.random() * 90
					cloudSize = 12 * BoxMeasure * BoxScale * (Math.ceil(Math.sqrt(maxAlbums)))
					
					
					Tweener.addTween(Boxes, { 	x:Math.random() * cloudSize - cloudSize/2,
								   				y:Math.random() * cloudSize - cloudSize/2,
								   				z:Math.random() * cloudSize - cloudSize/2,
								   				scaleX:0.0,
												scaleY:0.0,
												scaleZ:0.0,
								   				rotationX:RotationX,
								   				rotationY:RotationY,
								   				rotationZ:RotationZ,
								   				delay: Math.random() * 4.0 + 0.8,
								   				time:Math.random() * 3.0 + 0.8, 
								   				transition:"easeOutBack",
								   				onComplete: function():void
								   							{ 
								   								cubes.removeChild(Boxes); 
								   							}
								   				})
					

					
				} else {
					Boxes.removeEventListener(InteractiveScene3DEvent.OBJECT_OVER,BoxOver);
					Boxes.removeEventListener(InteractiveScene3DEvent.OBJECT_OUT,BoxOut);
					Boxes.addEventListener(InteractiveScene3DEvent.OBJECT_OVER,BoxesOver);
					Boxes.addEventListener(InteractiveScene3DEvent.OBJECT_OUT,BoxesOut);	
				}
			}
			
		}
		
		
				
		// Condition's ////////////////////////////////////////////////////////////////////////
		public function BoxesDisable():void
		{
			var Boxes :DisplayObject3D;
			for (var i:Number=0; Boxes = cubes.getChildByName( "Album"+i ); i++) 
			{
				Boxes.removeEventListener(InteractiveScene3DEvent.OBJECT_PRESS,BoxSelected);
				Boxes.removeEventListener(InteractiveScene3DEvent.OBJECT_OVER,BoxOver);
				Boxes.removeEventListener(InteractiveScene3DEvent.OBJECT_OUT,BoxOut);
				Boxes.removeEventListener(InteractiveScene3DEvent.OBJECT_PRESS,BoxesPress);
				Boxes.removeEventListener(InteractiveScene3DEvent.OBJECT_OVER,BoxesOver);
				Boxes.removeEventListener(InteractiveScene3DEvent.OBJECT_OUT,BoxesOut);
			}	
		}
		public function BoxesEnable():void
		{
			var Boxes :DisplayObject3D;
			for (var i:Number=0; Boxes = cubes.getChildByName( "Album"+i ); i++) 
			{
				Boxes.removeEventListener(InteractiveScene3DEvent.OBJECT_OVER,BoxOver);
				Boxes.removeEventListener(InteractiveScene3DEvent.OBJECT_OUT,BoxOut);
				Boxes.addEventListener(InteractiveScene3DEvent.OBJECT_OVER,BoxesOver);
				Boxes.addEventListener(InteractiveScene3DEvent.OBJECT_OUT,BoxesOut);
			}	
		}
		public function BoxAtive():void
		{
			var BoxAtive :DisplayObject3D;
			BoxAtive = SelectBox
			Tweener.addTween(BoxAtive, 	{scaleX:1.0,
									 scaleY:1.0,
									 scaleZ:1.0,
									 time:0.8,
									 transition:"easeOutCirc"})
		}
		
		public function Dispose():void
		{
			BoxesDisable();
		}	
		public function Destroy():void
		{
			BoxesDisable();
			var Boxes :DisplayObject3D;
			for (var i:Number=0; Boxes = cubes.getChildByName( "Album"+i ); i++) {
				cubes.removeChild(Boxes);
			}
			//main.manager_scene.scene.removeChild(cubes);
		}


	}
}