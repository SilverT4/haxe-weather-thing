package;

import haxe.Json;
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
    var funnyThing:String = '{
        "alerts": {
            "alert": [
                {
                    "desc": "You have been amogus\'d.",
                    "urgency": "Expected",
                    "note": "Alert for Jiafei\'s Haunted House, CupcakKe\'s Dungeon, and Tesla Cvm\'s Mansion\nIssued by AMOGUS",
                    "event": "Tornado Warning",
                    "msgtype": "Alert",
                    "expires": "2022-03-20T23:45:00-05:00",
                    "headline": "Sus Warning issued Flop 69th at 4:20PM CDT until further notice by AMOGUS",
                    "severity": "Moderate",
                    "instruction": "Safety message - Don\'t be sus!",
                    "areas": "Jiafei\'s Haunted House, CupcakKe\'s Dungeon, Tesla Cvm\'s Mansion",
                    "category": "Met",
                    "effective": "2022-03-25T23:00:00-05:00",
                    "certainty": "Definite"
                }
            ]
        },
        "forecast": {
            "forecastday": [
                {
                    "hour": [
                        {
                            "chance_of_snow": 0,
                            "windchill_c": -5.4,
                            "uv": 1,
                            "vis_km": 10,
                            "dewpoint_f": 26.8,
                            "windchill_f": 22.3,
                            "wind_degree": 175,
                            "heatindex_c": -1.4,
                            "is_day": 0,
                            "feelslike_c": -5.4,
                            "heatindex_f": 29.5,
                            "will_it_snow": 0,
                            "feelslike_f": 22.3,
                            "wind_kph": 11.5,
                            "time": "2022-03-19 00:00",
                            "wind_mph": 7.2,
                            "pressure_mb": 1015,
                            "chance_of_rain": 0,
                            "humidity": 90,
                            "gust_kph": 24.1,
                            "cloud": 11,
                            "gust_mph": 15,
                            "wind_dir": "S",
                            "time_epoch": 1647666000,
                            "precip_mm": 0,
                            "temp_c": -1.4,
                            "condition": {
                                "code": 1000,
                                "icon": "//cdn.weatherapi.com/weather/64x64/night/113.png",
                                "text": "Clear"
                            },
                            "temp_f": 29.5,
                            "will_it_rain": 0,
                            "precip_in": 0,
                            "dewpoint_c": -2.9,
                            "pressure_in": 29.98,
                            "vis_miles": 6
                        },
                        {
                            "chance_of_snow": 0,
                            "windchill_c": -5,
                            "uv": 1,
                            "vis_km": 10,
                            "dewpoint_f": 26.6,
                            "windchill_f": 23,
                            "wind_degree": 187,
                            "heatindex_c": -1.3,
                            "is_day": 0,
                            "feelslike_c": -5,
                            "heatindex_f": 29.7,
                            "will_it_snow": 0,
                            "feelslike_f": 23,
                            "wind_kph": 10.4,
                            "time": "2022-03-19 01:00",
                            "wind_mph": 6.5,
                            "pressure_mb": 1015,
                            "chance_of_rain": 0,
                            "humidity": 88,
                            "gust_kph": 22,
                            "cloud": 18,
                            "gust_mph": 13.6,
                            "wind_dir": "S",
                            "time_epoch": 1647669600,
                            "precip_mm": 0,
                            "temp_c": -1.3,
                            "condition": {
                                "code": 1000,
                                "icon": "//cdn.weatherapi.com/weather/64x64/night/113.png",
                                "text": "Clear"
                            },
                            "temp_f": 29.7,
                            "will_it_rain": 0,
                            "precip_in": 0,
                            "dewpoint_c": -3,
                            "pressure_in": 29.97,
                            "vis_miles": 6
                        },
                        {
                            "chance_of_snow": 0,
                            "windchill_c": -4.7,
                            "uv": 1,
                            "vis_km": 10,
                            "dewpoint_f": 26.1,
                            "windchill_f": 23.5,
                            "wind_degree": 190,
                            "heatindex_c": -1.2,
                            "is_day": 0,
                            "feelslike_c": -4.7,
                            "heatindex_f": 29.8,
                            "will_it_snow": 0,
                            "feelslike_f": 23.5,
                            "wind_kph": 9.7,
                            "time": "2022-03-19 02:00",
                            "wind_mph": 6,
                            "pressure_mb": 1015,
                            "chance_of_rain": 0,
                            "humidity": 85,
                            "gust_kph": 20.5,
                            "cloud": 20,
                            "gust_mph": 12.8,
                            "wind_dir": "S",
                            "time_epoch": 1647673200,
                            "precip_mm": 0,
                            "temp_c": -1.2,
                            "condition": {
                                "code": 1000,
                                "icon": "//cdn.weatherapi.com/weather/64x64/night/113.png",
                                "text": "Clear"
                            },
                            "temp_f": 29.8,
                            "will_it_rain": 0,
                            "precip_in": 0,
                            "dewpoint_c": -3.3,
                            "pressure_in": 29.96,
                            "vis_miles": 6
                        },
                        {
                            "chance_of_snow": 0,
                            "windchill_c": -4.5,
                            "uv": 1,
                            "vis_km": 10,
                            "dewpoint_f": 25.3,
                            "windchill_f": 23.9,
                            "wind_degree": 198,
                            "heatindex_c": -1.2,
                            "is_day": 0,
                            "feelslike_c": -4.5,
                            "heatindex_f": 29.8,
                            "will_it_snow": 0,
                            "feelslike_f": 23.9,
                            "wind_kph": 9,
                            "time": "2022-03-19 03:00",
                            "wind_mph": 5.6,
                            "pressure_mb": 1014,
                            "chance_of_rain": 0,
                            "humidity": 83,
                            "gust_kph": 18.7,
                            "cloud": 25,
                            "gust_mph": 11.6,
                            "wind_dir": "SSW",
                            "time_epoch": 1647676800,
                            "precip_mm": 0,
                            "temp_c": -1.2,
                            "condition": {
                                "code": 1003,
                                "icon": "//cdn.weatherapi.com/weather/64x64/night/116.png",
                                "text": "Partly cloudy"
                            },
                            "temp_f": 29.8,
                            "will_it_rain": 0,
                            "precip_in": 0,
                            "dewpoint_c": -3.7,
                            "pressure_in": 29.96,
                            "vis_miles": 6
                        },
                        {
                            "chance_of_snow": 0,
                            "windchill_c": -4.5,
                            "uv": 1,
                            "vis_km": 10,
                            "dewpoint_f": 24.8,
                            "windchill_f": 23.9,
                            "wind_degree": 203,
                            "heatindex_c": -1.1,
                            "is_day": 0,
                            "feelslike_c": -4.5,
                            "heatindex_f": 30,
                            "will_it_snow": 0,
                            "feelslike_f": 23.9,
                            "wind_kph": 9.4,
                            "time": "2022-03-19 04:00",
                            "wind_mph": 5.8,
                            "pressure_mb": 1014,
                            "chance_of_rain": 0,
                            "humidity": 81,
                            "gust_kph": 19.8,
                            "cloud": 21,
                            "gust_mph": 12.3,
                            "wind_dir": "SSW",
                            "time_epoch": 1647680400,
                            "precip_mm": 0,
                            "temp_c": -1.1,
                            "condition": {
                                "code": 1000,
                                "icon": "//cdn.weatherapi.com/weather/64x64/night/113.png",
                                "text": "Clear"
                            },
                            "temp_f": 30,
                            "will_it_rain": 0,
                            "precip_in": 0,
                            "dewpoint_c": -4,
                            "pressure_in": 29.95,
                            "vis_miles": 6
                        },
                        {
                            "chance_of_snow": 0,
                            "windchill_c": -4.3,
                            "uv": 1,
                            "vis_km": 10,
                            "dewpoint_f": 24.6,
                            "windchill_f": 24.3,
                            "wind_degree": 209,
                            "heatindex_c": -0.9,
                            "is_day": 0,
                            "feelslike_c": -4.3,
                            "heatindex_f": 30.4,
                            "will_it_snow": 0,
                            "feelslike_f": 24.3,
                            "wind_kph": 9.7,
                            "time": "2022-03-19 05:00",
                            "wind_mph": 6,
                            "pressure_mb": 1014,
                            "chance_of_rain": 0,
                            "humidity": 79,
                            "gust_kph": 20.5,
                            "cloud": 32,
                            "gust_mph": 12.8,
                            "wind_dir": "SSW",
                            "time_epoch": 1647684000,
                            "precip_mm": 0,
                            "temp_c": -0.9,
                            "condition": {
                                "code": 1003,
                                "icon": "//cdn.weatherapi.com/weather/64x64/night/116.png",
                                "text": "Partly cloudy"
                            },
                            "temp_f": 30.4,
                            "will_it_rain": 0,
                            "precip_in": 0,
                            "dewpoint_c": -4.1,
                            "pressure_in": 29.93,
                            "vis_miles": 6
                        },
                        {
                            "chance_of_snow": 0,
                            "windchill_c": -3.8,
                            "uv": 1,
                            "vis_km": 10,
                            "dewpoint_f": 25.3,
                            "windchill_f": 25.2,
                            "wind_degree": 254,
                            "heatindex_c": -0.6,
                            "is_day": 0,
                            "feelslike_c": -3.8,
                            "heatindex_f": 30.9,
                            "will_it_snow": 0,
                            "feelslike_f": 25.2,
                            "wind_kph": 9,
                            "time": "2022-03-19 06:00",
                            "wind_mph": 5.6,
                            "pressure_mb": 1014,
                            "chance_of_rain": 0,
                            "humidity": 79,
                            "gust_kph": 18.7,
                            "cloud": 97,
                            "gust_mph": 11.6,
                            "wind_dir": "WSW",
                            "time_epoch": 1647687600,
                            "precip_mm": 0,
                            "temp_c": -0.6,
                            "condition": {
                                "code": 1009,
                                "icon": "//cdn.weatherapi.com/weather/64x64/night/122.png",
                                "text": "Overcast"
                            },
                            "temp_f": 30.9,
                            "will_it_rain": 0,
                            "precip_in": 0,
                            "dewpoint_c": -3.7,
                            "pressure_in": 29.93,
                            "vis_miles": 6
                        },
                        {
                            "chance_of_snow": 0,
                            "windchill_c": -3,
                            "uv": 1,
                            "vis_km": 10,
                            "dewpoint_f": 26.6,
                            "windchill_f": 26.6,
                            "wind_degree": 297,
                            "heatindex_c": 0,
                            "is_day": 0,
                            "feelslike_c": -3,
                            "heatindex_f": 32,
                            "will_it_snow": 0,
                            "feelslike_f": 26.6,
                            "wind_kph": 9,
                            "time": "2022-03-19 07:00",
                            "wind_mph": 5.6,
                            "pressure_mb": 1014,
                            "chance_of_rain": 0,
                            "humidity": 80,
                            "gust_kph": 18.7,
                            "cloud": 66,
                            "gust_mph": 11.6,
                            "wind_dir": "WNW",
                            "time_epoch": 1647691200,
                            "precip_mm": 0,
                            "temp_c": 0,
                            "condition": {
                                "code": 1006,
                                "icon": "//cdn.weatherapi.com/weather/64x64/night/119.png",
                                "text": "Cloudy"
                            },
                            "temp_f": 32,
                            "will_it_rain": 0,
                            "precip_in": 0,
                            "dewpoint_c": -3,
                            "pressure_in": 29.93,
                            "vis_miles": 6
                        },
                        {
                            "chance_of_snow": 0,
                            "windchill_c": -3.1,
                            "uv": 2,
                            "vis_km": 10,
                            "dewpoint_f": 28.4,
                            "windchill_f": 26.4,
                            "wind_degree": 317,
                            "heatindex_c": 0.5,
                            "is_day": 1,
                            "feelslike_c": -3.1,
                            "heatindex_f": 32.9,
                            "will_it_snow": 0,
                            "feelslike_f": 26.4,
                            "wind_kph": 11.5,
                            "time": "2022-03-19 08:00",
                            "wind_mph": 7.2,
                            "pressure_mb": 1014,
                            "chance_of_rain": 0,
                            "humidity": 83,
                            "gust_kph": 24.1,
                            "cloud": 27,
                            "gust_mph": 15,
                            "wind_dir": "NW",
                            "time_epoch": 1647694800,
                            "precip_mm": 0,
                            "temp_c": 0.5,
                            "condition": {
                                "code": 1003,
                                "icon": "//cdn.weatherapi.com/weather/64x64/day/116.png",
                                "text": "Partly cloudy"
                            },
                            "temp_f": 32.9,
                            "will_it_rain": 0,
                            "precip_in": 0,
                            "dewpoint_c": -2,
                            "pressure_in": 29.94,
                            "vis_miles": 6
                        },
                        {
                            "chance_of_snow": 0,
                            "windchill_c": -2.7,
                            "uv": 2,
                            "vis_km": 10,
                            "dewpoint_f": 29.7,
                            "windchill_f": 27.1,
                            "wind_degree": 324,
                            "heatindex_c": 1.1,
                            "is_day": 1,
                            "feelslike_c": -2.7,
                            "heatindex_f": 34,
                            "will_it_snow": 0,
                            "feelslike_f": 27.1,
                            "wind_kph": 13.3,
                            "time": "2022-03-19 09:00",
                            "wind_mph": 8.3,
                            "pressure_mb": 1015,
                            "chance_of_rain": 0,
                            "humidity": 84,
                            "gust_kph": 24.8,
                            "cloud": 18,
                            "gust_mph": 15.4,
                            "wind_dir": "NW",
                            "time_epoch": 1647698400,
                            "precip_mm": 0,
                            "temp_c": 1.1,
                            "condition": {
                                "code": 1000,
                                "icon": "//cdn.weatherapi.com/weather/64x64/day/113.png",
                                "text": "Sunny"
                            },
                            "temp_f": 34,
                            "will_it_rain": 0,
                            "precip_in": 0,
                            "dewpoint_c": -1.3,
                            "pressure_in": 29.96,
                            "vis_miles": 6
                        },
                        {
                            "chance_of_snow": 0,
                            "windchill_c": -0.7,
                            "uv": 2,
                            "vis_km": 10,
                            "dewpoint_f": 31.3,
                            "windchill_f": 30.7,
                            "wind_degree": 325,
                            "heatindex_c": 3,
                            "is_day": 1,
                            "feelslike_c": -0.7,
                            "heatindex_f": 37.4,
                            "will_it_snow": 0,
                            "feelslike_f": 30.7,
                            "wind_kph": 15.1,
                            "time": "2022-03-19 10:00",
                            "wind_mph": 9.4,
                            "pressure_mb": 1015,
                            "chance_of_rain": 0,
                            "humidity": 78,
                            "gust_kph": 23.4,
                            "cloud": 4,
                            "gust_mph": 14.5,
                            "wind_dir": "NW",
                            "time_epoch": 1647702000,
                            "precip_mm": 0,
                            "temp_c": 3,
                            "condition": {
                                "code": 1000,
                                "icon": "//cdn.weatherapi.com/weather/64x64/day/113.png",
                                "text": "Sunny"
                            },
                            "temp_f": 37.4,
                            "will_it_rain": 0,
                            "precip_in": 0,
                            "dewpoint_c": -0.4,
                            "pressure_in": 29.97,
                            "vis_miles": 6
                        },
                        {
                            "chance_of_snow": 0,
                            "windchill_c": 1.8,
                            "uv": 3,
                            "vis_km": 10,
                            "dewpoint_f": 32.9,
                            "windchill_f": 35.2,
                            "wind_degree": 329,
                            "heatindex_c": 5.3,
                            "is_day": 1,
                            "feelslike_c": 1.8,
                            "heatindex_f": 41.5,
                            "will_it_snow": 0,
                            "feelslike_f": 35.2,
                            "wind_kph": 16.9,
                            "time": "2022-03-19 11:00",
                            "wind_mph": 10.5,
                            "pressure_mb": 1015,
                            "chance_of_rain": 0,
                            "humidity": 71,
                            "gust_kph": 19.4,
                            "cloud": 2,
                            "gust_mph": 12.1,
                            "wind_dir": "NNW",
                            "time_epoch": 1647705600,
                            "precip_mm": 0,
                            "temp_c": 5.3,
                            "condition": {
                                "code": 1000,
                                "icon": "//cdn.weatherapi.com/weather/64x64/day/113.png",
                                "text": "Sunny"
                            },
                            "temp_f": 41.5,
                            "will_it_rain": 0,
                            "precip_in": 0,
                            "dewpoint_c": 0.5,
                            "pressure_in": 29.97,
                            "vis_miles": 6
                        },
                        {
                            "chance_of_snow": 0,
                            "windchill_c": 3.3,
                            "uv": 3,
                            "vis_km": 10,
                            "dewpoint_f": 32.2,
                            "windchill_f": 37.9,
                            "wind_degree": 330,
                            "heatindex_c": 6.4,
                            "is_day": 1,
                            "feelslike_c": 3.3,
                            "heatindex_f": 43.5,
                            "will_it_snow": 0,
                            "feelslike_f": 37.9,
                            "wind_kph": 16.2,
                            "time": "2022-03-19 12:00",
                            "wind_mph": 10.1,
                            "pressure_mb": 1015,
                            "chance_of_rain": 0,
                            "humidity": 64,
                            "gust_kph": 18.7,
                            "cloud": 8,
                            "gust_mph": 11.6,
                            "wind_dir": "NNW",
                            "time_epoch": 1647709200,
                            "precip_mm": 0,
                            "temp_c": 6.4,
                            "condition": {
                                "code": 1000,
                                "icon": "//cdn.weatherapi.com/weather/64x64/day/113.png",
                                "text": "Sunny"
                            },
                            "temp_f": 43.5,
                            "will_it_rain": 0,
                            "precip_in": 0,
                            "dewpoint_c": 0.1,
                            "pressure_in": 29.97,
                            "vis_miles": 6
                        },
                        {
                            "chance_of_snow": 0,
                            "windchill_c": 5.3,
                            "uv": 3,
                            "vis_km": 10,
                            "dewpoint_f": 32.9,
                            "windchill_f": 41.5,
                            "wind_degree": 322,
                            "heatindex_c": 7.9,
                            "is_day": 1,
                            "feelslike_c": 5.3,
                            "heatindex_f": 46.2,
                            "will_it_snow": 0,
                            "feelslike_f": 41.5,
                            "wind_kph": 15.5,
                            "time": "2022-03-19 13:00",
                            "wind_mph": 9.6,
                            "pressure_mb": 1015,
                            "chance_of_rain": 0,
                            "humidity": 60,
                            "gust_kph": 18,
                            "cloud": 2,
                            "gust_mph": 11.2,
                            "wind_dir": "NW",
                            "time_epoch": 1647712800,
                            "precip_mm": 0,
                            "temp_c": 7.9,
                            "condition": {
                                "code": 1000,
                                "icon": "//cdn.weatherapi.com/weather/64x64/day/113.png",
                                "text": "Sunny"
                            },
                            "temp_f": 46.2,
                            "will_it_rain": 0,
                            "precip_in": 0,
                            "dewpoint_c": 0.5,
                            "pressure_in": 29.96,
                            "vis_miles": 6
                        },
                        {
                            "chance_of_snow": 0,
                            "windchill_c": 6,
                            "uv": 3,
                            "vis_km": 10,
                            "dewpoint_f": 32.7,
                            "windchill_f": 42.8,
                            "wind_degree": 322,
                            "heatindex_c": 8.4,
                            "is_day": 1,
                            "feelslike_c": 6,
                            "heatindex_f": 47.1,
                            "will_it_snow": 0,
                            "feelslike_f": 42.8,
                            "wind_kph": 14.4,
                            "time": "2022-03-19 14:00",
                            "wind_mph": 8.9,
                            "pressure_mb": 1015,
                            "chance_of_rain": 0,
                            "humidity": 57,
                            "gust_kph": 16.6,
                            "cloud": 13,
                            "gust_mph": 10.3,
                            "wind_dir": "NW",
                            "time_epoch": 1647716400,
                            "precip_mm": 0,
                            "temp_c": 8.4,
                            "condition": {
                                "code": 1000,
                                "icon": "//cdn.weatherapi.com/weather/64x64/day/113.png",
                                "text": "Sunny"
                            },
                            "temp_f": 47.1,
                            "will_it_rain": 0,
                            "precip_in": 0,
                            "dewpoint_c": 0.4,
                            "pressure_in": 29.96,
                            "vis_miles": 6
                        },
                        {
                            "chance_of_snow": 0,
                            "windchill_c": 8.3,
                            "uv": 4,
                            "vis_km": 10,
                            "dewpoint_f": 34.9,
                            "windchill_f": 46.9,
                            "wind_degree": 324,
                            "heatindex_c": 10,
                            "is_day": 1,
                            "feelslike_c": 8.3,
                            "heatindex_f": 50,
                            "will_it_snow": 0,
                            "feelslike_f": 46.9,
                            "wind_kph": 12.2,
                            "time": "2022-03-19 15:00",
                            "wind_mph": 7.6,
                            "pressure_mb": 1014,
                            "chance_of_rain": 0,
                            "humidity": 56,
                            "gust_kph": 14,
                            "cloud": 2,
                            "gust_mph": 8.7,
                            "wind_dir": "NW",
                            "time_epoch": 1647720000,
                            "precip_mm": 0,
                            "temp_c": 10,
                            "condition": {
                                "code": 1000,
                                "icon": "//cdn.weatherapi.com/weather/64x64/day/113.png",
                                "text": "Sunny"
                            },
                            "temp_f": 50,
                            "will_it_rain": 0,
                            "precip_in": 0,
                            "dewpoint_c": 1.6,
                            "pressure_in": 29.95,
                            "vis_miles": 6
                        },
                        {
                            "chance_of_snow": 0,
                            "windchill_c": 7.8,
                            "uv": 3,
                            "vis_km": 10,
                            "dewpoint_f": 34.2,
                            "windchill_f": 46,
                            "wind_degree": 327,
                            "heatindex_c": 9.4,
                            "is_day": 1,
                            "feelslike_c": 7.8,
                            "heatindex_f": 48.9,
                            "will_it_snow": 0,
                            "feelslike_f": 46,
                            "wind_kph": 10.4,
                            "time": "2022-03-19 16:00",
                            "wind_mph": 6.5,
                            "pressure_mb": 1014,
                            "chance_of_rain": 0,
                            "humidity": 56,
                            "gust_kph": 11.9,
                            "cloud": 5,
                            "gust_mph": 7.4,
                            "wind_dir": "NNW",
                            "time_epoch": 1647723600,
                            "precip_mm": 0,
                            "temp_c": 9.4,
                            "condition": {
                                "code": 1000,
                                "icon": "//cdn.weatherapi.com/weather/64x64/day/113.png",
                                "text": "Sunny"
                            },
                            "temp_f": 48.9,
                            "will_it_rain": 0,
                            "precip_in": 0,
                            "dewpoint_c": 1.2,
                            "pressure_in": 29.95,
                            "vis_miles": 6
                        },
                        {
                            "chance_of_snow": 0,
                            "windchill_c": 8.2,
                            "uv": 3,
                            "vis_km": 10,
                            "dewpoint_f": 36,
                            "windchill_f": 46.8,
                            "wind_degree": 333,
                            "heatindex_c": 9.3,
                            "is_day": 1,
                            "feelslike_c": 8.2,
                            "heatindex_f": 48.7,
                            "will_it_snow": 0,
                            "feelslike_f": 46.8,
                            "wind_kph": 7.9,
                            "time": "2022-03-19 17:00",
                            "wind_mph": 4.9,
                            "pressure_mb": 1014,
                            "chance_of_rain": 0,
                            "humidity": 61,
                            "gust_kph": 9,
                            "cloud": 4,
                            "gust_mph": 5.6,
                            "wind_dir": "NNW",
                            "time_epoch": 1647727200,
                            "precip_mm": 0,
                            "temp_c": 9.3,
                            "condition": {
                                "code": 1000,
                                "icon": "//cdn.weatherapi.com/weather/64x64/day/113.png",
                                "text": "Sunny"
                            },
                            "temp_f": 48.7,
                            "will_it_rain": 0,
                            "precip_in": 0,
                            "dewpoint_c": 2.2,
                            "pressure_in": 29.95,
                            "vis_miles": 6
                        },
                        {
                            "chance_of_snow": 0,
                            "windchill_c": 8.8,
                            "uv": 3,
                            "vis_km": 10,
                            "dewpoint_f": 38.8,
                            "windchill_f": 47.8,
                            "wind_degree": 352,
                            "heatindex_c": 9.1,
                            "is_day": 1,
                            "feelslike_c": 8.8,
                            "heatindex_f": 48.4,
                            "will_it_snow": 0,
                            "feelslike_f": 47.8,
                            "wind_kph": 4.7,
                            "time": "2022-03-19 18:00",
                            "wind_mph": 2.9,
                            "pressure_mb": 1014,
                            "chance_of_rain": 0,
                            "humidity": 69,
                            "gust_kph": 5.4,
                            "cloud": 0,
                            "gust_mph": 3.4,
                            "wind_dir": "N",
                            "time_epoch": 1647730800,
                            "precip_mm": 0,
                            "temp_c": 9.1,
                            "condition": {
                                "code": 1000,
                                "icon": "//cdn.weatherapi.com/weather/64x64/day/113.png",
                                "text": "Sunny"
                            },
                            "temp_f": 48.4,
                            "will_it_rain": 0,
                            "precip_in": 0,
                            "dewpoint_c": 3.8,
                            "pressure_in": 29.95,
                            "vis_miles": 6
                        },
                        {
                            "chance_of_snow": 0,
                            "windchill_c": 7.1,
                            "uv": 3,
                            "vis_km": 10,
                            "dewpoint_f": 36.9,
                            "windchill_f": 44.8,
                            "wind_degree": 6,
                            "heatindex_c": 7.1,
                            "is_day": 1,
                            "feelslike_c": 7.1,
                            "heatindex_f": 44.8,
                            "will_it_snow": 0,
                            "feelslike_f": 44.8,
                            "wind_kph": 2.9,
                            "time": "2022-03-19 19:00",
                            "wind_mph": 1.8,
                            "pressure_mb": 1015,
                            "chance_of_rain": 0,
                            "humidity": 73,
                            "gust_kph": 4.7,
                            "cloud": 0,
                            "gust_mph": 2.9,
                            "wind_dir": "N",
                            "time_epoch": 1647734400,
                            "precip_mm": 0,
                            "temp_c": 7.1,
                            "condition": {
                                "code": 1000,
                                "icon": "//cdn.weatherapi.com/weather/64x64/day/113.png",
                                "text": "Sunny"
                            },
                            "temp_f": 44.8,
                            "will_it_rain": 0,
                            "precip_in": 0,
                            "dewpoint_c": 2.7,
                            "pressure_in": 29.97,
                            "vis_miles": 6
                        },
                        {
                            "chance_of_snow": 0,
                            "windchill_c": 2.9,
                            "uv": 1,
                            "vis_km": 10,
                            "dewpoint_f": 31.3,
                            "windchill_f": 37.2,
                            "wind_degree": 60,
                            "heatindex_c": 3.7,
                            "is_day": 0,
                            "feelslike_c": 2.9,
                            "heatindex_f": 38.7,
                            "will_it_snow": 0,
                            "feelslike_f": 37.2,
                            "wind_kph": 4.3,
                            "time": "2022-03-19 20:00",
                            "wind_mph": 2.7,
                            "pressure_mb": 1015,
                            "chance_of_rain": 0,
                            "humidity": 75,
                            "gust_kph": 9,
                            "cloud": 0,
                            "gust_mph": 5.6,
                            "wind_dir": "ENE",
                            "time_epoch": 1647738000,
                            "precip_mm": 0,
                            "temp_c": 3.7,
                            "condition": {
                                "code": 1000,
                                "icon": "//cdn.weatherapi.com/weather/64x64/night/113.png",
                                "text": "Clear"
                            },
                            "temp_f": 38.7,
                            "will_it_rain": 0,
                            "precip_in": 0,
                            "dewpoint_c": -0.4,
                            "pressure_in": 29.98,
                            "vis_miles": 6
                        },
                        {
                            "chance_of_snow": 0,
                            "windchill_c": 1.8,
                            "uv": 1,
                            "vis_km": 10,
                            "dewpoint_f": 30.7,
                            "windchill_f": 35.2,
                            "wind_degree": 92,
                            "heatindex_c": 3,
                            "is_day": 0,
                            "feelslike_c": 1.8,
                            "heatindex_f": 37.4,
                            "will_it_snow": 0,
                            "feelslike_f": 35.2,
                            "wind_kph": 5,
                            "time": "2022-03-19 21:00",
                            "wind_mph": 3.1,
                            "pressure_mb": 1016,
                            "chance_of_rain": 0,
                            "humidity": 77,
                            "gust_kph": 10.4,
                            "cloud": 3,
                            "gust_mph": 6.5,
                            "wind_dir": "E",
                            "time_epoch": 1647741600,
                            "precip_mm": 0,
                            "temp_c": 3,
                            "condition": {
                                "code": 1000,
                                "icon": "//cdn.weatherapi.com/weather/64x64/night/113.png",
                                "text": "Clear"
                            },
                            "temp_f": 37.4,
                            "will_it_rain": 0,
                            "precip_in": 0,
                            "dewpoint_c": -0.7,
                            "pressure_in": 29.99,
                            "vis_miles": 6
                        },
                        {
                            "chance_of_snow": 0,
                            "windchill_c": 0.3,
                            "uv": 1,
                            "vis_km": 10,
                            "dewpoint_f": 30.6,
                            "windchill_f": 32.5,
                            "wind_degree": 112,
                            "heatindex_c": 2.5,
                            "is_day": 0,
                            "feelslike_c": 0.3,
                            "heatindex_f": 36.5,
                            "will_it_snow": 0,
                            "feelslike_f": 32.5,
                            "wind_kph": 7.6,
                            "time": "2022-03-19 22:00",
                            "wind_mph": 4.7,
                            "pressure_mb": 1016,
                            "chance_of_rain": 0,
                            "humidity": 79,
                            "gust_kph": 15.8,
                            "cloud": 0,
                            "gust_mph": 9.8,
                            "wind_dir": "ESE",
                            "time_epoch": 1647745200,
                            "precip_mm": 0,
                            "temp_c": 2.5,
                            "condition": {
                                "code": 1000,
                                "icon": "//cdn.weatherapi.com/weather/64x64/night/113.png",
                                "text": "Clear"
                            },
                            "temp_f": 36.5,
                            "will_it_rain": 0,
                            "precip_in": 0,
                            "dewpoint_c": -0.8,
                            "pressure_in": 30,
                            "vis_miles": 6
                        },
                        {
                            "chance_of_snow": 0,
                            "windchill_c": -0.9,
                            "uv": 1,
                            "vis_km": 10,
                            "dewpoint_f": 30.4,
                            "windchill_f": 30.4,
                            "wind_degree": 125,
                            "heatindex_c": 1.9,
                            "is_day": 0,
                            "feelslike_c": -0.9,
                            "heatindex_f": 35.4,
                            "will_it_snow": 0,
                            "feelslike_f": 30.4,
                            "wind_kph": 9.4,
                            "time": "2022-03-19 23:00",
                            "wind_mph": 5.8,
                            "pressure_mb": 1016,
                            "chance_of_rain": 0,
                            "humidity": 82,
                            "gust_kph": 19.8,
                            "cloud": 2,
                            "gust_mph": 12.3,
                            "wind_dir": "SE",
                            "time_epoch": 1647748800,
                            "precip_mm": 0,
                            "temp_c": 1.9,
                            "condition": {
                                "code": 1000,
                                "icon": "//cdn.weatherapi.com/weather/64x64/night/113.png",
                                "text": "Clear"
                            },
                            "temp_f": 35.4,
                            "will_it_rain": 0,
                            "precip_in": 0,
                            "dewpoint_c": -0.9,
                            "pressure_in": 30,
                            "vis_miles": 6
                        }
                    ],
                    "day": {
                        "daily_will_it_snow": 0,
                        "maxwind_kph": 16.9,
                        "uv": 4,
                        "daily_will_it_rain": 0,
                        "maxwind_mph": 10.5,
                        "avgvis_km": 10,
                        "totalprecip_mm": 0,
                        "avghumidity": 75,
                        "daily_chance_of_snow": 0,
                        "daily_chance_of_rain": 0,
                        "totalprecip_in": 0,
                        "mintemp_c": -1.4,
                        "avgtemp_c": 3.4,
                        "condition": {
                            "code": 1000,
                            "icon": "//cdn.weatherapi.com/weather/64x64/day/260.png",
                            "text": "Sussy"
                        },
                        "maxtemp_c": 10,
                        "avgtemp_f": 38.1,
                        "mintemp_f": 69,
                        "avgvis_miles": 6,
                        "maxtemp_f": 100
                    },
                    "date_epoch": 1647648000,
                    "date": "2022-03-19",
                    "astro": {
                        "moon_illumination": "69",
                        "moon_phase": "Waxing Penis",
                        "moonset": "04:10 AM",
                        "sunrise": "04:20 AM",
                        "sunset": "04:20 PM",
                        "moonrise": "05:30 PM"
                    }
                }
            ]
        },
        "current": {
            "uv": 3,
            "vis_km": 10,
            "last_updated": "2022-03-19 20:45",
            "gust_kph": 4.7,
            "humidity": 73,
            "wind_degree": 6,
            "gust_mph": 2.9,
            "cloud": 0,
            "wind_dir": "N",
            "is_day": 0,
            "feelslike_c": 7.1,
            "temp_c": 7.1,
            "precip_mm": 0,
            "feelslike_f": 44.8,
            "temp_f": 44.8,
            "condition": {
                "code": 1000,
                "icon": "//cdn.weatherapi.com/weather/64x64/night/113.png",
                "text": "Sunny"
            },
            "wind_kph": 2.9,
            "last_updated_epoch": 1647740700,
            "precip_in": 0,
            "wind_mph": 1.8,
            "vis_miles": 6,
            "pressure_mb": 1015,
            "pressure_in": 29.97
        },
        "location": {
            "localtime": "2022-03-19 20:47",
            "tz_id": "America/Chicago",
            "region": "North Dakota",
            "localtime_epoch": 1647740858,
            "country": "United States of America",
            "lon": -97.6,
            "name": "Enderlin",
            "lat": 46.62
        }
    }';
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
        //ed.visible = false;
        ed.dance();
        add(ed);
        trace(ed);

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
            if (ed.animation.curAnim.finished) ed.dance();
            /* if (FlxG.keys.justPressed.L && !blockInput) {
                ed.visible = true;
                ed.jumpscare();
            } */
        }

        if (FlxG.keys.justPressed.L && !blockInput) {
            ed.animation.play('wellWellWell');
            FlxG.sound.play(PathFinder.loud_sound('theFunnyWell'), 1, false, null, true, function() {
                trace('you have been well well well\'d');
            });
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
            #if debug
            if (searchInputBox.text == 'amogus') {
                forecastLocation = cast Json.parse(funnyThing);
                openForecastState();
            } else {
                doSearch(searchInputBox.text);
            }
            #else
                doSearch(searchInputBox.text);
            #end
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
        _parentState.persistentUpdate = false; // so speen stops
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
        forecastLocation = APIShit.getForecast(locations[0].name + ', ' + locations[0].region);
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