package web;
#if web
import flixel.FlxG;
import flixel.FlxSubState;
import flixel.FlxSprite;
import flixel.text.FlxText;
import PathFinder;
import flixel.ui.FlxBar;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
using StringTools;

/**A less crashy variant of WebError. This is not the end of the road, if you see this it's most likely an error that can easily be continued from.
    @since v0.0.3*/
class WebNotice extends FlxSubState {
    var noticeBg:FlxSprite;
    var noticeTxt:FlxText;
    var notice_Msg:String = "Uh-oh, an error has occurred. Don't worry, you can easily return to what you were doing. Just need to let you know what happened.\n\n";
    var pressReturnDisp:FlxText;
    var pressReturnText:String = 'Please wait for the bar at the top to empty...';
    var timeoutBar:FlxBar;
    var timeout:Int = 5;

    public function new(msg:String) {
        super();
        notice_Msg += msg;
    }

    override function create() {
        noticeBg = new FlxSprite(0).makeGraphic(FlxG.width, FlxG.height, 0x69000000);
        add(noticeBg);

        noticeTxt = new FlxText(0, 0, 0, notice_Msg, 16);
        noticeTxt.setFormat(null, 16, 0xFFFFFFFF, CENTER);
        noticeTxt.screenCenter();
        noticeTxt.scrollFactor.set();
        add(noticeTxt);

        timeoutBar = new FlxBar(0, 0, RIGHT_TO_LEFT, 100, 16, this, 'timeout', 0, 5);
        timeoutBar.createGradientFilledBar(FlxColor.gradient(0xFFAACCFF, 0xFF00007F, 5), 1, 180, true, 0xFF000000);
        add(timeoutBar);

        pressReturnDisp = new FlxText(0, FlxG.height - 18, 0, pressReturnText, 16);
        pressReturnDisp.scrollFactor.set();
        add(pressReturnDisp);

        FlxG.sound.play(PathFinder.sound('errorOops'), 1);

        new FlxTimer().start(1, doCountdown, 6);
    }

    function doCountdown(tmr:FlxTimer):Void {
        timeout -= 1;
    }

    override function update(elapsed:Float) {
        super.update(elapsed);

        if (timeout <= 0) {
            pressReturnDisp.text = 'Press RETURN to continue.';
        }

        if (FlxG.keys.justPressed.ENTER && timeout <= 0) {
            close();
        }
    }
}
#else
import SusUtil;

class WebNotice extends FlxSubState {
    public function new(msg:String) {
        super();
        FlxG.log.error('penis');
        close();
    }
}
#end