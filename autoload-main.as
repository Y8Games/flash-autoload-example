package {
	import flash.display.*;
	import flash.events.*;
	import flash.net.*;
	import flash.system.*;
	import flash.utils.*;
	
	[SWF(backgroundColor = "#000000",width = "800",height = "600",frameRate = "30")]// edit this
	public class main extends MovieClip {
		
		var swfLoader:Loader = new Loader();
		var date:Object = new Date();
		var address = "https://storage.id.net/ed/flash/awesome.swf" + date.time;
		var loaderContext:LoaderContext = new LoaderContext();

		public function main() {
			// Since we change loader security context, we need to allow domains as if this is a loaded file
			Security.allowInsecureDomain('*');
			Security.allowDomain('*');
			
			// This says loaded swf will share security context with loader unless swf in a local trusted folder
			loaderContext.applicationDomain = ApplicationDomain.currentDomain;
			if (Security.sandboxType != "localTrusted") {
				loaderContext.securityDomain = SecurityDomain.currentDomain;
			}
			swfLoader.load(new URLRequest(address), loaderContext);
			addChild(swfLoader);
			swfLoader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, onProgress);
			swfLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onError);
			swfLoader.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onError);
		}
		function onProgress(evt:ProgressEvent):void {
			var _loadedPercent = evt.bytesLoaded / evt.bytesTotal * 100;
			if (_loadedPercent == 100) {
				swfLoader.removeEventListener(ProgressEvent.PROGRESS, onProgress);
				swfLoader.removeEventListener(IOErrorEvent.IO_ERROR, onError);
				swfLoader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, onError);
			}
		}
		function onError(e:*):void {
			trace(e);
		}

	}

}