package;

import util.ACSpinner;
import flixel.FlxG;
import flixel.FlxState;
#if sys
import sys.FileSystem;
#end
import openfl.utils.Assets;
import flixel.FlxSprite;
import flixel.ui.FlxBar;
import flixel.util.FlxTimer;
import flixel.text.FlxText;
using StringTools;

class AssetLoadingState extends FlxState {
    var AssetsToLoad:Array<Dynamic>;
    var loadBar:FlxBar;
    var loadedAssets:Int = 0;
    var totalAssets:Int;
    var spinner:ACSpinner;
    public function new() {
        super();
        AssetsToLoad = Assets.list(null);
        totalAssets = AssetsToLoad.length;
    }

    override function create() {
        trace("pp");
        spinner = new ACSpinner(1232, 672);
        add(spinner);
        spinner.spin();
        loadBar = new FlxBar(15, 100, LEFT_TO_RIGHT, 420, 20, this, 'loadedAssets', 0, totalAssets);
        loadBar.createFilledBar(0xFFFF0000, 0xFF00FF00);
        add(loadBar);
        getAndLoadAssets();
    }

    function getAndLoadAssets() {
        trace("Preparing to load assets. This may take a while, depending on how many assets need to be loaded.");
        for (ind => asset in AssetsToLoad) {
            var bitch = asset.split('.');
            var extension = bitch[bitch.length -1];
            switch(extension) {
                case 'png':
                    Assets.loadBitmapData(asset, true).onComplete(function(fartMap) {
                        pee(asset, ind);
                    });
                case 'xml' | 'json':
                    Assets.loadText(asset).onComplete(function(fard) {
                        pee(asset, ind);
                        trace(fard);
                    });
                case 'mp3' | 'ogg':
                    Assets.loadSound(asset, true).onComplete(function(shid) {
                        pee(asset, ind);
                    });
            }
        }
    }

    function pee(f, ind:Int) {
        var tit = ind + 1;
        trace('Asset loaded: $f ($tit of ' + AssetsToLoad.length + ')');
        loadedAssets += 1;
        trace('Number of assets loaded/Total asset count: $loadedAssets/$totalAssets');
    }
}