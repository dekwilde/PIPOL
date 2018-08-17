package
{
	import caurina.transitions.Tweener;
	
	import flash.display.*;
	import flash.events.*;
	import flash.filters.DropShadowFilter;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.text.*;
	
	import screen.*;

	public class Descricao extends MovieClip
	{
		public var main:Main;
		private var tracker:Tracker = new Tracker()
		
		private var sizeWidth:uint    = 800;
        private var sizeHeigth:uint = 500
		private var bgColor:uint      = 0xffffff;
        private var borderColor:uint  = 0xFF0000;
        private var borderSize:uint   = 1;
        private var cornerRadius:uint = 25;
        private var gutter:uint       = 5;
		private var content:MovieClip = new MovieClip();
		public var ImgTarget:MovieClip = new MovieClip();
		
		private var Close:CloseButton = new CloseButton()
		private var mc_link:GoLinkMaterial = new GoLinkMaterial;
		private var bt_scroll_1:BtScrollUp = new BtScrollUp();
		private var bt_scroll_2:BtScrollDown = new BtScrollDown();
	
		public var TituloProjeto:TextField;
		public var SubTitulo:TextField
		public var Nome:TextField;
		public var Email:TextField;
		public var Info:TextField;
		
		private var FormatTitle:TextFormat
		private var FormatSubTitle:TextFormat
		private var FormatName:TextFormat
		private var FormatEmail:TextFormat
		private var FormatInfo:TextFormat
		
		private var shadow:DropShadowFilter = new DropShadowFilter(2, 45, 0x000000, 0.7, 7, 7, 0.6, 1)
		
		public function Descricao()
		{
            init();
			this.alpha = 0.0
		}
		private function init():void
		{
			createContent();
			createTextFormat()
			createTitle();
			createSubTitle()
			createName();
			createEmail();
			createScroll()
			createInfo();
			createImg();
			createLink();
			createClose();
		}
		public function showALL(BoxNumber:Number):void
		{
			TituloProjeto.text = main.creatgallery.xml.projeto[BoxNumber].titulo + "\n\n";
			SubTitulo.text = main.creatgallery.xml.projeto[BoxNumber].subtitulo;
			Nome.text = main.creatgallery.xml.projeto[BoxNumber].nome;
			Email.text = main.creatgallery.xml.projeto[BoxNumber].email;
			Info.text = main.creatgallery.xml.projeto[BoxNumber].desc;
			main.creatgallery.loader.load(new URLRequest(main.creatgallery.xml.projeto[BoxNumber].large));
			ImgTarget.addChild(main.creatgallery.loader);
			Position();
			FadeIN()
		}
		private function createTextFormat():void
		{
			FormatTitle = new TextFormat()
			FormatTitle.color = 0x000000
			FormatTitle.size = 24
			FormatTitle.font = "Arial Black"
			FormatTitle.letterSpacing = -2
			FormatTitle.leading = -10
			
			FormatSubTitle = new TextFormat()
			FormatSubTitle.color = 0x222222
			FormatSubTitle.size = 24
			FormatSubTitle.font = "Arial"
			FormatSubTitle.leading = -1.5
			
			
			FormatName = new TextFormat()
			FormatName.color = 0x000000
			FormatName.size = 14
			FormatName.font = "Arial"
			//FormatName.leading = -1.5
			
			FormatEmail = new TextFormat()
			FormatEmail.color = 0xcc0000
			FormatEmail.size = 16
			FormatEmail.font = "Arial"
			//FormatEmail.leading = -1.5
			
			FormatInfo = new TextFormat()
			FormatInfo.color = 0x000000
			FormatInfo.size = 12
			FormatInfo.font = "Arial"
			FormatInfo.leading = 3
			FormatInfo.leftMargin = 3
			FormatInfo.rightMargin = 3
			FormatInfo.align = TextFormatAlign.JUSTIFY;
			
			
		}
		private function createContent():void
		{
			content.graphics.beginFill(bgColor, 0.3);
            //content.graphics.lineStyle(borderSize, borderColor,0.2);
            content.graphics.drawRoundRect(0, 0, sizeWidth, sizeHeigth, cornerRadius);
            content.graphics.endFill(); 
            addChild(content);    
		}
		private function createTitle():void
		{
			TituloProjeto = new TextField();
			//TituloProjeto.height = 80
			TituloProjeto.blendMode = "layer"
			TituloProjeto.embedFonts = true
			TituloProjeto.selectable = false
			TituloProjeto.multiline = true
			TituloProjeto.wordWrap = true
			TituloProjeto.autoSize = TextFieldAutoSize.LEFT
			TituloProjeto.antiAliasType = AntiAliasType.ADVANCED
			TituloProjeto.defaultTextFormat = FormatTitle;
			addChild(TituloProjeto)			
		}
		private function createSubTitle():void
		{
			SubTitulo = new TextField();
			SubTitulo.blendMode = "layer"
			SubTitulo.embedFonts = true
			SubTitulo.selectable = false
			SubTitulo.multiline = true
			SubTitulo.wordWrap = true
			SubTitulo.autoSize = TextFieldAutoSize.LEFT;
			SubTitulo.antiAliasType = AntiAliasType.ADVANCED
			SubTitulo.defaultTextFormat = FormatSubTitle;
			addChild(SubTitulo)			
		}
		private function createName():void
		{
			Nome = new TextField();
			Nome.blendMode = "layer"
			Nome.embedFonts = true
			Nome.selectable = false
			Nome.multiline = true
			Nome.wordWrap = true
			Nome.autoSize = TextFieldAutoSize.LEFT;
			Nome.antiAliasType = AntiAliasType.ADVANCED
			Nome.defaultTextFormat = FormatName;
			addChild(Nome)	
		}
		private function createEmail():void
		{
			Email = new TextField();
			Email.blendMode = "layer"
			//Email.selectable = false
			//Email.mouseEnabled = false
			//Email.selectable = false
			Email.embedFonts = true
			Email.autoSize = TextFieldAutoSize.LEFT;
			Email.antiAliasType = AntiAliasType.ADVANCED
			Email.defaultTextFormat = FormatEmail;
			addChild(Email)
			Email.addEventListener(MouseEvent.CLICK, MailTo)
			Email.addEventListener(MouseEvent.MOUSE_OVER, GoLinkOver)
			Email.addEventListener(MouseEvent.MOUSE_OUT, GoLinkOut)
		}
		private function createInfo():void
		{
			Info = new TextField();
			Info.blendMode = "layer"
			Info.embedFonts = true
			Info.selectable = false
			Info.multiline = true
			Info.wordWrap = true
			Info.background = true
			Info.backgroundColor = 0xf8f8f8
			Info.antiAliasType = AntiAliasType.ADVANCED
			//Info.border = true
			//Info.borderColor = 0xc0c0c0
			//Info.autoSize = TextFieldAutoSize.LEFT;
			Info.defaultTextFormat = FormatInfo;
			
			Info.filters = [shadow]
			addChild(Info)
				
		}
		private function createScroll():void {
			bt_scroll_1.filters = [shadow]
			bt_scroll_2.filters = [shadow]
			addChild(bt_scroll_1)
			addChild(bt_scroll_2)
			bt_scroll_1.addEventListener(MouseEvent.MOUSE_DOWN, scrollUp)
			bt_scroll_2.addEventListener(MouseEvent.MOUSE_DOWN, scrollDown)
		}
		private function createLink():void
		{
			mc_link.filters = [shadow]
			addChild(mc_link)
			mc_link.addEventListener(MouseEvent.MOUSE_OVER,GoLinkOver);
			mc_link.addEventListener(MouseEvent.MOUSE_OUT,GoLinkOut);
			mc_link.addEventListener(MouseEvent.MOUSE_DOWN,GoLinkPress);
		}
		private function createClose():void
		{
			addChild(Close)
			Close.addEventListener(MouseEvent.MOUSE_OVER,CloseOver);
			Close.addEventListener(MouseEvent.MOUSE_OUT,CloseOut);
			Close.addEventListener(MouseEvent.MOUSE_DOWN,ClosePress);
		}
		private function createImg():void
		{
			ImgTarget.filters = [shadow]
			ImgTarget.graphics.beginFill(0x000000);
            //ImgTarget.graphics.lineStyle(borderSize, borderColor);
            ImgTarget.graphics.drawRect(0, 0, 240, 240);
            ImgTarget.graphics.endFill();
            addChild(ImgTarget);  

			
		}
		public function Position():void
		{
			var Linhamento:Number = 25
			
			TituloProjeto.width = 460
			TituloProjeto.x = Linhamento;
			TituloProjeto.y = 30;
			
			SubTitulo.width = 460
			SubTitulo.x = Linhamento;
			SubTitulo.y = TituloProjeto.height + 10
		
			Nome.width = 460
			Nome.x = Linhamento
			Nome.y = SubTitulo.y + SubTitulo.height + 10
			
			mc_link.x = Linhamento
			mc_link.y = Nome.y + Nome.height + 10
			
			Email.width = 460
			Email.height = 30
			
			Email.x = Linhamento
			Email.y = 255
			
			ImgTarget.x = 520;
            ImgTarget.y = 30;
			
			Info.width = 710
			Info.height = 160
			Info.x = Linhamento
			Info.y = 285
			
			bt_scroll_1.x = Info.width + 30
			bt_scroll_1.y = Info.y
			bt_scroll_2.x = Info.width + 30
			bt_scroll_2.y = Info.y + Info.height - bt_scroll_2.height
			

			
			Close.x = content.width - 16
			Close.y = 14
		}
		public function FadeIN():void 
		{
			//Tweener.addTween(Info, {z:WorldPosition - 50, time:1.0, transition:"linear"})
			Tweener.addTween(this, {alpha:1.0, 
											time:1.0, 
											transition:"linear"})
		}
		public function FadeOUT():void
		{
			Tweener.addTween(this, {alpha:0.0, 
											time:0.5, 
											transition:"linear",
											onComplete: function():void{ Destroy() } 		
									})
		}
		//
		private function scrollUp(e:MouseEvent):void 
		{
			Info.scrollV -= 1
		}
		private function scrollDown(e:MouseEvent):void
		{
			Info.scrollV += 1
		}
		
		private function ClosePress(e:MouseEvent):void
		{
			Dispose()
		}
		private function CloseOver(e:MouseEvent):void
		{
			main.navegador.BackToClose()

		}
		private function CloseOut(e:MouseEvent):void
		{
			main.navegador.FadeOUT()
		}
		//
		private function GoLinkPress(e:MouseEvent):void
		{
			main.buttonMode = true;
			var url:String= main.creatgallery.xml.projeto[main.managerbox.BoxNumber].link;
			var targetURL:URLRequest = new URLRequest(url);
    		navigateToURL(targetURL, "_blank");
    		//
    		main.stage.addChild(main.linkback);
    		main.linkback.Enable();
    		tracker.track("gourl" + main.managerbox.BoxNumber)
		}
		private function MailTo(e:MouseEvent):void {
			main.buttonMode = true;
			var url:String= main.creatgallery.xml.projeto[main.managerbox.BoxNumber].email;
			
			var targetURL:URLRequest = new URLRequest("mailto:" + url);
    		navigateToURL(targetURL);
    		//
    		main.stage.addChild(main.linkback);
    		main.linkback.Enable();
		}
		private function GoLinkOver(e:MouseEvent):void
		{
			main.buttonMode = true;
		}
		private function GoLinkOut(e:MouseEvent):void
		{
			main.buttonMode = false;
		}
		//
		public function Dispose():void
		{
			main.managerbox.BoxesEnable()
			main.openbox.ClosePlacas();
			main.tituloprojeto.FadeOUT();
			main.navegador.FadeOUT();
			main.bg.showBack();
			main.manager_scene.CameraBack();
			FadeOUT();
		}
		private function Destroy():void
		{
			main.removeChild(this)	
		}
		//
	}
}