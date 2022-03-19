package;

import haxe.Json;
import sys.Http;
import haxe.xml.Fast;
import cpp.abi.Abi;
import APIKey;

using StringTools;

typedef ResponseBody = {
    var location:ResponseLocation;
    var current:ResponseCurrent;
    var search:Array<ResponseSearch>;
}

typedef ResponseSearch = {
    var id:Int;
    var name:String;
    var region:String;
    var country:String;
    var lat:Float;
    var lon:Float;
    var url:String;
}

typedef ResponseForecast = {
    var forecastday:ForecastDay;
}

typedef ForecastDay = {
    var date:String;
    var date_epoch:Int;
    var day:ForecastDay_Det;
    var astro:ForecastAstro;
    var hour:Array<ForecastHour>;
    var alerts:Array<WeatherAlertArray>;
}
typedef WeatherAlertArray = {
    var alert:Array<WeatherAlert>;
}

typedef ForecastAstro = {
    var sunrise:String;
    var sunset:String;
    var moonrise:String;
    var moonset:String;
    var moon_phase:String;
    var moon_illumination:String;
}

typedef ForecastHour = {
    var time_epoch:Int;
    var time:Date;
    var temp_c:Float;
    var temp_f:Float;
    var is_day:Bool; // YEP, IT'S SUPPOSED TO BE BOOL. 0 or 1
    var condition:WeatherCondition;
    var wind_mph:Float;
    var wind_kph:Float;
    var wind_degree:Int;
    var wind_dir:String;
    var pressure_mb:Float;
    var pressure_in:Float;
    var humidity:Float;
    var cloud:Int;
    var feelslike_c:Float;
    var feelslike_f:Float;
    var windchill_c:Float;
    var windchill_f:Float;
    var heatindex_c:Float;
    var heatindex_f:Float;
    var dewpoint_c:Float;
    var dewpoint_f:Float;
    var will_it_rain:Bool;
    var chance_of_rain:Int;
    var will_it_snow:Bool;
    var chance_of_snow:Int;
    var vis_km:Float;
    var vis_miles:Float;
    var gust_mph:Float;
    var gust_kph:Float;
    var uv:Float;
}

typedef ForecastDay_Det = {
    var maxtemp_c:Float;
    var maxtemp_f:Float;
    var mintemp_c:Float;
    var mintemp_f:Float;
    var avgtemp_c:Float;
    var avgtemp_f:Float;
    var maxwind_mph:Float;
    var maxwind_kph:Float;
    var totalprecip_mm:Float;
    var totalprecip_in:Float;
    var avgvis_km:Float;
    var avgvis_miles:Float;
    var avghumidity:Float;
    var daily_will_it_rain:Int; // possibly bool?
    var daily_chance_of_rain:Int;
    var daily_will_it_snow:Int;
    var daily_chance_of_snow:Int;
    var condition:WeatherCondition;
    var uv:Float;
}

typedef WeatherAlert = {
    var headline:String;
    var msgType:String;
    var severity:String;
    var urgency:String;
    var areas:String;
    var category:String;
    var certainty:String;
    var event:String;
    var note:String;
    var effective:String;
    var expires:String;
    var desc:String;
    var instruction:String;
}

typedef ResponseLocation = {
    var name:String;
    var region:String;
    var country:String;
    var lat:Float;
    var lon:Float;
    var tz_id:String;
    var localtime_epoch:Int;
    var localtime:String;
}

typedef ResponseCurrent = {
    var last_updated_epoch:Int;
    var last_updated:String;
    var temp_c:Float;
    var temp_f:Float;
    var is_day:Bool; //maybe bool??
    var condition:WeatherCondition;
    var wind_mph:Float;
    var wind_kph:Float;
    var wind_degree:Int; //possibly float? unsure.
    var wind_dir:String;
    var pressure_mb:Float;
    var pressure_in:Float;
    var precip_mm:Float;
    var precip_in:Float;
    var humidity:Int;
    var cloud:Int;
    var feelslike_c:Float;
    var feelslike_f:Float;
    var vis_km:Float;
    var vis_miles:Float;
    var uv:Float;
    var gust_mph:Float;
    var gust_kph:Float;
}

typedef WeatherCondition = {
    var text:String;
    var icon:String;
    var code:Int;
}
class APIShit {
    // GOTTA FIGURE IT OUT
    static inline final API_LINK = 'http://api.weatherapi.com/v1/';
    public static function getNow(Location:String) {
        var weatherNow = Http.requestUrl(API_LINK + 'current.json?key=' + APIKey.WeatherKey + '&q=' + Location.replace(' ', '%20') + '&aqi=no');
        trace(weatherNow);
        var curThing:ResponseBody = cast Json.parse(weatherNow);
        trace(curThing);
    }

    public static function searchWeather(Location:String):Array<ResponseSearch> {
        var sresult = Http.requestUrl(API_LINK + 'search.json?key=' + APIKey.WeatherKey + '&q=' + Location.replace(' ', '%20'));
        trace(sresult);
        return cast Json.parse(sresult);
    }

    public static function getForecast(Location:String):ResponseForecast {
        var forecast = Http.requestUrl(API_LINK + 'forecast.json?key=' + APIKey.WeatherKey + '&q=' + Location.replace(' ', '%20') + '&days=1&aqi=no&alerts=yes');
        return cast Json.parse(forecast);
    }
}