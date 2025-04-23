package settings;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import FNFAlphabet;
using StringTools;

class Temperature extends flixel.FlxSubState {
    var optionList:Array<String> = [
        "Fahrenheit",
        "Celsius",
        "Exit"
    ];
    var hintTxt:FlxText;
    var selectedIndic:FNFAlphabet;
    var rightIndic:FNFAlphabet;
    var grpOpts:FlxTypedGroup<FNFAlphabet>;
    var curSelected:Int = 0;
    public function new() {
        super();
    }

    override function create() {
        var bg = new FlxSprite();
        bg.makeGraphic(FlxG.width, FlxG.height, 0x69A6D388);
        add(bg);
        grpOpts = new FlxTypedGroup();
        add(grpOpts);
        for (clit => dildo in optionList)
            {
                var optionText:FNFAlphabet = new FNFAlphabet(0, 0, dildo, true, false);
                optionText.screenCenter();
                optionText.y += (100 * (clit - (optionList.length / 2))) + 50;
                grpOpts.add(optionText);
            }
        selectedIndic = new FNFAlphabet(0, 0, ">", true, false);
        add(selectedIndic);
        rightIndic = new FNFAlphabet(0, 0, "<", true, false);
        add(rightIndic);
        hintTxt = new FlxText(0, 25, 0, "What temperature units do you prefer?", 16);
        hintTxt.screenCenter(X);
        add(hintTxt);
    }

    override function update(elapsed:Float) {
        super.update(elapsed);
        var upP1 = FlxG.keys.justPressed.UP;
        var upP2 = FlxG.keys.justPressed.W;
        var downP1 = FlxG.keys.justPressed.DOWN;
        var downP2 = FlxG.keys.justPressed.S;
        var okay = FlxG.keys.justPressed.ENTER;
        var bacc = FlxG.keys.justPressed.ESCAPE;

        if (upP1 || upP2) {
            changeSelection(-1);
        }

        if (downP1 || downP2) {
            changeSelection(1);
        }

        if (okay) {
            if (optionList[curSelected] != "Exit") {
                trace("Changing units!");
                FlxG.save.data.temperature = optionList[curSelected];
                selectedIndic.x = grpOpts.members[curSelected].x - 63;
                selectedIndic.y = grpOpts.members[curSelected].y;
            } else {
                exit();
            }
        }

        if (bacc) {
            exit();
        }
    }

    function exit() {
        FlxG.save.flush();
        close();
    }

    function changeSelection(change:Int = 0) {
		curSelected += change;
		if (curSelected < 0)
			curSelected = optionList.length - 1;
		if (curSelected >= optionList.length)
			curSelected = 0;

		var bullShit:Int = 0;

		for (item in grpOpts.members) {
			item.targetY = bullShit - curSelected;
			bullShit++;

			item.alpha = 0.6;
			if (item.targetY == 0) {
				item.alpha = 1;
				//selectorLeft.x = item.x - 63;
				//selectorLeft.y = item.y;
				rightIndic.x = item.x + item.width + 15;
				rightIndic.y = item.y;
			}
		}
    }
}