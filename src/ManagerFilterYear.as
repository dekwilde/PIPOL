 package  
{
        
        import contact.FilterYear
        
        public class ManagerFilterYear 
        {
                
                                //ADMIN
                public var main:Main
                public var filter_year:FilterYear = new FilterYear()
                
                public function ManagerFilterYear() 
                {
                        super();

                }
                public function init():void 
                {
                        // admin
                        filter_year.main = main
                }
                // ADMIN SETUP
                public function ShowFilterYear():void
                {
                        main.stage.addChild(filter_year)
                        filter_year.FadeIN();
                }
                public function HideFilterYear():void
                {
                        main.stage.removeChild(filter_year);
                        CloseAdmin();
                }
                public function CloseAdmin():void
                {

                        filter_year.FadeOUT();
                        main.managerbox.BoxesEnable();
                        main.bt_filter_year.Enable();
                }
                
                public function Destroy():void 
                {
                        
                }
        }
        
}
