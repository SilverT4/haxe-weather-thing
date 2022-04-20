package;

import flixel.FlxSprite;
import flixel.FlxG.mouse as susMouse;
import flixel.graphics.frames.FlxAtlasFrames;

/**A very basic custom mouse cursor. The assets are embedded at the moment but may be more modifiable in the future.
    @since 0.0.3 (early April 2022)*/
class CustomMouseCursor extends FlxSprite {
    var __cursorPath = "Assets/Images/Cursor";
    var OFFSET_SHIT:Map<String, Array<Int>> = [
        "idle" => [0, 0],
        "lonk" => [5, 0],
        "txt" => [4, 8]
    ];
    public function new() {
        super(0, 0);
        frames = FlxAtlasFrames.fromSparrow('$__cursorPath.png', '$__cursorPath.xml');
        animation.addByPrefix("idle", "IDLE CURSOR", 0, false);
        animation.addByPrefix("lonk", "ACTIVE CURSOR", 0, false);
        animation.addByPrefix("txt", "TEXT CURSOR", 0, false);
        animation.play("idle");
    }

    public function changeColor(NewColor:flixel.util.FlxColor) {
        this.color = NewColor;
    }

    public function switchAnim(NextAnim:String) {
        var pee = OFFSET_SHIT.get(NextAnim);
        if (OFFSET_SHIT.exists(NextAnim)) {
            offset.set(pee[0], pee[1]);
        } else {
            offset.set(0, 0);
        }
        animation.play(NextAnim);
    }

    override function update(elapsed:Float) {
        if (susMouse != null) {
            this.x = susMouse.x;
            this.y = susMouse.y;
        }
        super.update(elapsed);
    }
}