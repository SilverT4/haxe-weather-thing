package;

import haxe.Json;
import SusUtil;
import PogTools;
import sys.FileSystem;
import flixel.graphics.frames.FlxAtlasFrames as FunnyFrames;
using StringTools;

/**Simple class to get certain files and check the existence of them as well.
@since v0.0.2*/
class PathFinder {
    static inline final AudioPath = 'Assets/Sounds/';
    static inline final IconPath = 'Assets/Icons/';
    static inline final WxIconPath_Day = 'Assets/Icons/weather/64x64/day/';
    static inline final WxIconPath_Night = 'Assets/Icons/weather/64x64/night/';
    static inline final ImagePath = 'Assets/Images/';
    static inline final AudioExt = #if web '.mp3' #else '.ogg' #end;
    /**Grabs a weather icon if you have the direct path to it in the application's files.
        @param key Path to the icon
        @returns key if the file exists, 'not found' if it does not.
        @since v0.0.2*/
    public static function iconDirect(key:String):String {
        if (FileSystem.exists(key + '.png')) 
            return key + '.png';
        return 'not found';
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
        return 'not found';
    }
    /**If you want to pull a funny prank, just create a louder version of an existing sound and use this function to play it.*/
    public static function loud_sound(key:String, ?directPath:String) {
        if (directPath != null) {
            if (exists(directPath + key + '-loud' + AudioExt)) return directPath + key + '-loud' + AudioExt;
        } else {
            if (exists(AudioPath + key + '-loud' + AudioExt)) return AudioPath + key + '-loud' + AudioExt;
        }
        return 'not found';
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
        return 'not found';
    }

    /**Grabs the correct icon for the WeatherIcon class.
        @param icon Icon.png file
        @param variant Day or night
        @since v0.0.2*/
    public static function getIcon(icon:String, variant:String) {
        if (variant == 'day' && exists(WxIconPath_Day + icon + '.png')) return WxIconPath_Day + icon + '.png';
        else if (variant == 'night' && exists(WxIconPath_Night + icon + '.png')) return WxIconPath_Night + icon + '.png';
        return 'not found';
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
        return FunnyFrames.fromSparrow('Assets/Images/speen.png', 'Assets/Images/speen.xml');
    }
    /**Check if a file exists.
        @param key Path to a file.
        @returns true if it exists, false if it does not.
        @since v0.0.2*/
    public static function exists(key:String) {
        if (FileSystem.exists(key)) return true;
        else return false;
    }
}