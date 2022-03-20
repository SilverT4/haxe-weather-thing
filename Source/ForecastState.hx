package;

import openfl.Lib;
import APIShit;
import flixel.FlxG;
import flixel.FlxState;
import flixel.FlxSprite;
import PogTools;
import flixel.addons.ui.FlxUITabMenu;
import flixel.addons.ui.FlxUI;
import flixel.ui.FlxButton;
import flixel.util.FlxTimer;
import flixel.text.FlxText;
import FlxUIDropDownMenuCustom;
import util.WeatherIcon;

class ForecastState extends FlxState {
    public static var location:ResponseForecast;
    var fc:ForecastThing;
    static var severeEvents:Array<String> = ['Tornado Warning', 'Hurricane Warning', 'Tropical Storm Warning', 'Flash Flood Warning', 'Flood Warning', 'Sus Warning']; // to start just these
    var astronomy:Array<String> = [];
    var alertEvents:Array<String> = [];
    var weatherAlerts:Array<WeatherAlert> = [];
    var ForecastUI:FlxUITabMenu;
    var alertThing:FlxUI;
    var astroThing:FlxUI;
    var dayThing:FlxUI;
    var hourThing:FlxUI;
    var nowThing:FlxUI;
    var alertCount:Int = 0;
    public function new () {
        super();
        trace('vagina');
        if (location != null) {
            weatherAlerts = location.alerts.alert;
            if (weatherAlerts.length > 0) {
                for (alert in weatherAlerts) {
                    alertEvents.push(alert.event);
                }
            }
            fc = location.forecast.forecastday[0];
        }
    }

    override function create() {
        alertCount = weatherAlerts.length;
        var tabs = [
            {name: 'Today', label: 'Today'},
            {name: 'Hourly', label: 'Hourly Forecast'},
            {name: 'Astronomy', label: 'Astronomy Forecast'},
            {name: 'Alerts', label: 'Weather Alerts ($alertCount)'},
            {name: 'Current', label: 'Your Current Conditions'}
        ];
        ForecastUI = new FlxUITabMenu(null, tabs);
        ForecastUI.resize(725, 500);
        ForecastUI.scrollFactor.set();
        ForecastUI.setPosition(FlxG.width - 750, 15);
        add(ForecastUI);
        add(new FlxText(0, 0, 0, 'WORK IN PROGRESS, PRESS ESC TO EXIT!'));
        // funcs go here but i need to make them first.
        addAlertUI();
        addAstroUI();
        addTodayUI();
        addNowUI();
        ForecastUI.selected_tab_id = 'Today';
        doAlertCheck();
    }

    override function update(elapsed:Float) {
        if (FlxG.keys.justPressed.ESCAPE) {
            #if sys
            Sys.exit(0);
            #else
            openSubState(new web.WebError('Escape key pressed. To use this application again,\nplease refresh the page.'));
            #end
        }
        super.update(elapsed); // to ensure updates even if i dont list it here.
    }
    var alertDropDown:FlxUIDropDownMenuCustom;
    var at_Event:FlxText;
    var at_areas:FlxText;
    var at_desc:FlxText;
    var at_headline:FlxText;
    var at_until:FlxText;

