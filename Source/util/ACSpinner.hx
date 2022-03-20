package util;

import flixel.FlxSprite;

class ACSpinner extends FlxSprite {
    public function spin() {
        if (animation.getByName('spin') != null) {
            animation.play('spin');
        }
    }

    public function stopSpin() {
        if (animation.getByName('spin-hold') != null) {
            animation.play('spin-hold');
        }
    }

    public function new(x:Float, y:Float) {
        super(x, y);
        frames = PathFinder.birdAtlas('speen');
        setupAnims();
    }

    @:noPrivateAccess
    function setupAnims() {
        animation.addByPrefix('spin', 'spinner go brr', 30, true);
        animation.addByIndices('spin-hold', 'spinner go brr', [0, 1], '', 30, false);
    }
}