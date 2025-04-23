package;

import haxe.Json;
import lime.system.Clipboard;
import flixel.input.keyboard.FlxKey;
import flixel.addons.ui.FlxUIInputText;
import flixel.addons.ui.FlxUIDropDownMenu;
import flixel.text.FlxText;
import flixel.FlxG;
import APIShit;
import flixel.FlxSubState;
import flixel.FlxSprite;
import flixel.FlxCamera;
import flixel.util.FlxColor;
import FlxUIDropDownMenuCustom;
import flixel.addons.ui.FlxUITabMenu;
import flixel.addons.ui.FlxUI;
import flixel.ui.FlxButton;
#if !web import Eduardo; #end

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
    var mouseCam:FlxCamera;
    var daMouse:CustomMouseCursor;
    var hoverableObjects:Array<Array<Dynamic>> = [];
    public static var instance:WeatherSearch;
    public function new() {
        super();
        instance = this;
        #if debug
        //FlxG.console.registerClass(this);
        FlxG.console.registerObject('ws', instance);
        #end
    }

    override function create() {
        var testPiss = FlxColor.gradient(0xFF000000, 0xFFADB3D5, Std.int(FlxG.height));
        var teeth = Std.int(FlxG.height);
        for (fard in 0...teeth) {
            var edamame = new FlxSprite(0, FlxG.height - fard);
            edamame.makeGraphic(Std.int(FlxG.width), 1, testPiss[fard]);
            edamame.alpha = 1;
            add(edamame);
        }
        mouseCam = new FlxCamera();
        mouseCam.bgColor.alpha = 0;
        FlxG.cameras.add(mouseCam, false);
        daMouse = new CustomMouseCursor();
        daMouse.cameras = [mouseCam];
        add(daMouse);
        var tabs = [
            { name: 'Search', label: 'Search' },
            { name: 'Units', label: 'Units' }
        ];
        SearchUI = new FlxUITabMenu(null, tabs);
        SearchUI.resize(400, 150);
        SearchUI.setPosition(FlxG.width - 425, 15);
        trace(SearchUI);
        add(SearchUI);
        DEST_ON_SEVEN.push(SearchUI);
        for (tab in @:privateAccess SearchUI._tabs) {
            hoverableObjects.push([tab, "lonk"]);
        }
        setupSearchUI();
        setupUnitUI();
        ed = new Eduardo(0, 0);
        //ed.visible = false;
        ed.dance();
        #if !GH_IO add(ed); #end
        trace(ed);
        //FlxG.sound.play("Assets/Music/storm.wav");

        if (ForecastState.location != null) {
            var exitButton = new FlxButton(0, 69, 'Exit', function() {
                close();
            });
            add(exitButton);
        }

        tryUpdate(0);
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
        if (daMouse != null) {
            daMouse.update(elapsed);
            var daBullshit = 'idle';
            var curHover:Dynamic = null;
            for (asset in hoverableObjects) {
                if (asset[0] is flixel.addons.ui.interfaces.IFlxUIButton) {
                    if (asset[0].mouseIsOver) {
                        daBullshit = asset[1];
                        curHover = asset[0];
                        //hoverin = true;
                    }
                    else return;
                } else if (asset[0].visible && FlxG.mouse.overlaps(asset[0])) {
                    daBullshit = asset[1];
                    curHover = asset[0];
                    //hoverin = true;
                    break;
                } else {
                        if (curHover != null && !(curHover.mouseIsOver || FlxG.mouse.overlaps(curHover))) {
                        curHover = null;
                        daBullshit = 'idle';
                    }
                }
            }
            daMouse.switchAnim(daBullshit);
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

        #if !GH_IO
        if (ed != null) {
            ed.update(elapsed);
            if (ed.animation.curAnim.finished) ed.dance();
            /* if (FlxG.keys.justPressed.L && !blockInput) {
                ed.visible = true;
                ed.jumpscare();
            } */
        }
        #end
        #if web
        if (FlxG.keys.checkStatus(32, JUST_PRESSED) && searchInputBox.hasFocus) {
            searchInputBox.text += ' ';
        }
        #end
        #if !GH_IO
        if (FlxG.keys.justPressed.L && !blockInput) {
            ed.animation.play('wellWellWell');
            FlxG.sound.play(PathFinder.loud_sound('theFunnyWell'), 1, false, null, true, function() {
                trace('you have been well well well\'d');
            });
        }
        #end

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
                FlxG.switchState(new settings.ActualSettingShit());
            }
        }
    }
    var searchInputBox:FlxUIInputText;
    function setupSearchUI() {
        UIAss = new FlxUI(null, SearchUI);
        UIAss.name = 'Search';
        DEST_ON_SEVEN.push(UIAss);

        cityDropDownMenu = new FlxUIDropDownMenuCustom(15, 60, FlxUIDropDownMenuCustom.makeStrIdLabelArray(['Search first'], true), function (loc:String) {
            forecastLocation = APIShit.getForecast(locations[Std.parseInt(loc)].name + ', ' + locations[Std.parseInt(loc)].region); // this should give City, State!
        });
        hoverableObjects.push([cityDropDownMenu, "lonk"]);
        DEST_ON_SEVEN.push(cityDropDownMenu);

        searchInputBox = new FlxUIInputText(15, 30, 200, 'Enter a search term...', 8);
        DEST_ON_SEVEN.push(searchInputBox);
        hoverableObjects.push([searchInputBox, "txt"]);
        blockInputWhileTyping.push(searchInputBox);

        var searchButton:FlxButton = new FlxButton(searchInputBox.x + 210, searchInputBox.y, 'Search', function() {
                doSearch(searchInputBox.text);
        });
        hoverableObjects.push([searchButton, "lonk"]);
        DEST_ON_SEVEN.push(searchButton);

        var goButton = new FlxButton(160, 100, 'Go', openForecastState);
        hoverableObjects.push([goButton, "lonk"]);
        DEST_ON_SEVEN.push(goButton);

        UIAss.add(cityDropDownMenu);
        UIAss.add(searchInputBox);
        UIAss.add(searchButton);
        UIAss.add(goButton);
        SearchUI.addGroup(UIAss);
    }
    var allowSwitch:Bool = true;
    function openForecastState() {
        if (forecastLocation != null) {
            ForecastState.location = forecastLocation;
        } else if (searchInputBox.text.length >= 1 && searchInputBox.text != 'Enter a search term...') {
            trace("attempting to get directly");
            ForecastState.location = APIShit.getForecast(searchInputBox.text);
        } else {
            ForecastState.location = SusUtil.placeholderForecast(); // so we have a placeholder
        }
        _parentState.persistentUpdate = false; // so speen stops
        #if WINDUSSY
        trace(haxe.Json.stringify(forecastLocation, "\t"));
        Clipboard.text = haxe.Json.stringify(forecastLocation, "\t"); // made this debug so it doesnt just copy on release builds
        #end
        if (allowSwitch) FlxG.switchState(new ForecastState());
    }

    function doSearch(Location:String) {
        var results = APIShit.searchWeather(Location);
        for (i in 0...results.length) {
            locations.push(results[i]);
            //trace(locations);
        }
        if (locations.length > 0) forecastLocation = APIShit.getForecast(locations[0].name + ', ' + locations[0].region);
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

    function doUnitThing(unit:String) {
        switch (Std.parseInt(unit)) {
            case 0:
                trace("USING THE VIRGIN FAHRENHEIT");
                LaunchState.temperatureUnits = 'F';
                FlxG.save.data.tempUnits = ['F', 'mi'];
            case 1:
                trace("USING THE CHAD CELSIUS");
                LaunchState.temperatureUnits = 'C';
                FlxG.save.data.tempUnits = ['C', 'km'];
        }
    }
    var hoverin:Bool = false;
    var unitDrop:FlxUIDropDownMenuCustom;
    function setupUnitUI() {
        var dum:FlxUI = new FlxUI(null, SearchUI);
        dum.name = "Units";

        unitDrop = new FlxUIDropDownMenuCustom(15, 30, FlxUIDropDownMenuCustom.makeStrIdLabelArray(["Fahrenheit", "Celsius"], true), doUnitThing);
        hoverableObjects.push([unitDrop, "lonk"]);
        dum.add(unitDrop);
        dum.add(new FlxText(15, unitDrop.y - 18, 0, "Temperature units:", 8));
        SearchUI.addGroup(dum);
    }
}