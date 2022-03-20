package web;

#if web
import js.html.Window;
import js.html.Location;
import lime.net.oauth.OAuthToken.RefreshToken;
import lime.app.Application;
import openfl.system.System;
import flixel.ui.FlxButton;
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
    var hintTxt:String = '';
    var hintDisp:FlxText;
    var resetButton:FlxButton;

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

        if (err_Msg.contains('-999')) {
            hintTxt = 'Psst! Press R or click this button to reset your save data -->';
            hintDisp = new FlxText(0, FlxG.height - 18, 0, hintTxt, 16);
            add(hintDisp);
            resetButton = new FlxButton(hintDisp.width + 100, hintDisp.y, 'RESET', doSaveReset);
            resetButton.color = 0xFFFF0000;
            resetButton.label.color = 0xFF000000;
            add(resetButton);
        }
    }

    override function update(elapsed:Float) {
        if (err_Msg.contains('-999') && FlxG.keys.justPressed.R) {
            doSaveReset();
        }
        super.update(elapsed);
    }
    var jfdk:Location;
    function doSaveReset() {
        trace('reset');
        FlxG.save.erase();
        jfdk.reload();
    }
}
#else
import SusUtil;

class WebError extends FlxSubState {
    public function new(msg:String) {
        super();
        FlxG.log.error('penis');
        close();
    }
}
#end