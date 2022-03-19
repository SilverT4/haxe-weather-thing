package;

import haxe.Http;
import openfl.Lib;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.FlxCamera;
import openfl.system.Capabilities;
import lime.app.Application;
import flixel.ui.FlxBar;
import flixel.ui.FlxButton;
import flixel.text.FlxText;
import SusUtil;

using StringTools;

/**The launch state. This contains variables used throughout the application, such as the icon theme.
@since v0.0.1 (March 2022)*/
class LaunchState extends FlxState {
    public static var iconTheme:String = ''; // I STILL NEED TO SET UP ICON THEMES.
    public static var temperatureUnits:String = ''; // THIS GETS SET IN THE SAVE DATA AFTER INITIAL SETUP, THOUGH THERE'LL ALSO BE A SETTINGS STATE.
    var gameCamera:FlxCamera;
    var appVersionInfo:String = 'HaxeFlixel Weather App - Made by devin503 - v';
    var loadingText:FlxText;

    public function new() {
        super();
        appVersionInfo += Application.current.meta.get('version');
        #if debug
        trace("sus");
        #end
        trace(appVersionInfo);
        if (APIKey.WeatherKey == '') {
            //SusUtil.openLink('https://weatherapi.com/'); (THIS WAS A TEST!!)
            SusUtil.API_Failure(0); // Crash if the API key is missing.
        }
        if (FlxG.keys.pressed.SEVEN) {
            BasicOptionMenu.returnTo = this;
            FlxG.switchState(new BasicOptionMenu());
        }
    }

    override function create() {
        gameCamera = new FlxCamera();
        gameCamera.bgColor = 0xFF000000; // so it's not extremely bright.
        FlxG.cameras.reset(gameCamera);

        loadingText = new FlxText(0, FlxG.height - 18, 0, "Please wait...", 16);
        add(loadingText);

        #if debug
        //APIShit.getNow('Myrtle Beach');
        trace('among us');
        #end

        //SusUtil.getWeatherIcon('night/420.png');
        ForecastState.location = APIShit.getForecast('Day Heights, Ohio');
        openSubState(new forecasts.HourlyForecastSubstate());
    }
}