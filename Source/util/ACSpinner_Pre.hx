package util;

import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.display.Sprite;
import openfl.display.Stage;

class ACSpinner_Pre extends Sprite {
    public function spin() {
        /*if (animation.getByName('spin') != null) {
            animation.play('spin');
        }*/
    }

    public function stopSpin() {
        /*if (animation.getByName('spin-hold') != null) {
            animation.play('spin-hold');
        }*/
    }

    public function new(x:Float, y:Float) {
        super();
        BitmapData.loadFromFile("assets/images/speen.png").onComplete(function (shitmapData) {
            var shitmap = new Bitmap(shitmapData);
            addChild(shitmap);
        });
        this.x = x;
        this.y = y;
    }

    @:noPrivateAccess
    function setupAnims() {
        //animation.addByPrefix('spin', 'spinner go brr', 30, true);
        //animation.addByIndices('spin-hold', 'spinner go brr', [0, 1], '', 30, false);
    }
}