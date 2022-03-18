package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.FlxCamera;
import openfl.system.Capabilities;
import lime.app.Application;
import flixel.ui.FlxBar;
import flixel.ui.FlxButton;
import flixel.text.FlxText;

using StringTools;

/**The launch state. This contains variables used throughout the application, such as the icon theme.
@since v0.0.1 (March 2022)*/
class LaunchState extends FlxState {
    public static var iconTheme:String = ''; // I STILL NEED TO SET UP ICON THEMES.
    public static var temperatureUnits:String = ''; // THIS GETS SET IN THE SAVE DATA AFTER INITIAL SETUP, THOUGH THERE'LL ALSO BE A SETTINGS STATE.

    public function new() {
        super();
    }
}