    function addNowUI() {
        nowThing = new FlxUI(null, ForecastUI);
        nowThing.name = 'Current';

        var curWeather:ResponseCurrent = location.current; // to get the current conditions

        var wxIcon:WeatherIcon = new WeatherIcon(15, 30, curWeather.condition.icon, SusUtil.getCurrentHour());

        var condText:FlxText = new FlxText(wxIcon.x + 69, wxIcon.y, 0, curWeather.condition.text, 8);

        if (LaunchState.temperatureUnits == 'F') {
            var temperatureText:FlxText = new FlxText(wxIcon.x + 69, condText.y + 10, 0, curWeather.temp_f + '\u2109', 16);
            var feelsLikeText:FlxText = new FlxText(temperatureText.x, temperatureText.y + 18, 0, curWeather.feelslike_f + '\u2109');
            nowThing.add(temperatureText);
            nowThing.add(feelsLikeText);
        } else {
            var temperatureText:FlxText = new FlxText(wxIcon.x + 69, condText.y + 10, 0, curWeather.temp_c + '\u2103');
            var feelsLikeText:FlxText = new FlxText(temperatureText.x, temperatureText.y + 18, 0, curWeather.feelslike_c + '\u2103');
            nowThing.add(temperatureText);
            nowThing.add(feelsLikeText);
        }

        nowThing.add(wxIcon);
        nowThing.add(condText);
        ForecastUI.addGroup(nowThing);
    }
    function addAlertUI() {
        alertThing = new FlxUI(null, ForecastUI);
        alertThing.name = 'Alerts';

        alertDropDown = new FlxUIDropDownMenuCustom(15, 30, FlxUIDropDownMenuCustom.makeStrIdLabelArray(['NO ALERTS'], true), function(alert:String) {
            loadAlert(weatherAlerts[Std.parseInt(alert)]);
        });
        reloadAlertDropDown(); // THIS WILL PUT THE EVENT NAMES IN!

        at_Event = new FlxText(alertDropDown.x, alertDropDown.y + 30, 0, 'Pick an alert first.', 12);

        at_headline = new FlxText(at_Event.x, at_Event.y + 14, 0, 'Local ' + #if sys Sys.systemName() #else 'browser' #end + ' user gets confused', 12);

        at_areas = new FlxText(at_Event.x, at_headline.y + 14, 0, 'N/A', 12);

        at_desc = new FlxText(at_areas.x, at_areas.y + 28, 0, 'No description', 12);

        at_until = new FlxText(at_areas.x, at_areas.y + 14, 0, 'Effective until you pick an alert.', 12);

        alertThing.add(new FlxText(alertDropDown.x, alertDropDown.y - 18, 0, 'Select an alert:', 8));
        alertThing.add(at_Event);
        alertThing.add(at_areas);
        alertThing.add(at_desc);
        alertThing.add(at_headline);
        alertThing.add(alertDropDown);
        ForecastUI.addGroup(alertThing);
    }

    function doAlertCheck() {
        for (event in alertEvents) {
            if (severeEvents.contains(event)) {
                doSevereInterrupt(2);
            }
        }
    }

    function doSevereInterrupt(delay:Float) {
        new FlxTimer().start(delay, function(tmr:FlxTimer) {
            FlxG.sound.play(PathFinder.sound('susSound'), 1, false, null, true, fancySwitch); // i'm hoping to make an animation thingy that plays instead of a camera fade effect
        });
    }

    function fancySwitch() {
        FlxG.camera.fade(0xFF000000, 1, false, function() {
            ForecastUI.selected_tab_id = 'Alerts';
            FlxG.camera.fade(0xFF000000, 1, true, function() {
                trace('e');
            });
        });
    }

    function addAstroUI() {
        astroThing = new FlxUI(null, ForecastUI);
        astroThing.name = 'Astronomy';

        var astron = PogTools.astro(fc.astro);

        var sunrText = new FlxText(15, 30, 0, 'Sunrise: ' + astron[0], 16);
        
        var sunsText = new FlxText(15, sunrText.y + 20, 0, 'Sunset: ' + astron[1], 16);

        var moonrText = new FlxText(15, sunsText.y + 20, 0, 'Moonrise: ' + astron[2], 16);

        var moonsText = new FlxText(15, moonrText.y + 20, 0, 'Moonset: ' + astron[3], 16);

        var moonPhase = new FlxText(15, moonsText.y + 20, 0, 'Moon phase: ' + astron[4], 16);

        var moonIllum = new FlxText(15, moonPhase.y + 20, 0, 'Moon illumination: ' + astron[5], 16);

        astroThing.add(sunrText);
        astroThing.add(sunsText);
        astroThing.add(moonrText);
        astroThing.add(moonsText);
        astroThing.add(moonPhase);
        astroThing.add(moonIllum);
        ForecastUI.addGroup(astroThing);
    }

    function addTodayUI() {
        dayThing = new FlxUI(null, ForecastUI);
        dayThing.name = 'Today';

        var wxIcon:WeatherIcon = new WeatherIcon(15, 30, fc.day.condition.icon, 12);

        var conditionText = new FlxText(wxIcon.x + 69, wxIcon.y + 10, 0, fc.day.condition.text, 8);

        if (LaunchState.temperatureUnits == 'F') {
            var tempText = new FlxText(wxIcon.x + 69, conditionText.y + 12, 0, fc.day.maxtemp_f + '/' + fc.day.mintemp_f, 8);
            dayThing.add(tempText);
        } else {
            var tempText = new FlxText(wxIcon.y + 69, conditionText.y + 12, 0, fc.day.maxtemp_c + '/' + fc.day.mintemp_c, 8);
            dayThing.add(tempText);
        }

        dayThing.add(wxIcon);
        dayThing.add(conditionText);
        ForecastUI.addGroup(dayThing);
    }

    function loadAlert(Alert:WeatherAlert) {
        trace('loading alert: ' + Alert.event);
        var alertValues = PogTools.alertInformation(Alert);

        at_Event.text = alertValues[7];
        at_Event.fieldWidth = 0;

        at_areas.text = alertValues[4];
        at_areas.fieldWidth = 0;

        at_desc.text = alertValues[11];
        at_desc.fieldWidth = 0;
        at_headline.text = alertValues[0];
        at_headline.fieldWidth = 0;
        at_until.text = alertValues[10];
        at_until.fieldWidth = 0;
    }
    function reloadAlertDropDown() {
        var droplist:Array<String> = [];
        if (alertEvents.length >= 1) {
            for (event in alertEvents) {
                droplist.push(event);
            }
        } else {
            droplist.push('No alerts');
        }
        alertDropDown.setData(SusUtil.makeDropList(droplist));
    }
}