package;

import haxe.Json;
import SusUtil;
import PogTools;
import sys.FileSystem;

using StringTools;

/**Simple class to get certain files and check the existence of them as well.
@since v0.0.2*/
class PathFinder {
    static inline final AudioPath = 'Assets/Sounds/';
    /**Grabs a weather icon if you have the direct path to it in the application's files.
        @param key Path to the icon
        @returns key if the file exists, 'not found' if it does not.
        @since v0.0.2*/
    public static function iconDirect(key:String):String {
        if (FileSystem.exists(key)) 
            return key;
        return 'not found';
    }
    /**Grab a sound effect to play. This function is planned to be used in ForecastState in case of certain severe weather alerts.
        @param key Sound file name.
        @param directPath (Optional) Direct path to the sound. If this is not provided, the default sound path is used instead.
        @returns The sound if it exists, otherwise returns 'not found'
        @since v0.0.2*/
    public static function sound(key:String, ?directPath:String) {
        if (directPath != null) {
            if (exists(directPath + key)) return directPath + key;
        } else {
            if (exists(AudioPath + key)) return AudioPath + key;
        }
        return 'not found';
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