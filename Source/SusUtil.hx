package;

import openfl.net.URLRequest;
import haxe.Exception;
import sys.FileSystem;
import sys.io.File;
import haxe.Http;
import flixel.FlxG;
import openfl.Lib;
import lime.app.Application.current as SusWindow;
import FlxUIDropDownMenuCustom.makeStrIdLabelArray as makeLabelArray;
using StringTools;

/**Utility class. Contains utilities for files and such.
@since v0.0.1*/
class SusUtil {
    static var API_Messages:Map<Int, String> = [
        -128 => "Icon file not found.\n\nIf you're using a build of this application from the Releases page, press 7 on the search screen. Then, press W to open your browser and download the icons from WeatherAPI. Once done, extract the zip file to " + Sys.getCwd().replace('\\', '/') + "Assets/Icons and relaunch the application. If it doesn't work, press 7 on the search screen and press I to open the issues page on GitHub. Create an issue about this.\n\nIf you're compiling from source, check the Documents/Icons.md file, as it contains a link to the weather icons. Just follow the same instructions as above.",
        0 => "So sorry, this application can only be used if an API key is set up in the source code.\n\nIf you're using this application from a release file on GitHub and seeing this message, please create an issue as the API key should be built in!\n\nIf you've built this application yourself, please check the WeatherKey variable in Source/APIKey.hx file and make sure your API key is in there! You can find instructions on how to get one by reading Documents/Building.md if necessary.",
        1002 => "API request not provided.\n\nIf you're using a build of this application from the Releases page, hold down 7 as you launch the application. This will bring up a menu. Press the I key to open the issues page, and create an issue.\n\nIf you're compiling from source, check any requests you have added to APIShit.hx or other files in the Source directory and see if your request string has \"?key=\" in it. If it has the key parameter and you still get this error, create an issue.",
        1003 => "API request did not include parameter 'q'.\n\nIf you're using a build of this application from the Releases page, hold down 7 as you launch the application. This will bring up a menu. Press the I key to open the issues page, and create an issue.\n\nIf you're compiling from source, check any requests you have added to APIShit.hx or other files in the Source directory and see if your request string has \"&q=\" in it. If it does and you still get this error, create an issue.",
        1005 => "API request URL is invalid.\n\nIf you're using a build of this application from the Releases page, hold down 7 as you launch the application. This will bring up a menu. Press the I key to open the issues page, and create an issue.\n\nIf you're compiling from source, check any requests you have added to APIShit.hx or other files in the Source directory and see if they exist in the WeatherAPI documentation. If they do and you still get this error, create an issue or contact WeatherAPI.",
        1006 => "No matching location found. Please try again.",
        2006 => "Provided API key is invalid.\n\nIf you're using a build of this application from the Releases page, hold down the 7 key as you launch the application. This will bring up a menu. Press I to open the issues page, and create an issue.\n\nIf you're building from source, please edit the Source/APIKey.hx file and input a new API key.",
        2007 => "Oh no, it looks like the WeatherAPI key you use for this software has reached the call limit for the month. You'll have to try again next month.",
        2008 => "API key has been disabled.\n\nIf you're using a build of this application from the Releases page, hold down the 7 key as you launch the application. This will bring up a menu. Press I to open the issues page, and create an issue.\n\nIf you're building from source and using your own API key, check your e-mails to see if WeatherAPI has sent you anything in regards to your API key.",
        9999 => "An internal error has occurred. Please try again."
    ];
    /**
        **WARNING:** This function will crash the application. Do not call it unless you are using it for LEGITIMATE errors!!
            
            Call this function when you get an error from WeatherAPI. Use the error code from the response.
            @since v0.0.1*/
    public static function API_Failure(Code:Int) {
        switch (Code) {
            case 0 | 1002 | 1003 | 1005 | 2006 | 2007 | 2008 | -128:
                throw new Exception(API_Messages[Code]);
            case 1006 | 9999:
                trace('e');
                SusWindow.window.alert(API_Messages[Code]);
        }
    }

    /**Opens a link in your default browser.
    @since v0.0.1*/
    public static function openLink(URL:String) {
        Lib.getURL(new URLRequest(URL));
    }

    /**Grabs the icon file for your forecast.
    @since v0.0.2*/
    public static function getWeatherIcon(IconPath:String) {
        var heh = IconPath.split('/'); // because its usually urls but we have the PNGs here in the source, im splitting
        var time:String = '';
        var icon:String = '';
        for (i in 0...heh.length) {
            if (heh[i] == 'day') {
                time = heh[i] + '/';
            } else if (heh[i] == 'night') {
                time = heh[i] + '/';
            } else if (heh[i].contains('.png')) {
                icon = heh[i];
            }
        }
        var imgPath = PathFinder.iconDirect(IMGS_PATH_ICON + time + icon);
        if (imgPath != 'not found') {
            return imgPath;
        } else {
            API_Failure(-128);
            return 'e';
        }
    }

    public static function makeDropList(data:Array<String>):Array<flixel.addons.ui.StrNameLabel> {
        return makeLabelArray(data, true);
    }
    static inline final IMGS_PATH_ICON = 'Assets/Icons/weather/64x64/';
}