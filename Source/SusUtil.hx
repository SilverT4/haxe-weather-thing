package;

import openfl.net.URLRequest;
import haxe.Exception;
import sys.FileSystem;
import sys.io.File;
import haxe.Http;
import flixel.FlxG;
import openfl.Lib;
using StringTools;

/**Utility class. Contains utilities for files and such.
@since v0.0.1*/
class SusUtil {
    static var API_Messages:Map<Int, String> = [
        0 => "So sorry, this application can only be used if an API key is set up in the source code.\n\nIf you're using this application from a release file on GitHub and seeing this message, please create an issue as the API key should be built in!\n\nIf you've built this application yourself, please check the WeatherKey variable in Source/APIKey.hx file and make sure your API key is in there! You can find instructions on how to get one by reading Documents/Building.md if necessary.",
        1002 => "API request not provided.\n\nIf you're using a build of this application from the Releases page, hold down 7 as you launch the application. This will bring up a menu. Press the I key to open the issues page, and create an issue.\n\nIf you're compiling from source, check any requests you have added to APIShit.hx or other files in the Source directory and see if your request string has \"?key=\" in it. If it has the key parameter and you still get this error, create an issue.",
        1003 => "API request did not include parameter 'q'.\n\nIf you're using a build of this application from the Releases page, hold down 7 as you launch the application. This will bring up a menu. Press the I key to open the issues page, and create an issue.\n\nIf you're compiling from source, check any requests you have added to APIShit.hx or other files in the Source directory and see if your request string has \"&q=\" in it. If it does and you still get this error, create an issue.",
        1005 => "API request URL is invalid.\n\nIf you're using a build of this application from the Releases page, hold down 7 as you launch the application. This will bring up a menu. Press the I key to open the issues page, and create an issue.\n\nIf you're compiling from source, check any requests you have added to APIShit.hx or other files in the Source directory and see if they exist in the WeatherAPI documentation. If they do and you still get this error, create an issue or contact WeatherAPI.",
        1006 => "No matching location found.",
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
        throw new Exception(API_Messages[Code]);
    }

    /**Opens a link in your default browser.*/
    public static function openLink(URL:String) {
        Lib.getURL(new URLRequest(URL));
    }
}