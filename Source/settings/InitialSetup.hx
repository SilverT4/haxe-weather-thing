package settings;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.FlxState;
import flixel.ui.FlxBar;
import flixel.addons.ui.FlxUITabMenu;
import flixel.addons.ui.FlxUI;
import FlxUIDropDownMenuCustom;
import SusUtil;
import PogTools;
import PathFinder;
import LaunchState;

using StringTools;

/**Initial setup state. This appears the first time you launch the app.
    @since v0.0.2*/
class InitialSetup extends FlxState {
    var progBar:FlxBar;
    var progress:Int = 0;
    var stepCount:Int = 6;

    public function new() {
        super();
    }

    override function create() {
        var bg = new FlxSprite(0);
        bg.loadGraphic(PathFinder.image('rainBgDesat'));
        bg.screenCenter();
        bg.color = 0xFF00007F;
    }
}