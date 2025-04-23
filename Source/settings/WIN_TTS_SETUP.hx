package settings;

#if (windows && sys)
import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.FlxSprite;
import winUtils.Balabolka;
import TextToSpeech;
using StringTools;

class WIN_TTS_SETUP extends FlxState {
    var ttsSources:Array<String> = [
        "PowerShell",
        "Balabolka"
    ];
    var sourceDescs:Array<String> = [
        "PowerShell uses APIs built-in to the Windows OS to provide text to speech.",
        "Balabolka uses a standalone process (included with the app) to provide text to speech. It also provides the ability to use any voice installed on your PC."
    ];
}
#end