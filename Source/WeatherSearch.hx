package;

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
    }

    override function update(elapsed:Float) {
        super.update(elapsed);

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
        FlxG.switchState(new ForecastState());
    }

    function doSearch(Location:String) {
        var results = APIShit.searchWeather(Location);
        for (i in 0...results.length) {
            locations.push(results[i]);
            trace(locations);
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