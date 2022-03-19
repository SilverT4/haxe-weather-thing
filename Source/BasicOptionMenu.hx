package;

import flixel.util.FlxColor;
import flixel.FlxG;
//import filxel.FlxText;
import flixel.FlxState;
import flixel.input.keyboard.FlxKey;
import flixel.text.FlxText;

using StringTools;

/**A very basic option menu. Uses FlxKeys to access different options.
@since v0.0.1*/
class BasicOptionMenu extends FlxState {
    public function new () {
        super();
    }

    override function create() {
        var optText = new FlxText(0,0,0, '**Basic Options Menu**', 12);
        optText.screenCenter(X);
        add(optText);
        var optList = new FlxText(0, 0, FlxG.width, 'Press the I key to open the GitHub issues page.', 16);
        optList.setFormat(null, 16, FlxColor.WHITE, CENTER);
        optList.screenCenter();
        add(optList);
    }

    override function update(elapsed:Float) {
        if (FlxG.keys.justPressed.I) {
            SusUtil.openLink('https://github.com/devin503/haxe-weather-thing/issues');
        }
    }
}