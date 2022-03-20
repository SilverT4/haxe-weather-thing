package;

import haxe.Json;
import SusUtil;
import PogTools;
//import sys.FileSystem;
import flixel.graphics.frames.FlxAtlasFrames as FunnyFrames;
#if web
import openfl.utils.Assets;
#else
import sys.FileSystem;
#end
using StringTools;

/**Simple class to get certain files and check the existence of them as well.
@since v0.0.2*/
class PathFinder {
    static inline final ERROR_404 = 'not found';

    static inline final AudioPath = 'Assets/Sounds/'; // fuck
    static inline final IconPath = 'Assets/Icons/';
    static inline final WxIconPath_Day = 'Assets/Icons/weather/64x64/day/';
    static inline final WxIconPath_Night = 'Assets/Icons/weather/64x64/night/';
    static inline final ImagePath = 'Assets/Images/';
    static inline final PlaceholderPath = 'Assets/Placeholders/';
    static inline final AudioExt = #if web '.mp3' #else '.ogg' #end;
    /**Grabs a weather icon if you have the direct path to it in the application's files.
        @param key Path to the icon
        @returns key if the file exists, 'not found' if it does not.
        @since v0.0.2*/
    public static function iconDirect(key:String):String {
        if (exists(key + '.png')) 
            return key + '.png';
        return ERROR_404;
    }
    /**Grab a sound effect to play. This function is planned to be used in ForecastState in case of certain severe weather alerts.
        @param key Sound file name.
        @param directPath (Optional) Direct path to the sound. If this is not provided, the default sound path is used instead.
        @returns The sound if it exists, otherwise returns 'not found'
        @since v0.0.2*/
    public static function sound(key:String, ?directPath:String) {
        if (directPath != null) {
            if (exists(directPath + key + AudioExt)) return directPath + key + AudioExt;
        } else {
            if (exists(AudioPath + key + AudioExt)) return AudioPath + key + AudioExt;
        }
        return ERROR_404;
    }
    /**If you want to pull a funny prank, just create a louder version of an existing sound and use this function to play it.*/
    public static function loud_sound(key:String, ?directPath:String) {
        if (directPath != null) {
            if (exists(directPath + key + '-loud' + AudioExt)) return directPath + key + '-loud' + AudioExt;
        } else {
            if (exists(AudioPath + key + '-loud' + AudioExt)) return AudioPath + key + '-loud' + AudioExt;
        }
        return ERROR_404;
    }
    /**Grab an image (not icon).
        @param key Image filename.
        @param directPath (optional) Direct path to the image. If this is not provided, the default image path is used instead.
        @returns The image if it exists, otehrwise returns 'not found'
        @since v0.0.2*/
    public static function image(key:String, ?directPath:String) {
        if (directPath != null) {
            if (exists(directPath + key + '.png')) return directPath + key + '.png';
        } else {
            if (exists(ImagePath + key + '.png')) return ImagePath + key + '.png';
        }
        return ERROR_404;
    }
    /**Grab a placeholder JSON to prevent the application from crashing due to a null object reference.
        @param key The placeholder file name.
        @param directPath The placeholder's direct path (just the path leading up, don't add the file name!)
        @returns The JSON if it exists, otherwise returns 'not found'
        @since v0.0.2*/
    public static function getPlaceholder(key:String, ?directPath:String) {
        if (directPath != null) {
            if (exists(directPath + key + '.json')) return directPath + key + '.json';
        } else {
            if (exists(PlaceholderPath + key + '.json')) return PlaceholderPath + key + '.json';
        }
        return ERROR_404;
    }
    /**Grabs the correct icon for the WeatherIcon class.
        @param icon Icon.png file
        @param variant Day or night
        @since v0.0.2*/
    public static function getIcon(icon:String, variant:String) {
        var icpath:String = '';
        var icname:String = '';
        if (variant == 'day') icpath = WxIconPath_Day;
        else icpath = WxIconPath_Night;
        var heh = icon.split('/');
        for (i in 0...heh.length) {
            if (heh[i].contains('.png')) icname = heh[i];
        }
        if (exists(icpath + icname)) return icpath + icname;
        return ERROR_404;
    }
    /**Get the Sparrow atlas of a spritesheet.
        @param key The file name. This is used for both the png and xml files.
        @param directPath (Optional) The direct path. Don't add the file name, just the path leading up to it (plus a '/' at the end)
        @since v0.0.2*/
    public static function birdAtlas(key:String, ?directPath:String) {
        if (directPath != null) {
            if (exists(directPath + key + '.png') && exists(directPath + key + '.xml')) return FunnyFrames.fromSparrow(PathFinder.image(key, directPath), directPath + key + '.xml');
        } else {
            if (exists(ImagePath + key + '.png') && exists(ImagePath + key + '.xml')) return FunnyFrames.fromSparrow(PathFinder.image(key), ImagePath + key + '.xml');
        }
        return FunnyFrames.fromSparrow('Assets/Images/speen.png', 'Assets/Images/speen.xml'); // Placeholder in case the file requested is not found!
    }
    /**Check if a file exists.
        @param key Path to a file.
        @returns true if it exists, false if it does not.
        @since v0.0.2*/
    public static function exists(key:String) {
        #if sys
        if (FileSystem.exists(key)) return true;
        #else
        if (Assets.exists(key)) return true;
        #end
        else return false;
    }
}