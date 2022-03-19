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
        add(SearchUI);
        setupSearchUI();
    }

    function setupSearchUI() {
        UIAss = new FlxUI(null, SearchUI);
        UIAss.name = 'Search';

        cityDropDownMenu = new FlxUIDropDownMenuCustom(15, 60, FlxUIDropDownMenuCustom.makeStrIdLabelArray(['Search first'], true), function (loc:String) {
            forecastLocation = APIShit.getForecast(locations[Std.parseInt(loc)].name + ', ' + locations[Std.parseInt(loc)].region); // this should give City, State!
        });

        var searchInputBox = new FlxUIInputText(15, 30, 200, 'Enter a search term...', 8);

        var searchButton:FlxButton = new FlxButton(searchInputBox.x + 210, searchInputBox.y, 'Search', function() {
            doSearch(searchInputBox.text);
        });

        var goButton = new FlxButton(160, 100, 'Go', openForecastState);

        UIAss.add(cityDropDownMenu);
        UIAss.add(searchInputBox);
        UIAss.add(searchButton);
        UIAss.add(goButton);
        SearchUI.addGroup(UIAss);
    }

    function openForecastState() {
        ForecastState.location = forecastLocation;
    }

    function doSearch(Location:String) {
        var results = APIShit.searchWeather(Location);
        for (i in 0...results.length) {
            locations.push(results[i]);
            trace(locations);
        }
        reloadDropDown();
    }

    function reloadDropDown() {
        if (cityDropDownMenu != null) {
            var cityNames:Array<String> = [];
            for (loc in locations) {
                cityNames.push(loc.name);
            }
            cityDropDownMenu.setData(FlxUIDropDownMenuCustom.makeStrIdLabelArray(cityNames, false));
        }
    }
}