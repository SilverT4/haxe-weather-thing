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
import flixel.text.FlxText;
import FlxUIDropDownMenuCustom;

class ForecastState extends FlxState {
    public static var location:ResponseForecast;
    var fc:ForecastThing;
    var astronomy:Array<String> = [];
    var alertEvents:Array<String> = [];
    var weatherAlerts:Array<WeatherAlert> = [];
    var ForecastUI:FlxUITabMenu;
    var alertThing:FlxUI;
    var astroThing:FlxUI;
    var dayThing:FlxUI;
    var hourThing:FlxUI;
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
        var tabs = [
            {name: 'Today', label: 'Today'},
            {name: 'Hourly', label: 'Hourly Forecast'},
            {name: 'Astronomy', label: 'Astronomy Forecast'},
            {name: 'Alerts', label: 'Weather Alerts ($alertCount)'}
        ];
        ForecastUI = new FlxUITabMenu(null, tabs);
        ForecastUI.resize(725, 500);
        ForecastUI.scrollFactor.set();
        ForecastUI.setPosition(FlxG.width - 750, 15);
        add(ForecastUI);
        add(new FlxText(0, 0, 0, 'WORK IN PROGRESS, PRESS ESC TO EXIT!'));
        // funcs go here but i need to make them first.
        addAlertUI();
    }

    override function update(elapsed:Float) {
        if (FlxG.keys.justPressed.ESCAPE) {
            Sys.exit(0);
        }
        super.update(elapsed); // to ensure updates even if i dont list it here.
    }
    var alertDropDown:FlxUIDropDownMenuCustom;
    var at_Event:FlxText;
    var at_areas:FlxText;
    function addAlertUI() {
        alertThing = new FlxUI(null, ForecastUI);
        alertThing.name = 'Alerts';

        alertDropDown = new FlxUIDropDownMenuCustom(15, 30, FlxUIDropDownMenuCustom.makeStrIdLabelArray(['NO ALERTS'], true), function(alert:String) {
            loadAlert(weatherAlerts[Std.parseInt(alert)]);
        });
        reloadAlertDropDown(); // THIS WILL PUT THE EVENT NAMES IN!

        at_Event = new FlxText(alertDropDown.x, alertDropDown.y + 18, 0, 'Pick an alert first.', 8);

        at_areas = new FlxText(at_Event.x, at_Event.y + 10, 0, 'N/A', 8);

        alertThing.add(new FlxText(alertDropDown.x, alertDropDown.y - 18, 0, 'Select an alert:', 8));
        alertThing.add(alertDropDown);
        alertThing.add(at_Event);
        alertThing.add(at_areas);
        ForecastUI.addGroup(alertThing);
    }

    function addAstroUI() {
        astroThing = new FlxUI(null, ForecastUI);
        astroThing.name = 'Astronomy';

        var astron = PogTools.astro(fc.astro);

        var sunrText = new FlxText(15, 30, 0, 'Sunrise: ' + astron[0], 16);
        
        var sunsText = new FlxText(15, sunrText.y + 20, 0, 'Sunset: ' + astron[1], 16);

        var moonrText = new FlxText(15, sunsText.y + 20, 0, 'Moonrise: ' + astron[2], 16);

        var moonsText = new FlxText(15, moonrText.y + 20, 0, 'Moonset: ' + astron[3], 16);

        var moonPhase = new FlxText(15, moonsText.y + 20, 0, 'Moon phase: ' + astron[4]);

        var moonIllum = new FlxText(15, moonPhase.y + 20, 0, 'Moon illumination: ' + astron[5], 16);
    }

    function loadAlert(Alert:WeatherAlert) {
        trace('loading alert: ' + Alert.event);
        var alertValues = PogTools.alertInformation(Alert);

        at_Event.text = alertValues[7];
        at_Event.fieldWidth = 0;

        at_areas.text = alertValues[4];
        at_areas.fieldWidth = 0;
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