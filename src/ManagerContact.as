package  
{
        
        import contact.Contact
        
        public class ManagerContact 
        {
                
                                //ADMIN
                public var main:Main
                public var contato:Contact = new Contact()
                
                public function ManagerContact() 
                {
                        super();

                }
                public function init():void 
                {
                        // admin
                        contato.main = main
                }
                // ADMIN SETUP
                public function ShowContact():void
                {
                        main.stage.addChild(contato)
                        contato.FadeIN();
                }
                public function HideContact():void
                {
                        main.stage.removeChild(contato);
                        CloseAdmin()
                }
                public function CloseAdmin():void
                {

                        contato.FadeOUT();
                        main.managerbox.BoxesEnable();
                        main.bt_contact.Enable()
                }
                
                public function Destroy():void 
                {
                        
                }
        }
        
}
