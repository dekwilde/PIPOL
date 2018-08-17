package {
	
	
	import flash.display.*;
	
	import screen.*;
	
	[SWF(width="1024", height="500", frameRate="20", backgroundColor="#121315")]
	public class Main extends Sprite 
	{
		//public var localHost:String = ""
		public var WordPosition:Number = -3000
		
		//ASSETS
		private var tracker:Tracker = new Tracker()
		public var arial:Arial
		public var arialblack:ArialBlack
		public var floor:Floor = new Floor();
		public var manager_positions:ManagerPositions = new ManagerPositions();
		public var creatgallery:CreatGallery = new CreatGallery();
		public var manager_scene:ManagerScene = new ManagerScene();
		public var manager_admin:ManagerAdmin = new ManagerAdmin();
		public var manager_contact:ManagerContact = new ManagerContact()
		public var manager_filter_year:ManagerFilterYear = new ManagerFilterYear()
		public var managerbox:ManagerBoxes = new ManagerBoxes();	
		
		public var tituloprojeto:TitleProject = new TitleProject();
		public var titlesite:TitleSite = new TitleSite();
		public var navegador:Navegador = new Navegador();
		public var ifull:Fullscreen = new Fullscreen();
		public var bg:Back = new Back();
		public var openbox:OpenBox = new OpenBox();
		public var descricao:Descricao = new Descricao();
		public var placamaterial:PlacaMaterial = new PlacaMaterial();
		public var linkback:LinkBack = new LinkBack();
		public var composition:Composition = new Composition();
		public var publish_bt:PublishButton = new PublishButton();
		public var bt_contact:BtContact = new BtContact();
		public var bt_filter_year:BtFilterYear = new BtFilterYear();

		public function Main() {
			trace("hello world 04")
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			stage.quality = StageQuality.BEST;
			 
			floor.main = this
			tituloprojeto.main = this;
			navegador.main = this;
			ifull.main = this;
			bg.main = this

			//floor.main = this
			manager_positions.main = this
			creatgallery.main = this;
			manager_scene.main = this;
			manager_admin.main = this;
			manager_contact.main = this;
			manager_filter_year.main = this;
			managerbox.main = this;
			openbox.main = this;
			descricao.main = this;
			placamaterial.main = this;
			linkback.main = this;
			composition.main = this;
			publish_bt.main = this;
			bt_contact.main = this;
			bt_filter_year.main = this;
			init();
			
		}
		protected function init():void {
			manager_scene.init();
			creatObjects();
			creatgallery.init();
			manager_positions.init();
		}
	
		private function creatObjects():void
		{
			
			stage.addChild(ifull);
			stage.addChild(navegador);
			stage.addChild(titlesite)
			stage.addChild(tituloprojeto);
			stage.addChild(composition);
			stage.addChild(publish_bt);
			stage.addChild(bt_contact);
			stage.addChild(bt_filter_year);
			manager_scene.container.addChild(bg);
			manager_scene.scene.addChild(floor.plane)
			//manager_scene.scene.addChild(floor.blocos)
			//manager_scene.scene.addChild(floor.bloco1)
			//manager_scene.scene.addChild(floor.bloco2)
			tracker.track("home")
		}		
	}
}