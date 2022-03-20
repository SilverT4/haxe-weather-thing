package forecasts;

import flixel.FlxG;
import flixel.FlxSubState;
import flixel.FlxSprite;
import flixel.addons.ui.FlxUITabMenu;
import flixel.addons.ui.FlxUI;
import flixel.text.FlxText;
import util.WeatherIcon;
import APIShit;
import SusUtil;
import PogTools;
import ForecastState.location as fcloc;
using StringTools;

class HourlyForecastSubstate extends FlxSubState {
    var hourList:Array<Int> = [];
    var forecasts:Array<ForecastHour> = [];
    var tablist_day = [
        {name: 'hour_5', label: '5 AM'},
        {name: 'hour_6', label: '6 AM'},
        {name: 'hour_7', label: '7 AM'},
        {name: 'hour_8', label: '8 AM'},
        {name: 'hour_9', label: '9 AM'},
        {name: 'hour_10', label: '10 AM'},
        {name: 'hour_11', label: '11 AM'},
        {name: 'hour_12', label: 'Noon'},
        {name: 'hour_13', label: '1 PM'},
        {name: 'hour_14', label: '2 PM'},
        {name: 'hour_15', label: '3 PM'},
        {name: 'hour_16', label: '4 PM'},
        {name: 'hour_17', label: '5 PM'},
        {name: 'hour_18', label: '6 PM'}
    ]; // MESSY AF BUT IT WORKS
    var tablist_night = [
        {name: 'hour_0', label: 'Midnight'},
        {name: 'hour_1', label: '1 AM'},
        {name: 'hour_2', label: '2 AM'},
        {name: 'hour_3', label: '3 AM'},
        {name: 'hour_4', label: '4 AM'},
        {name: 'hour_19', label: '7 PM'},
        {name: 'hour_20', label: '8 PM'},
        {name: 'hour_21', label: '9 PM'},
        {name: 'hour_22', label: '10 PM'},
        {name: 'hour_23', label: '11 PM'}
    ]; // a BIT more organised!!
    var midUI:FlxUI;
    var _1aUI:FlxUI;
    var _2aUI:FlxUI;
    var _3aUI:FlxUI;
    var _4aUI:FlxUI;
    var _5aUI:FlxUI;
    var _6aUI:FlxUI;
    var _7aUI:FlxUI;
    var _8aUI:FlxUI;
    var _9aUI:FlxUI;
    var _10aUI:FlxUI;
    var _11aUI:FlxUI;
    var noonUI:FlxUI;
    var _1pUI:FlxUI;
    var _2pUI:FlxUI;
    var _3pUI:FlxUI;
    var _4pUI:FlxUI;
    var _5pUI:FlxUI;
    var _6pUI:FlxUI;
    var _7pUI:FlxUI;
    var _8pUI:FlxUI;
    var _9pUI:FlxUI;
    var _10pUI:FlxUI;
    var _11pUI:FlxUI;
    var hourForeUI:FlxUITabMenu;
    var lookingAt:String = 'day';
    public function new(dayNight:Int) {
        super();
        if (dayNight == 0) {
            trace('day');
        } else {
            lookingAt = 'night';
            trace('night');
        }
        //var efef:ForecastHour;
        for (i in 0...23) {
            hourList.push(i); // lazy thingsss
        }
        if (fcloc != null) {
            forecasts = fcloc.forecast.forecastday[0].hour;
        }
    }
    
