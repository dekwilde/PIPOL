var gaTrackerId = "UA-18280178-1"; //id pipol in dekwide account


var gaJsHost = (("https:" == document.location.protocol) ? "https://ssl." : "http://www.");
document.write(unescape("%3Cscript src='" + gaJsHost + "google-analytics.com/ga.js' type='text/javascript'%3E%3C/script%3E"));

function logPageview(trackingEvent)
{

	var pageJsTracker = _gat._getTracker(gaTrackerId);
	pageJsTracker._trackPageview("site/"+trackingEvent);
	trace ("site/"+trackingEvent)
}

function trace(msg){
		try{
			console.log(msg)
		}catch(e){
		
		}
}
