package;

import lime.system.Clipboard;
import flixel.input.keyboard.FlxKey;
import flixel.addons.ui.FlxUIInputText;
import flixel.addons.ui.FlxUIDropDownMenu;
import flixel.FlxG;
import APIShit;
import flixel.FlxSubState;
import flixel.FlxSprite;
import FlxUIDropDownMenuCustom;
import flixel.addons.ui.FlxUITabMenu;
import flixel.addons.ui.FlxUI;
import flixel.ui.FlxButton;
import Eduardo;

using StringTools;
/** This substate provides a list of results from search
@since v0.0.1 (March 2022)*/
class WeatherSearch extends FlxSubState {
    var cityList:Array<String> = [];
    var SearchUI:FlxUITabMenu;
    var UIAss:FlxUI;
    var cityDropDownMenu:FlxUIDropDownMenuCustom;
    var forecastLocation:ResponseForecast;
    var locations:Array<ResponseSearch> = [];
    var DEST_ON_SEVEN:Array<Dynamic> = [];
    var blockInputWhileTyping:Array<FlxUIInputText> = [];
    var ed:Eduardo;
    public function new() {
        super();
    }

    override function create() {
        var tabs = [
            { name: 'Search', label: 'Search' }
        ];
        SearchUI = new FlxUITabMenu(null, tabs);
        SearchUI.resize(400, 150);
        SearchUI.setPosition(FlxG.width - 425, 15);
        trace(SearchUI);
        add(SearchUI);
        DEST_ON_SEVEN.push(SearchUI);
        setupSearchUI();
        ed = new Eduardo(0, 0);
        ed.visible = false;
        add(ed);

        if (ForecastState.location != null) {
            var exitButton = new FlxButton(0, 69, 'Exit', function() {
                close();
            });
            add(exitButton);
        }
    }
    var blockInput:Bool = false;
    var curBlocker:Dynamic = null;
    override function update(elapsed:Float) {
        super.update(elapsed);

        if (blockInputWhileTyping.length > 0) {
            for (tex in blockInputWhileTyping) {
                if (tex.hasFocus) {
                    blockInput = true;
                    curBlocker = tex;
                    FlxG.sound.muteKeys = null;
                    FlxG.sound.volumeDownKeys = null;
                    FlxG.sound.volumeUpKeys = null;
                } else {
                    return;
                }
            }
        }

        if (blockInput) {
            if (curBlocker != null) {
                if (curBlocker.hasFocus) {
                    return;
                } else if (!curBlocker.hasFocus) {
                    blockInput = false;
                    curBlocker = null;
                }
            }
        }

        if (ed != null) {
            ed.update(elapsed);
            ed.dance();
            if (FlxG.keys.justPressed.L && !blockInput) {
                ed.visible = true;
                ed.jumpscare();
            }
        }

        if (!blockInput) {
            if (FlxG.sound.volumeUpKeys == null) {
                FlxG.sound.volumeUpKeys = [FlxKey.PLUS, FlxKey.NUMPADPLUS];
            }
            if (FlxG.sound.volumeDownKeys == null) {
                FlxG.sound.volumeDownKeys = [FlxKey.MINUS, FlxKey.NUMPADMINUS];
            }
            if (FlxG.sound.muteKeys == null) {
                FlxG.sound.muteKeys = [FlxKey.ZERO, FlxKey.NUMPADZERO];
            }
            if (FlxG.keys.justPressed.SEVEN) {
                BasicOptionMenu.returnTo = this;
                for (asset in DEST_ON_SEVEN) {
                    asset.destroy();
                    asset = null;
                }
                close();
                FlxG.switchState(new BasicOptionMenu());
            }
        }
    }

    function setupSearchUI() {
        UIAss = new FlxUI(null, SearchUI);
        UIAss.name = 'Search';
        DEST_ON_SEVEN.push(UIAss);

        cityDropDownMenu = new FlxUIDropDownMenuCustom(15, 60, FlxUIDropDownMenuCustom.makeStrIdLabelArray(['Search first'], true), function (loc:String) {
            forecastLocation = APIShit.getForecast(locations[Std.parseInt(loc)].name + ', ' + locations[Std.parseInt(loc)].region); // this should give City, State!
        });
        DEST_ON_SEVEN.push(cityDropDownMenu);

        var searchInputBox = new FlxUIInputText(15, 30, 200, 'Enter a search term...', 8);
        DEST_ON_SEVEN.push(searchInputBox);
        blockInputWhileTyping.push(searchInputBox);

        var searchButton:FlxButton = new FlxButton(searchInputBox.x + 210, searchInputBox.y, 'Search', function() {
            doSearch(searchInputBox.text);
        });
        DEST_ON_SEVEN.push(searchButton);

        var goButton = new FlxButton(160, 100, 'Go', openForecastState);
        DEST_ON_SEVEN.push(goButton);

        UIAss.add(cityDropDownMenu);
        UIAss.add(searchInputBox);
        UIAss.add(searchButton);
        UIAss.add(goButton);
        SearchUI.addGroup(UIAss);
    }

    function openForecastState() {
        ForecastState.location = forecastLocation;
        #if debug
        trace(haxe.Json.stringify(forecastLocation, "\t"));
        Clipboard.text = haxe.Json.stringify(forecastLocation, "\t"); // made this debug so it doesnt just copy on release builds
        #end
        FlxG.switchState(new ForecastState());
    }

    function doSearch(Location:String) {
        var results = APIShit.searchWeather(Location);
        for (i in 0...results.length) {
            locations.push(results[i]);
            //trace(locations);
        }
        if (results.length >= 3) reloadDropDown();
    }

    function reloadDropDown() {
        if (cityDropDownMenu != null) {
            var cityNames:Array<String> = [];
            for (loc in locations) {
                cityNames.push(loc.name + ', ' + loc.region);
            }
            cityDropDownMenu.setData(FlxUIDropDownMenuCustom.makeStrIdLabelArray(cityNames, false));
        }
    }
}