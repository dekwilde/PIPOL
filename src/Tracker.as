package {
	import flash.external.ExternalInterface;
public class Tracker
{
    public function Tracker()
    {
    } // End of the function
    public function track(id:String):void {

        trace (id);
        if (ExternalInterface.available) {
        	ExternalInterface.call("logPageview", id);
    	}
	}
} // End of Class
}
