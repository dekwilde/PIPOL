package contact

{

        import caurina.transitions.Tweener;
        
        import flash.display.*;
        import flash.events.*;
        import flash.net.*;
        import flash.text.*;
        
        import screen.CloseButton;
        
        public class Contact extends MovieClip

        {

                public var main:Main

                

                private var language:Language = new Language()

                private var colors:Colors = new Colors();
                
                private var content:MovieClip = new MovieClip();

                private var Close:CloseButton = new CloseButton();

                private var NameTitle:TextField = new TextField()

                private var Name:TextField = new TextField();

                private var MailTitle:TextField = new TextField();

                private var Mail:TextField = new TextField();

                private var MessageTitle:TextField = new TextField();

                private var Message:TextField = new TextField();

                

                private var Submit:MovieClip = new MovieClip();

                private var SubmitText:TextField = new TextField();

                private var ErrorText:TextField = new TextField();

                private var FormatText:TextFormat = new TextFormat()

                private var Borda:Number = 5

                private var SpaceTitle:Number = 20
                
                private var uploadURL:URLRequest = new URLRequest("contato.php");
				private var variables:URLVariables = new URLVariables();
				private var CL:URLLoader = new URLLoader();

                

                

                public function Contact()

                {

                        init()

                        this.alpha = 0.0

                        

                }

                private function init():void

                {

                        createTextFormat();

                        createContent();

                        createName();

                        createMail();

                        createMessage();

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

            content.graphics.drawRoundRect(0, 0, 450, 320, 15, 15);

            content.graphics.endFill(); 

            addChild(content);

                }

                private function createName():void

                {

                        FormatTitle(NameTitle)

                        NameTitle.text = language.ContactName

                        FormatInput(Name)

                }

                private function createMail():void

                {

                        FormatTitle(MailTitle)

                        MailTitle.text = language.ContactEmail

                        FormatInput(Mail)

                }

                private function createMessage():void

                {

                        FormatTitle(MessageTitle)

                        MessageTitle.text = language.ContactMessage

                        FormatInput(Message)

                        Message.multiline = true

                        Message.wordWrap = true

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

                        SubmitText.text = language.ContactSend

                        

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

                        main.manager_contact.CloseAdmin();

                }

                private function Position():void

                {

                        

                        var putWidth:Number = 400

                        



                        Name.width = putWidth

                        Name.height = 20

                        Name.x = content.width/2 - Name.width/2

                        Name.y = 40 + SpaceTitle

                        

                        NameTitle.x = Name.x

                        NameTitle.y = 20 + SpaceTitle



                        

                        

                        Mail.width = putWidth

                        Mail.height = 20

                        Mail.x = content.width/2 - Mail.width/2

                        Mail.y = 80 + SpaceTitle



                        MailTitle.x = Mail.x

                        MailTitle.y = 60 + SpaceTitle

                        



                        

                        Message.width = putWidth

                        Message.height = 100

                        Message.x = content.width/2 - Message.width/2

                        Message.y = 140 + SpaceTitle



                        MessageTitle.x = Message.x

                        MessageTitle.y = 120 + SpaceTitle

                        



                        

                        SubmitText.x = Message.x + Message.width - SubmitText.width - Borda

                        SubmitText.y =  Message.y + Message.height + SpaceTitle

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

                        Name.text = ""

                        Mail.text = ""

                        Message.text = ""

                        ErrorText.text = ""

                        //main.stage.removeChild(this)

                        main.manager_contact.HideContact()

                }

                private function Send(event:MouseEvent):void
                {
					if (Name.text == "" ||
                    	Mail.text == "" ||
                    	Message.text == "")
					{
						ErrorText.text = language.UserError2
					}
					else
					{
						ErrorText.text = language.UserError4			
				
						variables.dataFormat = URLLoaderDataFormat.TEXT
						variables.name = Name.text;
						variables.mail = Mail.text;
						variables.message = Message.text;				
						uploadURL.method = URLRequestMethod.POST;
			
						uploadURL.data = variables;		
						CL.load(uploadURL);
						CL.addEventListener(Event.COMPLETE, FadeOUT)	
                	}
                }


        }

}