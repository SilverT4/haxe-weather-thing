package web;

import flixel.FlxG;
import flixel.FlxSubState;
import flixel.text.FlxText;
import flixel.FlxSprite;
import PathFinder;

using StringTools;

/**This is pretty much the "We can't continue" screen. If you see this on the GitHub.io page, just click the "Create an issue..." button and select "Weather App"
    @since v0.0.3*/
class WebError extends FlxSubState {
    var errorTxt:FlxText;
    var errorBg:FlxSprite;
    var err_Msg:String = "Oh no! Something's gone wrong.\n\nWe've encountered a fatal error and cannot continue.\nIf you're on the GitHub.io page, click on the\n\"Create an issue...\" button and select \"Weather App\".\nPlease include a screenshot of this error.\n\n";

    public function new(errorMsg:String) {
        super();
        err_Msg += errorMsg;
    }

    override function create() {
        FlxG.sound.play(PathFinder.sound('errorDoh'));
        errorBg = new FlxSprite(0).makeGraphic(FlxG.width, FlxG.height, 0xFF000000);
        add(errorBg);

        errorTxt = new FlxText(0, 0, 0, err_Msg, 16);
        errorTxt.setFormat(null, 16, 0xFFFFFFFF, CENTER);
        errorTxt.screenCenter();
        errorTxt.scrollFactor.set();
        add(errorTxt);
    }
}