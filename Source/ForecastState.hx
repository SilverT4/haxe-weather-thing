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
    var astronomy:Array<String> = [];
    var alertEvents:Array<String> = [];
    var weatherAlerts:Array<WeatherAlert> = [];
    var ForecastUI:FlxUITabMenu;
    var alertThing:FlxUI;
    var alertCount:Int = 0;
    public function new () {
        super();
        trace('vagina');
        if (location != null) {
            if (location.forecastday.alerts != null) {
                alertEvents = PogTools.alertNameDrop(location.forecastday.alerts);
                trace(alertEvents);
                weatherAlerts = location.forecastday.alerts.alert;
                alertCount = alertEvents.length;
            }
            if (location.forecastday.astro != null) {
                astronomy = PogTools.astro(location.forecastday.astro);
                trace(astronomy);
            }
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

        alertThing.add(at_Event);
        alertThing.add(at_areas);
        ForecastUI.addGroup(alertThing);
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