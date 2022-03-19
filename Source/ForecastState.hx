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

class ForecastState extends FlxState {
    public static var location:ResponseForecast;
    var astronomy:Array<String> = [];
    var alertEvents:Array<String> = [];
    var weatherAlerts:Array<WeatherAlert> = [];
    var ForecastUI:FlxUITabMenu;
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

        add(new FlxText(0, 0, 0, 'WORK IN PROGRESS, PRESS ESC TO EXIT!'));
    }

    override function update(elapsed:Float) {
        if (FlxG.keys.justPressed.ESCAPE) {
            Sys.exit(0);
        }
        super.update(elapsed); // to ensure updates even if i dont list it here.
    }
}