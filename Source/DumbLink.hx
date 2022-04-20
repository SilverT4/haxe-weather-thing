package;

#if js
import js.html.Blob;
import haxe.io.Bytes;

class DumbLink extends haxe.http.HttpBase {
    public var async:Bool;
    public var withCredentials:Bool;

    public function new(URL:String) {
        async = true;
        withCredentials = false;
        super(URL);
    }
    var req:js.html.XMLHttpRequest;
    public override function request(?post:Bool) {
		this.responseAsString = null;
		this.responseBytes = null;
		var r = req = js.Browser.createXMLHttpRequest();
		var onreadystatechange = function(_) {
			if (r.readyState != 4)
				return;
			var s = try r.status catch (e:Dynamic) null;
			if (s == 0 && js.Browser.supported && js.Browser.location != null) {
				// If the request is local and we have data: assume a success (jQuery approach):
				var protocol = js.Browser.location.protocol.toLowerCase();
				var rlocalProtocol = ~/^(?:about|app|app-storage|.+-extension|file|res|widget):$/;
				var isLocal = rlocalProtocol.match(protocol);
				if (isLocal) {
					s = r.response != null ? 200 : 404;
				}
			}
			if (s == js.Lib.undefined)
				s = null;
			if (s != null)
				onStatus(s);
			if (s != null && s >= 200 && s < 400) {
				req = null;
				success(Bytes.ofString(r.response));
			} else if (s == null || (s == 0 && r.response == null)) {
				req = null;
				onError("Failed to connect or resolve host");
			} else
				switch (s) {
					case 12029:
						req = null;
						onError("Failed to connect to host");
					case 12007:
						req = null;
						onError("Unknown host");
					default:
						req = null;
                        responseAsString = r.response != null ? r.response : null;
						responseBytes = r.response != null ? Bytes.ofData(r.response) : null;
						onError("Http Error #" + r.status);
				}
		};
		if (async)
			r.onreadystatechange = onreadystatechange;
		var uri:Null<Any> = switch [postData, postBytes] {
			case [null, null]: null;
			case [str, null]: str;
			case [null, bytes]: new Blob([bytes.getData()]);
			case _: null;
		}
		if (uri != null)
			post = true;
		else
			for (p in params) {
				if (uri == null)
					uri = "";
				else
					uri = uri + "&";
				uri = uri + StringTools.urlEncode(p.name) + "=" + StringTools.urlEncode(p.value);
			}
		try {
			if (post)
				r.open("POST", url, async);
			else if (uri != null) {
				var question = url.split("?").length <= 1;
				r.open("GET", url + (if (question) "?" else "&") + uri, async);
				uri = null;
			} else
				r.open("GET", url, async);
			if (async) r.responseType = JSON;
		} catch (e:Dynamic) {
			req = null;
			onError(e.toString());
			return;
		}
		r.withCredentials = withCredentials;
		if (!Lambda.exists(headers, function(h) return h.name == "Content-Type") && post && postData == null)
			r.setRequestHeader("Content-Type", "application/json");

		for (h in headers)
			r.setRequestHeader(h.name, h.value);
		r.send(uri);
		if (!async)
			onreadystatechange(null);
	}

    public static function requestUrl(url:String, params:Map<String, String>):String {
		var h = new DumbLink(url);
		#if js h.async = false; #end
        //h.setHeader("accept", "application/json");
        for (par => am in params) {
            h.addParameter(par, am);
        }
		var r = null;
		h.onData = function(d) {
			r = d;
		}
		h.onError = function(e) {
			throw e;
		}
		h.request(false);
		return r;
	}
}
#end