package;

import winUtils.Balabolka;
import lime.utils.Assets;
import settings.InitialSetup;
import flixel.util.FlxTimer;
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
import util.ACSpinner;

using StringTools;

/**The launch state. This contains variables used throughout the application, such as the icon theme.
@since v0.0.1 (March 2022)*/
class LaunchState extends FlxState {
    public static var windUnits:String = '';
    public static var temperatureUnits:String = ''; // THIS GETS SET IN THE SAVE DATA AFTER INITIAL SETUP, THOUGH THERE'LL ALSO BE A SETTINGS STATE.
    var gameCamera:FlxCamera;
    var appVersionInfo:String = 'HaxeFlixel Weather App - Made by devin503 - v';
    var loadingText:FlxText;
    var spin:ACSpinner;
    var testString = "Add-Type -Assembly System.speech && $pee = new-object System.Speech.Synthesis.SpeechSynthesizer && $pee.speak(\"test\")";

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
        //Assets.loadLibrary("default");
    }
    var startedSearch:Bool = false;
    override function update(elapsed:Float) {
        if (FlxG.keys.justPressed.SEVEN) {
            //BasicOptionMenu.returnTo = this;
            FlxG.switchState(new settings.ActualSettingShit());
        }
        if (FlxG.keys.justPressed.P) {
            FlxG.switchState(new VideoState(PathFinder.funnyVideo("wap.webm"), new PoopyDimension("wap wap wap wap wap wap wap wap wap wap wap wap wap wap wap wap wap wap wap wap wap wap wap wap wap wap wap wap")));
        }
        #if js
        if (loadingText != null) {
            if (loadingText.text != "Loading...") loadingText.text = "I need to mention something. Press H.";
        }
        if (FlxG.keys.justPressed.H && loadingText.text == "I need to mention something. Press H.") {
            loadingText.text = "Loading...";
            openSubState(new web.WebNotice("By default, most browsers will block content\nfrom HTTP sources on\nHTTPS pages.\n\nThe GitHub.io page is HTTPs, and as such\ncore components of this application\nwill not function unless you enable\ninsecure content.\n\nIn Chrome, click the lock icon\nand choose Site settings. Scroll\ndown to \"Insecure content\" and change this to Allow,\nthen refresh the page."));
            new FlxTimer().start(10, function(e:FlxTimer) {
                if (FlxG.save.data.tempUnits != null) {
                    temperatureUnits = FlxG.save.data.tempUnits[0];
                    windUnits = FlxG.save.data.tempUnits[1];
                }
                startedSearch = true;
                openSubState(new WeatherSearch());
            });
        }
        #end

        #if debug
        if (FlxG.keys.justPressed.ANY)
        loadingText.text = Std.string(FlxG.keys.firstJustPressed());
        else
            loadingText.text = 'Loading...';
        #end

        #if debug
        if (FlxG.keys.justPressed.R && !startedSearch) {
            FlxG.switchState(new InitialSetup());
        }
        #end

        #if (web && debug)
        if (FlxG.keys.justPressed.L && !startedSearch) {
            openSubState(new web.WebError('amogus'));
        }
        #end

        #if RATS
        if (FlxG.keys.justPressed.N && !startedSearch) {
            FlxG.switchState(new VideoState(PathFinder.funnyVideo("rat.webm"), new LaunchState()));
        }
        #end
        super.update(elapsed);
    }
    override function create() {
        #if sys
        /*var testTts = new TextToSpeech("This is a test alert.");
        testTts.readAlert();
        var bruh = new openfl.net.FileReference();
        bruh.save(haxe.Json.stringify(FlxG.save.data, "\t"), "test.json"); */
        #end
        //LiterallyTheEntireFNAFLore.getLoreLmao();
        gameCamera = new FlxCamera();
        gameCamera.bgColor = 0xFF000000; // so it's not extremely bright.
        FlxG.cameras.reset(gameCamera);

        loadingText = new FlxText(0, FlxG.height - 18, 0, "Please wait...", 16);
        add(loadingText);

        spin = new ACSpinner(FlxG.width - 50, FlxG.height - 50);
        spin.spin();
        add(spin);

        persistentUpdate = true; //speen

        #if debug
        //APIShit.getNow('Myrtle Beach');
        trace('among us');
        FlxG.console.registerFunction("waluigi", FlxG.log.notice);
        FlxG.console.registerFunction("susDir", sys.FileSystem.readDirectory);
        FlxG.console.registerObject("amongUs", lime.system.System.applicationStorageDirectory);
        #end
        //SusUtil.getWeatherIcon('night/420.png');
        #if !js
        #if windows
        trace(Balabolka.getVoiceList());
        #end
        new FlxTimer().start(3, function(tmr:FlxTimer) {
            //if (!FlxG.save.data.finishedSetup) FlxG.switchState(new InitialSetup()) else {
                /*(if (FlxG.save.data.tempUnits != null) {
                    FlxG.mouse.visible = true;
                    startedSearch = true;
                    temperatureUnits = FlxG.save.data.tempUnits[0];
                    windUnits = FlxG.save.data.tempUnits[1];
                    openSubState(new WeatherSearch());
                } else {
                    SusUtil.API_Failure(-999);
                }*/
            //}
            /*if (FlxG.save.data.tempUnits != null) {
                temperatureUnits = FlxG.save.data.tempUnits[0];
                windUnits = FlxG.save.data.tempUnits[1];
            }*/ // DEPRECATING TEMPUNITS
            if (FlxG.save.data.temperature != null) {
                var the = FlxG.save.data.temperature;
                switch(the) { //shit
                    case 'Fahrenheit':
                        temperatureUnits = "F";
                        windUnits = "mi";
                    case 'Celsius':
                        temperatureUnits = "C";
                        windUnits = "km";
                }
            } else {
                trace("NO TEMPERATURE UNITS SAVED. WE'LL USE FAHRENHEIT AS DEFAULT.");
            }
            startedSearch = true;
            openSubState(new WeatherSearch());
        });
        #end
    }
}
