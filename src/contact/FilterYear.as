package contact

{

        import caurina.transitions.Tweener;
        
        import flash.display.*;
        import flash.events.*;
        import flash.net.*;
        import flash.text.*;
        import flash.external.ExternalInterface;
        
        import screen.CloseButton;
        
        public class FilterYear extends MovieClip

        {

                public var main:Main

                

                private var language:Language = new Language()

                private var colors:Colors = new Colors();
                
                private var content:MovieClip = new MovieClip();

                private var Close:CloseButton = new CloseButton();

                private var YearTitle:TextField = new TextField()

                private var Year:TextField = new TextField();

                

                private var Submit:MovieClip = new MovieClip();

                private var SubmitText:TextField = new TextField();

                private var ErrorText:TextField = new TextField();

                private var FormatText:TextFormat = new TextFormat()

                private var Borda:Number = 5

                private var SpaceTitle:Number = 20
                
                private var uploadURL:URLRequest = new URLRequest("reader.php");
				private var variables:URLVariables = new URLVariables();
				private var CL:URLLoader = new URLLoader();

                

                public function FilterYear()

                {

                        init()

                        this.alpha = 0.0

                        

                }

                private function init():void

                {

                        createTextFormat();

                        createContent();

                        createYear();

                        createSubmit();

                        createLogError();

                        createClose()

                        Position();                     

                }

                // INTERFACE

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

                        tf.autoSize = TextFieldAutoSize.LEFT;
                        tf.antiAliasType = AntiAliasType.ADVANCED

                        tf.blendMode = "layer"

                        tf.defaultTextFormat = FormatText;

                        addChild(tf)

                }

                private function FormatInput(tf:TextField):void

                {

                        tf.embedFonts = true
                        tf.blendMode = "layer"

                        tf.background = true

                        tf.backgroundColor = 0x000000
                        tf.border = true
                        tf.borderColor = 0xcc0000

                        tf.type = TextFieldType.INPUT;
                        tf.antiAliasType = AntiAliasType.ADVANCED

                        //Pass.autoSize = TextFieldAutoSize.LEFT;

                        //tf.displayAsPassword = true

                        tf.defaultTextFormat = FormatText;

                        addChild(tf)

                }

                private function createContent():void
                {

                	content.graphics.beginFill(0x00000, 0.85);

            		content.graphics.lineStyle(1, 0xcc0000);

            		content.graphics.drawRoundRect(0, 0, 300, 200, 15, 15);

            		content.graphics.endFill(); 

            		addChild(content);

                }

                private function createYear():void

                {

                        FormatTitle(YearTitle)

                        YearTitle.text = language.FilterYearName

                        FormatInput(Year)

                }

                

                private function createSubmit():void

                {
						SubmitText.embedFonts = true
                        SubmitText.selectable = false

                        SubmitText.mouseEnabled = false

                        SubmitText.blendMode = "layer"

                        SubmitText.autoSize = TextFieldAutoSize.RIGHT;
                        SubmitText.antiAliasType = AntiAliasType.ADVANCED

                        SubmitText.defaultTextFormat = FormatText;

                        SubmitText.text = language.FilterYearSearch

                        

                        Submit.graphics.beginFill(colors.ButtonSubmit, 1);
            			Submit.graphics.lineStyle(1, 0xcc0000);
            			Submit.graphics.drawRect(0, 0, SubmitText.width+Borda, SubmitText.height+Borda);
			            Submit.graphics.endFill(); 
                       
                        addChild(Submit);
                        addChild(SubmitText)
                        
                        Submit.addEventListener(MouseEvent.MOUSE_DOWN, Send);
                        Submit.addEventListener(MouseEvent.MOUSE_OVER, Over);
                        Submit.addEventListener(MouseEvent.MOUSE_OUT, Out)

                }

                private function createLogError():void

                {

                        ErrorText.selectable = false

                        ErrorText.mouseEnabled = false

                        ErrorText.width = 300

                        ErrorText.wordWrap = true

                        ErrorText.multiline = true

                        ErrorText.autoSize = TextFieldAutoSize.LEFT

                        ErrorText.blendMode = "layer"

                        ErrorText.defaultTextFormat = FormatText;

                        addChild(ErrorText)

                }

                private function createClose():void

                {

            			addChild(Close);

                        Close.addEventListener(MouseEvent.MOUSE_DOWN, Hide);

                }

                private function Hide(event:MouseEvent):void

                {

                        main.manager_filter_year.CloseAdmin();

                }

                private function Position():void

                {

                        
                        var putWidth:Number = 150

                        Year.width = putWidth

                        Year.height = 20

                        Year.x = content.width/2 - Year.width/2

                        Year.y = 40 + SpaceTitle

                        

                        YearTitle.x = Year.x

                        YearTitle.y = 20 + SpaceTitle




                        

                        SubmitText.x = Year.x + Year.width - SubmitText.width - Borda

                        SubmitText.y =  Year.y + Year.height + SpaceTitle

                        Submit.x = SubmitText.x + SubmitText.width/2 - Submit.width/2

                        Submit.y = SubmitText.y + SubmitText.height/2 - Submit.height/2

                        

                        Close.x = content.width - 16

                        Close.y = 14

                        ErrorText.x = Borda*5

                        ErrorText.y = content.height - 40

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

                public function FadeOUT(e:Event = null):void

                {

                        Tweener.addTween(this, {alpha:0.0,

                                                                        time:0.6,

                                                                        transition:"linear",

                                                                        onComplete: function():void{ Destroy() }

                                                                    })

                }

                private function Destroy():void

                {

                        Year.text = ""

                        ErrorText.text = ""

                        //main.stage.removeChild(this)

                        main.manager_filter_year.HideFilterYear()

                }

                private function Send(event:MouseEvent):void
                {
					if (Year.text == "")
					{
						ErrorText.text = language.UserError2
					}
					else
					{
						/*
						ErrorText.text = language.FilterYearSubmit			
				
						variables.dataFormat = URLLoaderDataFormat.TEXT
						variables.year = Year.text;			
						uploadURL.method = URLRequestMethod.POST;
			
						uploadURL.data = variables;		
						CL.load(uploadURL);
						CL.addEventListener(Event.COMPLETE, FadeOUT);
						*/
						//main.creatgallery.Reset();
						//ExternalInterface.call("console.log", Year.text);
						main.managerbox.BoxesFilter(Year.text);
						
						FadeOUT();
						
                	}
                }


        }

}