    override function create() {
        if (lookingAt == 'night')
        hourForeUI = new FlxUITabMenu(null, tablist_night);
        else hourForeUI = new FlxUITabMenu(null, tablist_day);
        hourForeUI.resize(FlxG.width, 500);
        hourForeUI.scrollFactor.set();
        hourForeUI.selected_tab_id = "Midnight";
        add(hourForeUI);
        if (lookingAt == 'night') {
            setupMidUI();
            setup1aUI();
            setup2aUI();
            setup3aUI();
            setup4aUI();
            setup7pUI();
            setup8pUI();
            setup9pUI();
            setup10pUI();
            setup11pUI();
        } else if (lookingAt == 'day') {
            setup5aUI();
            setup6aUI();
            setup7aUI();
            setup8aUI();
            setup9aUI();
            setup10aUI();
            setup11aUI();
            setupNoonUI();
            setup1pUI();
            setup2pUI();
            setup3pUI();
            setup4pUI();
            setup5pUI();
            setup6pUI();
        }
    }
    // BEGIN MESS OF SETUP FUNCTIONS!!
    function setupMidUI() {
        midUI = new FlxUI(null, hourForeUI);
        midUI.name = "Midnight";
        
        var wxIcon:WeatherIcon = new WeatherIcon(15, 30, getIconVariant(forecasts[0].condition.icon), 0);
        
        var condText = new FlxText(wxIcon.x + 69, wxIcon.getGraphicMidpoint().y - 14, 0, forecasts[0].condition.text, 12);
        midUI.add(wxIcon);
        midUI.add(condText);
        hourForeUI.addGroup(midUI);
    }
    function setup1aUI() {
        _1aUI = new FlxUI(null, hourForeUI);
        _1aUI.name = "1 AM";
        
        var wxIcon:WeatherIcon = new WeatherIcon(15, 30, getIconVariant(forecasts[1].condition.icon), 1);
        
        var condText = new FlxText(wxIcon.x + 69, wxIcon.getGraphicMidpoint().y - 14, 0, forecasts[1].condition.text, 12);
        _1aUI.add(wxIcon);
        _1aUI.add(condText);
        hourForeUI.addGroup(_1aUI);
    }
    function setup2aUI() {
        _2aUI = new FlxUI(null, hourForeUI);
        _2aUI.name = "2 AM";
        
        var wxIcon:WeatherIcon = new WeatherIcon(15, 30, getIconVariant(forecasts[2].condition.icon), 2);
        
        var condText = new FlxText(wxIcon.x + 69, wxIcon.getGraphicMidpoint().y - 14, 0, forecasts[2].condition.text, 12);
        _2aUI.add(wxIcon);
        _2aUI.add(condText);
        hourForeUI.addGroup(_2aUI);
    }
    function setup3aUI() {
        _3aUI = new FlxUI(null, hourForeUI);
        _3aUI.name = "3 AM";
        
        var wxIcon:WeatherIcon = new WeatherIcon(15, 30, getIconVariant(forecasts[3].condition.icon), 3);
        
        var condText = new FlxText(wxIcon.x + 69, wxIcon.getGraphicMidpoint().y - 14, 0, forecasts[3].condition.text, 12);
        _3aUI.add(wxIcon);
        _3aUI.add(condText);
        hourForeUI.addGroup(_3aUI);
    }
    function setup4aUI() {
        _4aUI = new FlxUI(null, hourForeUI);
        _4aUI.name = "4 AM";
        
        var wxIcon:WeatherIcon = new WeatherIcon(15, 30, getIconVariant(forecasts[4].condition.icon), 4);
        
        var condText = new FlxText(wxIcon.x + 69, wxIcon.getGraphicMidpoint().y - 14, 0, forecasts[4].condition.text, 12);
        _4aUI.add(wxIcon);
        _4aUI.add(condText);
        hourForeUI.addGroup(_4aUI);
    }
    function setup5aUI() {
        _5aUI = new FlxUI(null, hourForeUI);
        _5aUI.name = "5 AM";
        
        var wxIcon:WeatherIcon = new WeatherIcon(15, 30, getIconVariant(forecasts[5].condition.icon), 5);
        
        var condText = new FlxText(wxIcon.x + 69, wxIcon.getGraphicMidpoint().y - 14, 0, forecasts[5].condition.text, 12);
        _5aUI.add(wxIcon);
        _5aUI.add(condText);
        hourForeUI.addGroup(_5aUI);
    }
    function setup6aUI() {
        _6aUI = new FlxUI(null, hourForeUI);
        _6aUI.name = "6 AM";
        
        var wxIcon:WeatherIcon = new WeatherIcon(15, 30, getIconVariant(forecasts[6].condition.icon), 6);
        
        var condText = new FlxText(wxIcon.x + 69, wxIcon.getGraphicMidpoint().y - 14, 0, forecasts[6].condition.text, 12);
        _6aUI.add(wxIcon);
        _6aUI.add(condText);
        hourForeUI.addGroup(_6aUI);
    }
    function setup7aUI() {
        _7aUI = new FlxUI(null, hourForeUI);
        _7aUI.name = "7 AM";
        
        var wxIcon:WeatherIcon = new WeatherIcon(15, 30, getIconVariant(forecasts[7].condition.icon), 7);
        
        var condText = new FlxText(wxIcon.x + 69, wxIcon.getGraphicMidpoint().y - 14, 0, forecasts[7].condition.text, 12);
        _7aUI.add(wxIcon);
        _7aUI.add(condText);
        hourForeUI.addGroup(_7aUI);
    }
    function setup8aUI() {
        _8aUI = new FlxUI(null, hourForeUI);
        _8aUI.name = "8 AM";
        
        var wxIcon:WeatherIcon = new WeatherIcon(15, 30, getIconVariant(forecasts[8].condition.icon), 8);
        
        var condText = new FlxText(wxIcon.x + 69, wxIcon.getGraphicMidpoint().y - 14, 0, forecasts[8].condition.text, 12);
        _8aUI.add(wxIcon);
        _8aUI.add(condText);
        hourForeUI.addGroup(_8aUI);
    }
    function setup9aUI() {
        _9aUI = new FlxUI(null, hourForeUI);
        _9aUI.name = "9 AM";
        
        var wxIcon:WeatherIcon = new WeatherIcon(15, 30, getIconVariant(forecasts[9].condition.icon), 9);
        
        var condText = new FlxText(wxIcon.x + 69, wxIcon.getGraphicMidpoint().y - 14, 0, forecasts[9].condition.text, 12);
        _9aUI.add(wxIcon);
        _9aUI.add(condText);
        hourForeUI.addGroup(_9aUI);
    }
    function setup10aUI() {
        _10aUI = new FlxUI(null, hourForeUI);
        _10aUI.name = "10 AM";
        
        var wxIcon:WeatherIcon = new WeatherIcon(15, 30, getIconVariant(forecasts[10].condition.icon), 10);
        
        var condText = new FlxText(wxIcon.x + 69, wxIcon.getGraphicMidpoint().y - 14, 0, forecasts[10].condition.text, 12);
        _10aUI.add(wxIcon);
        _10aUI.add(condText);
        hourForeUI.addGroup(_10aUI);
    }
    function setup11aUI() {
        _11aUI = new FlxUI(null, hourForeUI);
        _11aUI.name = "11 AM";
        
        var wxIcon:WeatherIcon = new WeatherIcon(15, 30, getIconVariant(forecasts[11].condition.icon), 11);
        
        var condText = new FlxText(wxIcon.x + 60, wxIcon.getGraphicMidpoint().y - 14, 0, forecasts[11].condition.text, 12);
        _11aUI.add(wxIcon);
        _11aUI.add(condText);
        hourForeUI.addGroup(_11aUI);
    }
    function setupNoonUI() {
        noonUI = new FlxUI(null, hourForeUI);
        noonUI.name = "Noon";
        
        var wxIcon:WeatherIcon = new WeatherIcon(15, 30, getIconVariant(forecasts[0].condition.icon), 12);
        
        var condText = new FlxText(wxIcon.x + 69, wxIcon.getGraphicMidpoint().y - 14, 0, forecasts[0].condition.text, 12);
        noonUI.add(wxIcon);
        noonUI.add(condText);
        hourForeUI.addGroup(noonUI);
    }
    function setup1pUI() {
        _1pUI = new FlxUI(null, hourForeUI);
        _1pUI.name = "1 PM";
        
        var wxIcon:WeatherIcon = new WeatherIcon(15, 30, getIconVariant(forecasts[13].condition.icon), 13);
        
        var condText = new FlxText(wxIcon.x + 69, wxIcon.getGraphicMidpoint().y - 14, 0, forecasts[13].condition.text, 12);
        
        _1pUI.add(wxIcon);
        _1pUI.add(condText);
        hourForeUI.addGroup(_1pUI);
    }
    function setup2pUI() {
        _2pUI = new FlxUI(null, hourForeUI);
        _2pUI.name = "2 PM";
        
        var wxIcon:WeatherIcon = new WeatherIcon(15, 30, getIconVariant(forecasts[14].condition.icon), 14);
        
        var condText = new FlxText(wxIcon.x + 69, wxIcon.getGraphicMidpoint().y - 14, 0, forecasts[14].condition.text, 12);
        
        _2pUI.add(wxIcon);
        _2pUI.add(condText);
        hourForeUI.addGroup(_2pUI);
    }
    function setup3pUI() {
        _3pUI = new FlxUI(null, hourForeUI);
        _3pUI.name = "3 PM";
        
        var wxIcon:WeatherIcon = new WeatherIcon(15, 30, getIconVariant(forecasts[15].condition.icon), 15);
        
        var condText = new FlxText(wxIcon.x + 69, wxIcon.getGraphicMidpoint().y - 14, 0, forecasts[15].condition.text, 12);
        
        _3pUI.add(wxIcon);
        _3pUI.add(condText);
        hourForeUI.addGroup(_3pUI);
    }
    function setup4pUI() {
        _4pUI = new FlxUI(null, hourForeUI);
        _4pUI.name = "4 PM";
        
        var wxIcon:WeatherIcon = new WeatherIcon(15, 30, getIconVariant(forecasts[16].condition.icon), 16);
        
        var condText = new FlxText(wxIcon.x + 69, wxIcon.getGraphicMidpoint().y - 14, 0, forecasts[16].condition.text, 12);
        
        _4pUI.add(wxIcon);
        _4pUI.add(condText);
        hourForeUI.addGroup(_4pUI);
    }
    function setup5pUI() {
        _5pUI = new FlxUI(null, hourForeUI);
        _5pUI.name = "5 PM";
        
        var wxIcon:WeatherIcon = new WeatherIcon(15, 30, getIconVariant(forecasts[17].condition.icon), 17);
        
        var condText = new FlxText(wxIcon.x + 69, wxIcon.getGraphicMidpoint().y - 14, 0, forecasts[17].condition.text, 12);
        
        _5pUI.add(wxIcon);
        _5pUI.add(condText);
        hourForeUI.addGroup(_5pUI);
    }
    function setup6pUI() {
        _6pUI = new FlxUI(null, hourForeUI);
        _6pUI.name = "6 PM";
        
        var wxIcon:WeatherIcon = new WeatherIcon(15, 30, getIconVariant(forecasts[18].condition.icon), 18);
        
        var condText = new FlxText(wxIcon.x + 69, wxIcon.getGraphicMidpoint().y - 14, 0, forecasts[18].condition.text, 12);
        
        _6pUI.add(wxIcon);
        _6pUI.add(condText);
        hourForeUI.addGroup(_6pUI);
    }
    function setup7pUI() {
        _7pUI = new FlxUI(null, hourForeUI);
        _7pUI.name = "7 PM";
        
        var wxIcon:WeatherIcon = new WeatherIcon(15, 30, getIconVariant(forecasts[19].condition.icon), 19);
        
        var condText = new FlxText(wxIcon.x + 69, wxIcon.getGraphicMidpoint().y - 14, 0, forecasts[19].condition.text, 12);
        
        _7pUI.add(wxIcon);
        _7pUI.add(condText);
        hourForeUI.addGroup(_7pUI);
    }
    function setup8pUI() {
        _8pUI = new FlxUI(null, hourForeUI);
        _8pUI.name = "8 PM";
        
        var wxIcon:WeatherIcon = new WeatherIcon(15, 30, getIconVariant(forecasts[20].condition.icon), 20);
        
        var condText = new FlxText(wxIcon.x + 69, wxIcon.getGraphicMidpoint().y - 14, 0, forecasts[20].condition.text, 12);
        
        _8pUI.add(wxIcon);
        _8pUI.add(condText);
        hourForeUI.addGroup(_8pUI);
    }
    function setup9pUI() {
        _9pUI = new FlxUI(null, hourForeUI);
        _9pUI.name = "9 PM";
        
        var wxIcon:WeatherIcon = new WeatherIcon(15, 30, getIconVariant(forecasts[21].condition.icon), 21);
        
        var condText = new FlxText(wxIcon.x + 69, wxIcon.getGraphicMidpoint().y - 14, 0, forecasts[21].condition.text, 12);
        
        _9pUI.add(wxIcon);
        _9pUI.add(condText);
        hourForeUI.addGroup(_9pUI);
    }
    function setup10pUI() {
        _10pUI = new FlxUI(null, hourForeUI);
        _10pUI.name = "10 PM";
        
        var wxIcon:WeatherIcon = new WeatherIcon(15, 30, getIconVariant(forecasts[22].condition.icon), 22);
        
        var condText = new FlxText(wxIcon.x + 69, wxIcon.getGraphicMidpoint().y - 14, 0, forecasts[22].condition.text, 12);
        
        _10pUI.add(wxIcon);
        _10pUI.add(condText);
        hourForeUI.addGroup(_10pUI);
    }
    function setup11pUI() {
        _11pUI = new FlxUI(null, hourForeUI);
        _11pUI.name = "11 PM";
        
        var wxIcon:WeatherIcon = new WeatherIcon(15, 30, getIconVariant(forecasts[23].condition.icon), 23);
        
        var condText = new FlxText(wxIcon.x + 69, wxIcon.getGraphicMidpoint().y - 14, 0, forecasts[23].condition.text, 12);
        
        _10pUI.add(wxIcon);
        _10pUI.add(condText);
        hourForeUI.addGroup(_11pUI);
    }
    
    function getIconVariant(icon:String) {
        var ehefh = icon.split('/');
        var iconFile:String = '';
        for (i in 0...ehefh.length) {
            if (ehefh[i].contains('png')) {
                iconFile = ehefh[i];
            }
        }
        return iconFile;
    }
}