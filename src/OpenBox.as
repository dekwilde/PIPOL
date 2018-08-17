package
{
	import caurina.transitions.Tweener;
	
	import flash.display.*;
	import flash.filters.GlowFilter;
	
	import org.papervision3d.cameras.*;
	import org.papervision3d.core.proto.*;
	import org.papervision3d.materials.*;
	import org.papervision3d.objects.*;
	import org.papervision3d.objects.primitives.*;
	import org.papervision3d.scenes.*;
	
	import screen.*;
	public class OpenBox
	{
		public var main:Main;
		
		private var Placa1:Plane
		private var Placa2:Plane
		public var Placa3:Plane
		private var Placa4:Plane
		private var Placa5:Plane
		private var Placa6:Plane
		private var PlacaMeasure:Number = 240
		private var WorldPosition:Number;
		private var CloudSize:Number = 2000;
		private var time_tween:Number = 1.2
		private var glow_plane:GlowFilter = new GlowFilter(0xFFFFFF, 1, 20, 20, 2, 1)
		
		
		
	 	private var texture:PlacaMaterial = new PlacaMaterial;
		
		public function OpenBox()
		{
			super();
			//descricao.openbox = this
			
		}
		public function createPlane():void
		{
			WorldPosition = main.WordPosition + 700
			var TargetBox:DisplayObject3D;
			TargetBox = main.managerbox.SelectBox
			//TargetBox.visible = false;
			var planematerial:MovieMaterial = new MovieMaterial(texture,true, true)
			planematerial.doubleSided = true
			Placa1 = new Plane(planematerial, PlacaMeasure, PlacaMeasure,1,1)
			Placa2 = new Plane(planematerial, PlacaMeasure, PlacaMeasure,1,1)
			Placa3 = new Plane(planematerial, PlacaMeasure, PlacaMeasure,1,1)
			Placa4 = new Plane(planematerial, PlacaMeasure, PlacaMeasure,1,1)
			Placa5 = new Plane(planematerial, PlacaMeasure, PlacaMeasure,1,1)
			Placa6 = new Plane(planematerial, PlacaMeasure, PlacaMeasure,1,1)

			main.manager_scene.scene.addChild(Placa1, "placa1");
			main.manager_scene.scene.addChild(Placa2, "placa2");
			main.manager_scene.scene.addChild(Placa3, "placa3");
			main.manager_scene.scene.addChild(Placa4, "placa4");
			main.manager_scene.scene.addChild(Placa5, "placa5");
			main.manager_scene.scene.addChild(Placa6, "placa6");
			main.manager_scene.viewport.getChildLayer(Placa1).filters = [glow_plane];
			main.manager_scene.viewport.getChildLayer(Placa2).filters = [glow_plane];
			main.manager_scene.viewport.getChildLayer(Placa3).filters = [glow_plane]
			main.manager_scene.viewport.getChildLayer(Placa4).filters = [glow_plane]
			main.manager_scene.viewport.getChildLayer(Placa5).filters = [glow_plane]
			main.manager_scene.viewport.getChildLayer(Placa6).filters = [glow_plane]
			
			//
			Placa1.copyTransform(TargetBox)
			Placa2.copyTransform(TargetBox)
			Placa3.copyTransform(TargetBox)
			Placa4.copyTransform(TargetBox)
			Placa5.copyTransform(TargetBox)
			Placa6.copyTransform(TargetBox)
			//
			
			Placa1.moveForward(PlacaMeasure/2)
			Placa2.moveBackward(PlacaMeasure/2)
			Placa3.moveDown(PlacaMeasure/2)
			Placa3.roll(90)
			Placa3.yaw(90)
			Placa4.moveUp(PlacaMeasure/2)
			Placa4.roll(90)
			Placa4.yaw(-90)
			Placa5.moveLeft(PlacaMeasure/2)
			Placa5.yaw(90)
			Placa6.moveRight(PlacaMeasure/2)
			Placa6.yaw(-90);
			
			// begin the animation os transition
			FadeIN()
			//openPlacas();
			
		}
		public function FadeIN():void
		{
			Tweener.addTween(texture.graf, { 	alpha:1.0, 
												time:2.0,
												transition:"linear", 
												onComplete: function():void{ openPlacas() }})
			Tweener.addTween(texture.border, {	alpha:1.0, 
												time:1,
												transition:"linear", 
												onComplete: function():void{ BorderFadeOUT() }})
		}
		public function FadeOUT():void
		{
			Tweener.addTween(texture.graf, {alpha:0.0, 
											width:PlacaMeasure,
											height:PlacaMeasure,
											time:2.2,
											transition:"linear"})
			Tweener.addTween(texture.border, { 	alpha:0.0, 
												time:1.2,
												transition:"linear"})
		}
		private function BorderFadeOUT():void
		{
			Tweener.addTween(texture.graf, {width:PlacaMeasure + 5,
											height:PlacaMeasure + 5,
											time:0.5,
											transition:"linear"
											})
			Tweener.addTween(texture.border, { 	alpha:0.0, 
												time:0.5,
												transition:"linear"})
		}
		private function openPlacas():void
		{
			main.tituloprojeto.FadeOUT()
			main.manager_scene.CameraOpenBox();
			
/*			var GRID:Number = 3
			var eixoX:Number = -1
			var eixoY:Number = -1
			var Placas :DisplayObject3D;
			for (var i:Number=1; Placas = main.scene.getChildByName( "placa"+i ); i++) 
			{
				eixoX++
				if (eixoX > GRID) {
					eixoX=0;
					eixoY++;
				}
				if ( eixoY > GRID){
					eixoY = 0;
				}
			
				Tweener.addTween(Placas, {x: eixoX * PlacaMeasure,
									  	  y: eixoY * (PlacaMeasure/2),
									  	  z: WorldPosition,
									  
									  	  rotationX: 0,
									  	  rotationY: 0,
									  	  rotationZ: 0,
									  	  time:1.0,
									  	  transition:"linear",
									  	  onComplete: function():void{ showDescricao() }									  
									  	  })
			}*/
			
			
			
			
			var tweenType:String = "easeOutCirc";
			var tweenDelay:Number = 0.5
			Tweener.addTween(Placa1, {x:-PlacaMeasure,
									  y:PlacaMeasure/2,
									  z:WorldPosition,
									  rotationX:0,
									  rotationY:0,
									  rotationZ:0,
									  time:Math.random()*2 + time_tween,
									  transition:tweenType,
									  delay: Math.random()*tweenDelay
									  })
			//////////////////////////////////////////////////////////////
			Tweener.addTween(Placa2, {x:0,
									  y:PlacaMeasure/2,
									  z:WorldPosition,
									  rotationX:0,
									  rotationY:0,
									  rotationZ:0,
									  time:Math.random()*2 + time_tween,
									  transition:tweenType,
									  delay: Math.random()*tweenDelay
									  })
			////////////////////////////////////////////////////////////
			Tweener.addTween(Placa3, {x:PlacaMeasure,
									  y:PlacaMeasure/2,
									  z:WorldPosition,
									  rotationX:0,
									  rotationY:0,
									  rotationZ:0,
									  time:Math.random()*2 + time_tween,
									  transition:tweenType,
									  delay: Math.random()*tweenDelay
									  })
																		  
			///////////////////////////////////////////////////////////////
			Tweener.addTween(Placa4, {x:-PlacaMeasure,
									  y:-PlacaMeasure/2,
									  z:WorldPosition,
									  rotationX:0,
									  rotationY:0,
									  rotationZ:0,
									  time:Math.random()*2 + time_tween,
									  transition:tweenType,
									  delay: Math.random()*tweenDelay
									  })
			//////////////////////////////////////////////////////////
			Tweener.addTween(Placa5, {x:0,
									  y:-PlacaMeasure/2,
									  z:WorldPosition,
									  rotationX:0,
									  rotationY:0,
									  rotationZ:0,
									  time:Math.random()*2 + time_tween,
									  transition:tweenType,
									  delay: Math.random()*tweenDelay
									  })
			/////////////////////////////////////////////////////////////////
			Tweener.addTween(Placa6, {x:PlacaMeasure,
									  y:-PlacaMeasure/2,
									  z:WorldPosition,
									  rotationX:0,
									  rotationY:0,
									  rotationZ:0,
									  time:Math.random()*2 + time_tween,
									  transition:tweenType,
									  delay: Math.random()*tweenDelay,
									  onComplete: function():void{ showDescricao() }
									  })		
		}
		private function showDescricao():void
		{	
				
				main.managerbox.BoxAtive();
				main.addChild(main.descricao)
				main.descricao.showALL(main.managerbox.BoxNumber)
		}
		public function ClosePlacas():void
		{
			FadeOUT();
			var Placas :DisplayObject3D;
			for (var i:Number=1; Placas = main.manager_scene.scene.getChildByName( "placa"+i ); i++) 
			{
			Tweener.addTween(Placas, {x: - Math.random()*CloudSize + (Math.random()*CloudSize)/2,
									  y: - Math.random()*CloudSize + (Math.random()*CloudSize)/2,
									  z: WorldPosition + Math.random()*CloudSize + 800,
									  
									  rotationX: Math.random()*360,
									  rotationY: Math.random()*360,
									  rotationZ: Math.random()*360,
									  
									  time:2.5,
									  transition:"easeOutCirc",
									  onComplete: function():void{ Destroy() }									  
									  })
			}	
			
		}
		private function Destroy():void
		{
			var Placas :DisplayObject3D;
			for (var i:Number=1; Placas = main.manager_scene.scene.getChildByName( "placa"+i ); i++) 
			{
				main.manager_scene.scene.removeChild(Placas)
			}	
		}
		
		

	}
}