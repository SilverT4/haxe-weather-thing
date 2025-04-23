package; // this class exists for discord rpc

import sys.io.Process;
import flixel.FlxState;
import flixel.FlxG;
import flixel.FlxSprite;
using StringTools;

/**
 * You have been banished to the poopy dimension
 */
class PoopyDimension extends FlxState {
    var poopyFile = 'poopy/poop';
    var yourDesktopLmao:String;
    var openFile = false;
    public function new(?writeFunny:String) {
        super();
        if (writeFunny != null) {
            yourDesktopLmao = lime.system.System.userDirectory + "/Desktop/bussy.txt";
            sys.io.File.write(yourDesktopLmao);
            sys.io.File.saveContent(yourDesktopLmao, writeFunny);
            openFile = true;
        }
    }

    override function create() {
        FlxG.sound.playMusic(PathFinder.sound('dooDooFeces'));
        var poopySprite = new FlxSprite(0, 0);
        poopySprite.loadGraphic(PathFinder.image(poopyFile + FlxG.random.int(1, 5)));
        poopySprite.setGraphicSize(FlxG.width, FlxG.height);
        poopySprite.screenCenter();
        add(poopySprite);
        FlxG.sound.play(PathFinder.sound("fart"), 1, false, null, true, function() {
            if (openFile) new Process("notepad", [yourDesktopLmao]);
            throw "You have been banished to the poopy dimension";
        });
        super.create();
    }
}