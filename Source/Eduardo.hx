package;

import flixel.FlxSprite;
import PathFinder;

using StringTools;
#if !GH_IO
/**Well well well.
    @since WELL WELL WELL. (v0.0.2)*/
class Eduardo extends FlxSprite {
    var doinJumpscare:Bool = false;
    public function jumpscare() {
        if (animation.getByName('wellWellWell') != null) {
            doinJumpscare = true;
            scale.scale(5);
            updateHitbox();
            setPosition(0, 0);
            screenCenter(X);
            animation.play('wellWellWell');
            flixel.FlxG.sound.play(PathFinder.loud_sound('theFunnyWell'), 1, false, null, true, function() {
                throw new haxe.Exception('You have been WELL WELL WELL\'D!\n\nSend this to a friend to totally WELL WELL WELL them!');
            });
        }
    }

    public function spawnJumpscare() {
        if (animation.getByName('wellWellWell') != null) {
            doinJumpscare = true;
            scale.scale(5);
            updateHitbox();
            setPosition(0, 0);
            screenCenter(X);
            animation.play('wellWellWell');
            flixel.FlxG.sound.play(PathFinder.loud_sound('theFunnyWell'), 1, false, null, true, function() {
                throw new haxe.Exception('You have been WELL WELL WELL\'D!\n\nSend this to a friend to totally WELL WELL WELL them!');
            });
        }
        return this;
    }
    public function new(x:Float, y:Float) {
        super(x, y);
        frames = PathFinder.birdAtlas('Eduardo');
        animation.addByPrefix('idle', 'EduardoIdle', 24, false);
        animation.addByIndices('wellWellWell', 'EduardoWell', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11], '', 24, false);
        animation.play('idle');
        antialiasing = false;
    }

    public function dance() {
        if (animation.curAnim.finished && !doinJumpscare) {
            animation.play('idle');
        }
    }
}
#else
class Eduardo {
    public function dance() {
        trace('placeholder');
    }
    public function new(x:Float, y:Float) {
        trace(x + ", " + y); // just traces since Eduardo is his own class in GH.io builds!
    }
    public function jumpscare() {
        trace("well well well");
        if (flixel.FlxG.state != null) flixel.FlxG.state.openSubState(new web.WebNotice("Well Well Well")); // bc yes
    }
    public function spawnJumpscare() {
        jumpscare(); // just because it might be easier
    }
}
#end