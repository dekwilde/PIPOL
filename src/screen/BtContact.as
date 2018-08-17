package screen
{
        import flash.display.*;
        import flash.text.*
        import flash.events.*
        import flash.filters.GlowFilter;
        
        import caurina.transitions.Tweener;
        
        public class BtContact extends MovieClip 
        {
                public var main:Main
                
                private var language:Language = new Language()
                private var colors:Colors = new Colors();
                
                private var content:MovieClip = new MovieClip();
                private var Text:TextField = new TextField()
                
                private var BlurGlow:Number = 1.6
                private var StrechGlow:Number = 1.2
                private var QualityGlow:Number = 100
                private var borderColor:uint  = 0xFFFFFF
                private var filterGlow:GlowFilter = new GlowFilter(borderColor, 1, BlurGlow, BlurGlow, StrechGlow, QualityGlow);
                                
                private var FormatText:TextFormat = new TextFormat()
                
                function BtContact()  
                {
                        this.filters = [filterGlow];
                        createTextFormat();
                        createButton();
                        
                }
                private function createButton():void
                {                       
                        FormatTitle(Text)
                        Text.text = language.contactButton                        
                        content.graphics.beginFill(colors.ButtonBrowser, 0.0);
            			content.graphics.drawRect(0, 0, Text.textWidth, Text.textHeight);
            			content.graphics.endFill(); 
            			addChild(content);
                        
                        content.addEventListener(MouseEvent.MOUSE_DOWN, OpenContact);
                        content.addEventListener(MouseEvent.MOUSE_OVER, Over);
                        content.addEventListener(MouseEvent.MOUSE_OUT, Out)
                }
                private function createTextFormat():void
                {
                        FormatText.color = colors.TitleSite
                        FormatText.size = 12
                        FormatText.font = "Arial"
                        FormatText.align = "left"
                        FormatText.leading = 0.5
                }
                private function FormatTitle(tf:TextField):void
                {
                        tf.selectable = false
                        tf.mouseEnabled = false
                        tf.autoSize = TextFieldAutoSize.LEFT
                        tf.blendMode = "layer"
                        tf.height = 14
                        tf.defaultTextFormat = FormatText;
                        addChild(tf)
                }
                private function Over(event:MouseEvent):void
                {
                        buttonMode = true;
                }
                private function Out(event:MouseEvent):void
                {
                        buttonMode = false;
                }
                private function OpenContact(event:MouseEvent):void
                {
                        Disable()
                        main.manager_contact.init();
                        main.manager_contact.ShowContact();
                        main.descricao.Dispose();
                        main.managerbox.BoxesDisable();
                        main.manager_admin.CloseAdmin();
                        
                }
                public function Disable():void
                {
                        content.removeEventListener(MouseEvent.MOUSE_DOWN, OpenContact);
                }
                public function Enable():void
                {
                        content.addEventListener(MouseEvent.MOUSE_DOWN, OpenContact);
                }
        }
}
