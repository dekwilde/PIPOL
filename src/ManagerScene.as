package  
{
        import caurina.transitions.Tweener;
        
        import flash.display.*;
        import flash.events.*;
        import flash.filters.BlurFilter;
        
        import gs.TweenMax;
        import gs.easing.Cubic;
        
        import org.papervision3d.cameras.*;
        import org.papervision3d.core.geom.TriangleMesh3D;
        import org.papervision3d.core.math.Number3D;
        import org.papervision3d.core.math.Quaternion;
        import org.papervision3d.core.proto.*;
        import org.papervision3d.core.proto.CameraObject3D;
        import org.papervision3d.events.FileLoadEvent;
        import org.papervision3d.lights.PointLight3D;
        import org.papervision3d.materials.*;
        import org.papervision3d.materials.ColorMaterial;
        import org.papervision3d.materials.MovieMaterial;
        import org.papervision3d.materials.shadematerials.GouraudMaterial;
        import org.papervision3d.materials.shaders.ShadedMaterial;
        import org.papervision3d.materials.utils.MaterialsList;
        import org.papervision3d.objects.*;
        import org.papervision3d.objects.DisplayObject3D;
        import org.papervision3d.objects.parsers.DAE;
        import org.papervision3d.objects.primitives.Plane;
        import org.papervision3d.objects.primitives.Sphere;
        import org.papervision3d.objects.special.ParticleField;
        import org.papervision3d.render.*;
        import org.papervision3d.scenes.*;
        import org.papervision3d.view.*;
        import org.papervision3d.view.BasicView;
        import org.papervision3d.view.layer.util.ViewportLayerSortMode;
                
        public class ManagerScene 
        {
                public var container    :Sprite;
                public var scene        :Scene3D;
                public var renderer             :BasicRenderEngine;
                public var viewport             :Viewport3D;
                
                public var main                 :Main
                
                public var CameraZoom:Number = 100;
                public var CameraFocus:Number = 8;
                
                public var WordPosition:Number
                
                private var infoview:Boolean
                private var selectview:Boolean
                private var randomview:Boolean
                private var gridview:Boolean
                
                private var MoveHorizontal:Number
                private var MoveVertical:Number
                private var MaxCameraFree:Number = 600
                
                //controls
                public var ox:Number = 0;
                public var sx:Number = 0;
                public var oy:Number = 0;
                public var sy:Number = 0;
                private var rotationY:Number = 0;
                public var scrollBox:Boolean = false;
                
                
                private static const TWEEN_TIME:Number = 2;
                
                public var camera:CameraWithSlerp = new CameraWithSlerp();
                
                public var cameraStart:DisplayObject3D = new DisplayObject3D();
                public var cameraTarget:DisplayObject3D = new DisplayObject3D();
                public var target_null:DisplayObject3D =  new DisplayObject3D();
                
                private var startQuaternion:Quaternion = null;
                private var endQuaternion:Quaternion = null;
                private var currentQuaternion:Quaternion = null
                
                public var l:PointLight3D = new PointLight3D();
                public var shadowCaster:ShadowCaster = new ShadowCaster("shadow1", 0, BlendMode.NORMAL, 0.60, [new BlurFilter(8, 8, 2)]);
                //properties
                public var useSphere:Boolean = false;
                public var cull:Boolean = false;
                private var useShader:Boolean = true;
                //
                //
                //
                //
                //
                public function ManagerScene() 
                {
                        super();
                }
                public function init():void
                {
                        WordPosition = main.WordPosition
                        creatScene();
                        creatLigth();
                        creatShadow();
                        creatCamera();
                        creatCenter()
                        RandomView();
                        loop();
                }
                private function creatCenter():void{
                        target_null.x = 0
                        target_null.y = 0
                        target_null.z = 0
                        scene.addChild(target_null)
                }
                private function creatLigth():void 
                {
                        l.x = 0;
                        l.y = -main.WordPosition;
                        l.z = 300;
                        newLigth()
                
                }
                public function cubeLigth():void 
                {
                        l.copyPosition(main.managerbox.SelectBox)
                }
                private function newLigth():void
                {
                        Tweener.addTween(l, { x:Math.random() * 1000 - 500, z:Math.random() * 800 - 400, y:Math.random() * 200 + 1500, time:Math.random() * 6 + 8, onComplete:newLigth, delay:Math.random() * 2 } )
                }
                
                private function creatShadow():void 
                {
                        shadowCaster.setType(ShadowCaster.SPOTLIGHT);
                }
                private function creatScene():void
                {
                        container = new Sprite();
                        main.addChild( container );
                        scene = new Scene3D();
                        renderer = new BasicRenderEngine();
                        viewport = new Viewport3D( main.stage.stageWidth, main.stage.stageHeight, true, true);
                        main.addChild( viewport );
                        viewport.containerSprite.sortMode = ViewportLayerSortMode.INDEX_SORT;
                        
                }
                private function creatCamera():void
                {
                        viewport.interactive = true;
                        camera.target = target_null
                        camera.slerp = 0;
                        camera.z = -4000
                        cameraStart.z = WordPosition;
                        cameraStart.y = 500
                        scene.addChild(cameraStart);
                        createTween(cameraStart, target_null);
                }
                
                public function loop():void
                {
                        main.stage.addEventListener( Event.ENTER_FRAME, updateCamera );
                }
                
                public function Enable():void
                {
                        main.stage.addEventListener(MouseEvent.MOUSE_DOWN, onPress);
                        main.stage.addEventListener(MouseEvent.MOUSE_UP, onRelease);
                }
                public function Disable():void
                {
                        main.stage.removeEventListener(MouseEvent.MOUSE_DOWN, onPress);
                        main.stage.removeEventListener(MouseEvent.MOUSE_UP, onRelease);
                }
                
                private function onPress(e:MouseEvent):void{
                        scrollBox = true;
                        ox = container.mouseX;
                        oy = container.mouseY;
                }
                private function onRelease(e:MouseEvent):void{
                        scrollBox = false;
                }
                
                public function orbit(camera:CameraObject3D, target:DisplayObject3D, dir:String="y", angle:Number=0, useAxis:Number3D = null):void{
                        
                        var ax:Number3D = useAxis;
                        var up:Number3D = new Number3D(camera.transform.n12, camera.transform.n22, camera.transform.n32);
                        
                        if(ax == null){
                                //if people dont want to figure out any axis's on their own...
                                if(dir == "x"){
                                        
                                        ax = up;
                                        
                                }else if(dir == "y"){
                                        
                                        var dif:Number3D = new Number3D(camera.x-target.x, camera.y-target.y, camera.z-target.z);
                                        ax = Number3D.cross(up, dif);
                                        
                                }
                        }
                        
                        ax.normalize();
                        
                        var startQuat:Quaternion = new Quaternion(camera.x-target.x, camera.y-target.y, camera.z-target.z, 0);
                        var rotQuat:Quaternion = Quaternion.createFromAxisAngle(ax.x, ax.y, ax.z, angle);
                        rotQuat.normalize();
                        
                        //to rotate a quaternion from center = R*Q*R'
                        var result:Quaternion = Quaternion.multiply(Quaternion.multiply(rotQuat, startQuat), Quaternion.conjugate(rotQuat));
                        
                        //put it in place
                        camera.x = target.x + result.x;
                        camera.y = target.y + result.y;
                        camera.z = target.z + result.z;
                        
                        //make it look the right way
                        camera.lookAt(target, up);
                }
                
                public function GridView():void
                {
                        Disable();
                        infoview = false
                        selectview = false
                        randomview = false
                        gridview = true
                }
                public function RandomView():void
                {
                        Enable();
                        infoview = false
                        selectview = false
                        gridview = false
                        randomview = true
                }
                public function InfoView():void
                {
                        Disable();
                        selectview = false
                        gridview = false
                        randomview = false
                        infoview = true
                }
                public function SelectView():void
                {
                        Disable();
                        gridview = false
                        randomview = false
                        infoview = false        
                        selectview = true
                }
                public function CameraOpenBox():void 
                {
                        
                        var cameraDesc:DisplayObject3D = new DisplayObject3D()
                        cameraDesc.y = 0
                        cameraDesc.z = main.WordPosition
                        var cameraDesTarget:DisplayObject3D = new DisplayObject3D()
                        cameraDesTarget.copyTransform(cameraDesc)
                        cameraDesTarget.moveForward(700)
                        createTween(cameraDesc, cameraDesTarget);
                        
                }
                
                public function CameraBack():void {
                        if (main.managerbox.gridview){
                                var cameraPos:DisplayObject3D = new DisplayObject3D()
                                cameraPos.copyTransform(cameraStart)
                                cameraPos.moveUp(-WordPosition-400)
                                createTween(cameraPos, main.managerbox.cubes);
                                GridView()
                        }
                        if (main.managerbox.randomview){
                                createTween(cameraStart, main.managerbox.cubes);
                                RandomView();
                        }
                        main.managerbox.BoxesEnable();
                        main.managerbox.BoxesEnable();
                        main.tituloprojeto.FadeOUT();
                        Enable();
                }
                public function createTween(displayObject3d:DisplayObject3D, displayTarget:DisplayObject3D):void
                {
                        //when "slerping", this value is a range from 0 to 1
                        //0 being the starting total rotation (AKA transformation)
                        //1 being the ending total rotation
                        camera.slerp = 0;
                        
                        var tweenTarget:Object = {};
                        tweenTarget.x = displayTarget.x;
                        tweenTarget.y = displayTarget.y;
                        tweenTarget.z = displayTarget.z;
                        
                        var tweenCamera:Object = {};
                        tweenCamera.focus = CameraFocus;
                        tweenCamera.zoom = CameraZoom;
                        //tweenObject.focus = 20
                        tweenCamera.x = displayObject3d.x;
                        tweenCamera.y = displayObject3d.y;
                        tweenCamera.z = displayObject3d.z;
                        //tweenObject.bezierThrough = [{x:0, y:0, z:WordPosition, slerp:.1}];
                        tweenCamera.ease = Cubic.easeInOut;
                        tweenCamera.slerp = 1;
                        tweenCamera.onUpdate = camera_updateCallback;
                        
                        startQuaternion = Quaternion.createFromMatrix(camera.transform);
                        endQuaternion = Quaternion.createFromMatrix(displayObject3d.transform);
                        
                        TweenMax.to(camera, TWEEN_TIME, tweenCamera);
                        TweenMax.to(camera.target, TWEEN_TIME, tweenTarget);
                }
                        
                private function camera_updateCallback():void
                {
                        currentQuaternion = Quaternion.slerp(startQuaternion, endQuaternion, camera.slerp);
                        camera.transform.copy3x3(currentQuaternion.matrix);
                }
                public function updateCamera(event:Event):void 
                {
                                                
                        if(gridview){
                                infoview = false
                                selectview = false
                                randomview = false
                                scrollBox = true
                                //gridview = false
                                //camera.z -= (camera.z - container.mouseX*4)/15;
                                //camera.y -= (camera.y - container.mouseY*4)/15;

                        }
                        if(infoview){
                                //InfoView = false
                                selectview = false
                                randomview = false
                                gridview = false
                                scrollBox = true
                                //camera.x -= (camera.x - container.mouseX/12)/20;
                                //camera.y -= (camera.y - container.mouseY/12)/20;

                        }
                        if(selectview){
                                infoview = false
                                //SelectView = false
                                randomview = false
                                gridview = false
                                scrollBox = true

                                //MoveHorizontal = container.mouseX/10
                                //MoveVertical = container.mouseY/20
                                //camera.moveLeft(MoveHorizontal);
                                //camera.moveUp(MoveVertical);
                        }
                        if (randomview){
                                infoview = false
                                selectview = false
                                //RandomView = false
                                gridview = false
                                /*
                                MoveHorizontal = container.mouseX/80
                                MoveVertical = container.mouseY/60
                                camera.moveLeft(MoveHorizontal);
                                if (camera.y > MaxCameraFree) {
                                        camera.moveUp(-MoveVertical);
                                        camera.y = MaxCameraFree
                                }
                                 if (camera.y < - MaxCameraFree) {
                                        camera.moveUp(-MoveVertical);
                                        camera.y = -MaxCameraFree
                                }
                                camera.moveUp(MoveVertical);
                                */
                        }
                        //scene.renderCamera( camera );
                        if(scrollBox){
                                sx += (ox-container.mouseX)*2;
                                ox = container.mouseX;
                                
                                sy += (oy-container.mouseY);
                                oy = container.mouseY;
                        } else {
                                sx += 10
                        }
                        
                        sx *= 0.94;
                        sy *= 0.94;
                        rotationY += sy/19000;
                        
                        if(rotationY > 0.6){
                                rotationY = 0.6-sy/19000;
                                sy *= -0.6;
                                
                        }else if( rotationY < -0.2){
                                rotationY = -0.2-sy/19000;
                                sy *= -0.6;
                        }
                        
                        if (infoview) {
                                orbit(camera, target_null, "x", sx/100000);
                                orbit(camera, target_null, "y", sy/100000);
                        } else {
                                orbit(camera, target_null, "x", sx/19000);
                                orbit(camera, target_null, "y", sy/19000);
                        }                       
                        
                        //var Boxes :DisplayObject3D;
                        //for (var i:Number = 0; Boxes = scene.getChildByName( "Album" + i ); i++) 
                        //{
                        shadowCaster.invalidate();
                        shadowCaster.castModel(main.managerbox.cubes, l, main.floor.plane, true, true);
                                
                                //shadowCaster.castModel(scene.getChildByName( "Album1" ), l, main.floor.plane, true, false);
                                //shadowCaster.castModel(scene.getChildByName( "Album2" ), l, main.floor.plane, true, false);
                        //}
                        renderer.renderScene(scene, camera, viewport);
                }
                
        }
        
}
import org.papervision3d.cameras.Camera3D;
class CameraWithSlerp extends Camera3D
{
        public var slerp:Number = 0;
}