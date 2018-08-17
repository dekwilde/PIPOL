package admin
{
	import caurina.transitions.Tweener;
	
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.net.FileFilter;
	import flash.net.FileReference;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	import flash.text.*;
	
	import screen.*;
		
	public class UserPublish extends MovieClip
	{		
		public var main:Main
		private var language:Language = new Language()
		private var hexacolor:Colors = new Colors()
		
		private var content:MovieClip = new MovieClip();
		private var Close:CloseButton = new CloseButton()
		
		private var TitleTitle:TextField = new TextField()
		private var Title:TextField = new TextField();
		
		private var SubTitleTitle:TextField = new TextField()
		private var SubTitle:TextField = new TextField();
		
		private var YearTitle:TextField = new TextField()
		private var Year:TextField = new TextField();
		
		private var NameTitle:TextField = new TextField()
		private var Name:TextField = new TextField();
	
		private var EmailTitle:TextField = new TextField()
		private var Email:TextField = new TextField();
		
		private var InfoTitle:TextField = new TextField()
		private var Info:TextField = new TextField();
		
		private var UrlTitle:TextField = new TextField()
		private var Url:TextField = new TextField();
		
		private var FotoTitle:TextField = new TextField()
		private var Foto:TextField = new TextField();
				
		private var LoginTitle:TextField = new TextField()
		private var Login:TextField = new TextField();
		
		private var PassTitle:TextField = new TextField();
		private var Pass:TextField = new TextField();
		
		private var Submit:MovieClip = new MovieClip();
		private var SubmitText:TextField = new TextField();
		
		private var Browser:MovieClip = new MovieClip();
		private var BrowserText:TextField = new TextField();
		
		
		
		private var ErrorText:TextField = new TextField();
		
		private var FormatText:TextFormat = new TextFormat()
		
		private var Borda:Number = 5
		private var SpaceAlign:Number = 20
		private var SpaceLead:Number = 20
		private var TamanhoCaixas:Number = 450
		private var PositionAlign:Number = 50
		
		private var xml:XML;
		private var loader:Loader;
		private var uploadURL:URLRequest = new URLRequest("cadastro.php");
		private var returnURL:URLRequest = new URLRequest("admin.txt");
		private var variables:URLVariables = new URLVariables();
		private var CL:URLLoader = new URLLoader();
        private var foto:FileReference = new FileReference();
		
		private var maxFileSize:Number = 500 //tamanho em kb;
		private var fileSize:Number 
        
		
		public function UserPublish()
		{
			//Security.allowDomain("*");
			this.alpha = 0.0
			init()
		}
		private function init():void
		{
			createTextFormat();
			createContent();
			createSubmit();
			createLogError()
			createClose()
			createBrowser();
			
			createForm()
			Position()
		}
		private function createTextFormat():void
		{
			FormatText.color = 0xffffff
			FormatText.size = 12
			FormatText.font = "Arial"
			FormatText.align = "left"
			FormatText.leading = 0.5
		}
		private function FormatTitle(tf:TextField):void
		{
			tf.embedFonts = true
			tf.selectable = false
			tf.mouseEnabled = false
			tf.autoSize = TextFieldAutoSize.LEFT
			tf.antiAliasType = AntiAliasType.ADVANCED
			tf.blendMode = "layer"
			tf.height = 20
			tf.defaultTextFormat = FormatText;
			addChild(tf)
		}
		private function FormatInput(tf:TextField):void
		{
			tf.blendMode = "layer"
			tf.embedFonts = true
			tf.background = true
			tf.backgroundColor = 0x000000
			tf.border = true
			tf.borderColor = 0xcc0000
			tf.height = 20
			tf.type = TextFieldType.INPUT;
			tf.antiAliasType = AntiAliasType.ADVANCED
			//Pass.autoSize = TextFieldAutoSize.LEFT;
			//tf.displayAsPassword = true
			tf.defaultTextFormat = FormatText;
			addChild(tf)
		}
		private function createForm():void
		{
			FormatTitle(TitleTitle)
			TitleTitle.text = language.UserTitle
			FormatInput(Title)
			//
			FormatTitle(SubTitleTitle)
			SubTitleTitle.text = language.UserSubTitle
			FormatInput(SubTitle)
			SubTitle.multiline = true
			SubTitle.wordWrap = true
			//
			FormatTitle(YearTitle)
			YearTitle.text = language.UserYear
			FormatInput(Year)
			//
			FormatTitle(FotoTitle)
			FotoTitle.text = language.UserFoto
			FormatInput(Foto)
			
			//
			FormatTitle(NameTitle)
			NameTitle.text = language.UserName
			FormatInput(Name)
			//
			FormatTitle(EmailTitle)
			EmailTitle.text = language.UserEmail
			FormatInput(Email)
			//
			FormatTitle(InfoTitle)
			InfoTitle.text = language.UserInfo
			FormatInput(Info)
			Info.multiline = true
			Info.wordWrap = true
			//
			FormatTitle(UrlTitle)
			UrlTitle.text = language.UserUrl
			FormatInput(Url)
			Url.text = "http://"
			//
			FormatTitle(LoginTitle)
			LoginTitle.text = language.UserLogin
			FormatInput(Login)
			//
			FormatTitle(PassTitle)
			Pass.displayAsPassword = true
			PassTitle.text = language.UserPass
			FormatInput(Pass)
		}
		private function Position():void
		{
			
			TitleTitle.x = PositionAlign
			TitleTitle.y = SpaceLead*1 + SpaceAlign
			Title.x = TitleTitle.x
			Title.y = SpaceLead*2 + SpaceAlign
			Title.width = 450
			

			
			SubTitleTitle.x = PositionAlign
			SubTitleTitle.y = SpaceLead*3 + SpaceAlign
			SubTitle.x = SubTitleTitle.x
			SubTitle.y = SpaceLead*4 + SpaceAlign
			SubTitle.width = TamanhoCaixas
			SubTitle.height = 40
			
			
			YearTitle.x = PositionAlign
			YearTitle.y = SpaceLead*7 + SpaceAlign
			Year.x = YearTitle.x + YearTitle.width + 5
			Year.y = YearTitle.y
			Year.width = 40
				
			FotoTitle.x = PositionAlign
			FotoTitle.y = SpaceLead*9 + SpaceAlign
			Foto.x = FotoTitle.x + FotoTitle.width + 5
			Foto.y = FotoTitle.y
			Foto.width = 200
			
			BrowserText.x = Foto.x + Foto.width + 15
			BrowserText.y = SpaceLead*9 + SpaceAlign
			
			Browser.x = BrowserText.x + BrowserText.width/2 - Browser.width/2
			Browser.y = BrowserText.y + BrowserText.height/2 - Browser.height/2
			
			
			NameTitle.x = PositionAlign
			NameTitle.y = SpaceLead*11 + SpaceAlign
			Name.x = NameTitle.x
			Name.y = SpaceLead*12 + SpaceAlign
			Name.width = TamanhoCaixas
			
			EmailTitle.x = PositionAlign
			EmailTitle.y = SpaceLead*14 + SpaceAlign
			Email.x = EmailTitle.x + EmailTitle.width + 5
			Email.y = EmailTitle.y
			Email.width = TamanhoCaixas - EmailTitle.width - 5
			
			InfoTitle.x = PositionAlign
			InfoTitle.y = SpaceLead*16 + SpaceAlign
			Info.x = InfoTitle.x
			Info.y = SpaceLead*17 + SpaceAlign
			Info.width = TamanhoCaixas
			Info.height = 100
			
			UrlTitle.x = PositionAlign
			UrlTitle.y = SpaceLead*22 + SpaceAlign
			Url.x = UrlTitle.x
			Url.y = SpaceLead*23 + SpaceAlign
			Url.width = TamanhoCaixas
			
		
						
			LoginTitle.x = PositionAlign
			LoginTitle.y = SpaceLead*24 + SpaceAlign
			Login.x = LoginTitle.x
			Login.y = SpaceLead*25 + SpaceAlign
			Login.width = 200
			
			PassTitle.x = PositionAlign
			PassTitle.y = SpaceLead*26 + SpaceAlign
			Pass.x = PassTitle.x
			Pass.y = SpaceLead*27 + SpaceAlign
			Pass.width = 200
			
			
			SubmitText.x = Pass.x + TamanhoCaixas - SubmitText.width - Borda
			SubmitText.y = SpaceLead*29 + SpaceAlign
			Submit.x = SubmitText.x + SubmitText.width/2 - Submit.width/2
			Submit.y = SubmitText.y + SubmitText.height/2 - Submit.height/2
			
			Close.x = content.width - 12 
			Close.y = 12
			
			ErrorText.x = LoginTitle.x + Login.width + 30
			ErrorText.y = LoginTitle.y + SpaceAlign
			ErrorText.width = 200
			ErrorText.height = 40
		}
		private function createContent():void
		{
			content.graphics.beginFill(0x00000, 0.8);
            content.graphics.lineStyle(1, 0xcc0000);
            content.graphics.drawRoundRect(0, 0, 550, SpaceLead*32, 15, 15);
            content.graphics.endFill(); 
            addChild(content);
		}
		private function createClose():void
		{
            addChild(Close);
			Close.addEventListener(MouseEvent.MOUSE_DOWN, Hide);
		}
		private function createSubmit():void
		{
			SubmitText.selectable = false
			SubmitText.mouseEnabled = false
			SubmitText.blendMode = "layer"
			SubmitText.autoSize = TextFieldAutoSize.RIGHT;
			SubmitText.defaultTextFormat = FormatText;

			SubmitText.text = language.UserSubmit
			
			Submit.graphics.beginFill(hexacolor.ButtonSubmit, 1);
            Submit.graphics.lineStyle(1, 0xcc0000);
            Submit.graphics.drawRect(0, 0, SubmitText.width+Borda, SubmitText.height+Borda);
            Submit.graphics.endFill(); 
			
			addChild(Submit);
			addChild(SubmitText)
			
			Submit.addEventListener(MouseEvent.MOUSE_DOWN, Send);
			Submit.addEventListener(MouseEvent.MOUSE_OVER, Over);
			Submit.addEventListener(MouseEvent.MOUSE_OUT, Out)
		}
		private function createBrowser():void
		{
			BrowserText.selectable = false
			BrowserText.mouseEnabled = false
			BrowserText.blendMode = "layer"
			BrowserText.autoSize = TextFieldAutoSize.RIGHT;
			BrowserText.defaultTextFormat = FormatText;

			BrowserText.text = language.UserBrowser
			
			Browser.graphics.beginFill(hexacolor.ButtonBrowser, 1);
            Browser.graphics.lineStyle(1, 0xcc0000);
            Browser.graphics.drawRect(0, 0, BrowserText.width+Borda, BrowserText.height+Borda);
            Browser.graphics.endFill(); 
			
			addChild(Browser);
			addChild(BrowserText)
			
			Browser.addEventListener(MouseEvent.MOUSE_DOWN, Search);
			Browser.addEventListener(MouseEvent.MOUSE_OVER, Over);
			Browser.addEventListener(MouseEvent.MOUSE_OUT, Out)
		}
		private function createLogError():void
		{
			ErrorText.selectable = false
			ErrorText.mouseEnabled = false
			ErrorText.wordWrap = true
			ErrorText.multiline = true
			ErrorText.autoSize = TextFieldAutoSize.LEFT
			ErrorText.blendMode = "layer"
			ErrorText.defaultTextFormat = FormatText;
			addChild(ErrorText)
			ErrorText.text = language.UserError1
		}

		
				
		// FUNCTIONS
		private function Hide(event:MouseEvent):void
		{
			main.manager_admin.CloseAdmin();
		}
		private function Over(event:MouseEvent):void
		{
			buttonMode = true;
		}
		private function Out(event:MouseEvent):void
		{
			buttonMode = false;
		}
		
		public function FadeIN():void
		{
			Tweener.addTween(this, {alpha:1.0,
									time:0.6,
									transition:"linear"
								    })
		}
		public function FadeOUT(event:MouseEvent=null):void
		{
			Tweener.addTween(this, {alpha:0.0,
									time:0.6,
									transition:"linear",
									onComplete: function():void{ Destroy() }
								    })
		}
		
		// back end
		
		private function Send(event:MouseEvent):void 
		{
			//uploadURL.url = "upload.php";
			if (foto == null ||
				Title.text == "" ||
				SubTitle.text == "" ||
				Year.text == "" ||
				Foto.text == "" ||
				Foto.text == "<ERROR><ERROR><ERROR><ERROR><ERROR>" ||
			 	Name.text == "" ||
				Email.text == "" ||
				Info.text == "" ||
				Url.text == "" ||
				Login.text == "" ||
				Pass.text == "")
			{
				ErrorText.text = language.UserError2
			}
			else
			{
				ErrorText.text = language.UserError4			
				
				variables.titulo = Title.text;
				variables.subtitulo = SubTitle.text;
				variables.ano = Year.text;
				//variables.foto = foto;
				variables.nome = Name.text;
				variables.email = Email.text;
				variables.descricao = Info.text;
				variables.link = Url.text;
				variables.username = Login.text;
				variables.pass = Pass.text;
				
				uploadURL.method = URLRequestMethod.POST;
			
				uploadURL.data = variables;

				foto.addEventListener(IOErrorEvent.IO_ERROR, SendError);
	            foto.addEventListener(Event.COMPLETE, Check);
				//foto.addEventListener(ProgressEvent.PROGRESS, UploadProgress);
                //foto.addEventListener(SecurityErrorEvent.SECURITY_ERROR, SendError);
                				
				foto.upload( uploadURL );	
			}
			

		}
		
		private function Search(event:MouseEvent):void 
		{
			var imagesFilter:FileFilter = new FileFilter("Images (*.jpg;)","*.jpg");
            foto.browse([imagesFilter])
            foto.addEventListener(Event.SELECT, selectHandler);       
			
        }

        private function selectHandler(event:Event):void {
            var fileselect:FileReference = FileReference(event.target); 
			fileSize = Math.round( fileselect.size/1024 );
			if ( fileSize <= maxFileSize )
			{
				Foto.text = fileselect.name
				//ErrorText.text = ""	
			} else {
				Foto.text = "<ERROR><ERROR><ERROR><ERROR><ERROR>"
				ErrorText.text = language.UserError3 + String(maxFileSize) + " kb"
				//Alert.show( String("File is to large! \n\nPlease select a file smaller than "+ maxFileSize + "kb" ), "File Size Error", Alert.OK );
			}			
			foto.load()
			foto.addEventListener(Event.COMPLETE, completeHandler);
        }
        private function completeHandler(event:Event):void {
        	var mc_loader:Loader = new Loader()
        	mc_loader.loadBytes(foto.data);
        	mc_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, FileWidth)
			
        }
		private function FileWidth(e:Event):void {
			if (e.target.content.width != e.target.content.height) {
				Foto.text = "<ERROR><ERROR><ERROR><ERROR><ERROR>"
				ErrorText.text = language.UserError5
			}
		}
		
        private function SendError(event:IOErrorEvent):void {
            ErrorText.text = "Error"
        }
        private function UploadProgress(e:Event):void 
		{
			//e.target.dataFormat= URLLoaderDataFormat.VARIABLES;
			//ErrorText.text = e.target.data
		}
		private function Check(e:Event):void 
		{
			CL.dataFormat= URLLoaderDataFormat.VARIABLES;
			CL.addEventListener(Event.COMPLETE, Completed);
			CL.load(returnURL);
        }

		private function Completed(e:Event):void 
		{
				Sucess();
				ErrorText.text = ""
				Title.text = ""
				SubTitle.text = ""
				Year.text = ""
				Foto.text = ""
				Name.text = ""
				Email.text = ""
				Info.text = ""
				Url.text = ""
				Login.text = ""
				Pass.text = ""
		}
		private function Sucess():void
		{
			main.manager_admin.OpenUserSucess();
		}
		private function Destroy():void
		{
			main.manager_admin.CloseUserPublish()
		}
		
	}
}