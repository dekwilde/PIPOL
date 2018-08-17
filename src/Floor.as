package  
{
	import flash.display.DisplayObject;
	import org.papervision3d.materials.*
	import org.papervision3d.materials.utils.MaterialsList;
	import org.papervision3d.objects.DisplayObject3D;
	import org.papervision3d.objects.primitives.*;
	import org.papervision3d.scenes.Scene3D;
	import screen.FloorMaterial;
	import flash.display.DisplayObject;
	import org.papervision3d.scenes.Scene3D;
	import org.papervision3d.scenes.Scene3D;
	import org.papervision3d.events.InteractiveScene3DEvent;
	
	import org.papervision3d.materials.MovieMaterial;
	import org.papervision3d.materials.utils.MaterialsList;
	
	import org.papervision3d.objects.primitives.Cube
	
	/**
	 * ...
	 * @author DekWilde
	 */
	public class Floor 
	{
		public var main:Main
		public var plane:Plane
		
		public var material_box:MaterialsList = new MaterialsList();
		private var mc:FloorMaterial = new FloorMaterial();
		private var texture:MovieMaterial = new MovieMaterial(mc, true, true,false)

			
		public var blocos:DisplayObject3D = new DisplayObject3D();
		
		public function Floor() 
		{
			plane = new Plane(texture, 10000, 8000, 4, 4)
			texture.interactive = true
			plane.yaw(90);
			plane.y = -1000
			plane.pitch(90);
		}
		public function Enable():void
		{
			plane.addEventListener(InteractiveScene3DEvent.OBJECT_OVER,FloorOver);
			plane.addEventListener(InteractiveScene3DEvent.OBJECT_OUT,FloorOut);
			plane.addEventListener(InteractiveScene3DEvent.OBJECT_PRESS,FloorPress);	
		}
		public function Disable():void
		{
			plane.removeEventListener(InteractiveScene3DEvent.OBJECT_OVER,FloorOver);
			plane.removeEventListener(InteractiveScene3DEvent.OBJECT_OUT,FloorOut);
			plane.removeEventListener(InteractiveScene3DEvent.OBJECT_PRESS,FloorPress);	
		}
		private function FloorOver(e:InteractiveScene3DEvent):void
		{
			main.navegador.Back()
		}
		private function FloorOut(e:InteractiveScene3DEvent):void
		{
			main.navegador.FadeOUT()
		}
		private function FloorPress(e:InteractiveScene3DEvent):void
		{
			main.manager_scene.CameraBack();
			Disable();
		}
		
		
	}
	
}