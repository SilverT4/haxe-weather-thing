package settings;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.util.FlxColor;
import FNFAlphabet;
using StringTools;

class ActualSettingShit extends flixel.FlxState {
    var grpOptions:FlxTypedGroup<FNFAlphabet>;
    var optionList:Array<String> = [
        "Change temperature units",
        "Change search background",
        "Report an issue"
    ];

    public function new() {
        super();
        #if linux
        optionList.push("Set package manager");
        #end
        #if sys
        optionList.push("Manage save data...");
        #end
    }

    override function create() {
        var dumbfuck = FlxColor.gradient(0xFF000000, 0xFF696969, FlxG.width);
        for (colour in 0...dumbfuck.length) {
            var no = new FlxSprite(FlxG.width - colour, 0);
            no.makeGraphic(1, FlxG.height, dumbfuck[colour]);
            add(no);
        }
        grpOptions = new FlxTypedGroup<FNFAlphabet>();
        add(grpOptions);
        for (ind => opt in optionList) {
            var optText = new FNFAlphabet(0, (70 * ind), opt, true, false);
            optText.isMenuItem = true;
            optText.targetY = ind;
            grpOptions.add(optText);
        }
        changeSelection();
    }
    var curSelected:Int = 0;
    function changeSelection(change:Int = 0) {
        curSelected += change;

        if (curSelected < 0) {
            curSelected = optionList.length - 1;
        }
        if (curSelected >= optionList.length) {
            curSelected = 0;
        }

        var bullShit:Int = 0;
        for (item in grpOptions.members) {
            item.targetY = bullShit - curSelected;
            bullShit++;

            item.alpha = 0.6;

            if (item.targetY == 0) {
                item.targetY = 1;
            }
        }
    }
    override function update(elapsed:Float) {
        super.update(elapsed);
        var upP1 = FlxG.keys.justPressed.UP;
        var upP2 = FlxG.keys.justPressed.W;
        var downP1 = FlxG.keys.justPressed.DOWN;
        var downP2 = FlxG.keys.justPressed.S;
        var okay = FlxG.keys.justPressed.ENTER;
        if (upP1 || upP2) {
            changeSelection(-1);
        }

        if (downP1 || downP2) {
            changeSelection(1);
        }

        if (okay) {
            trace("OK!");
            switch(optionList[curSelected]) {
                case 'Report an issue':
                    trace(#if !web "LAUNCHING WEB BROWSER!" #else "OPENING WEBPAGE." #end);
                    SusUtil.openLink("https://github.com/devin503/haxe-weather-thing/issues");
                case 'Change temperature units':
                    openSubState(new settings.Temperature());
                case 'Change search background':
                    openSubState(new settings.BackgroundSettings());
                #if linux
                case 'Set package manager':
                    //wip
                #end
                #if sys
                case 'Manage save data...':
                    openSubState(new SaveManager());
                #end
            }
        }

        if (FlxG.random.int(0, 15) == 15) {
            trace('foreskin');
        }
    }
}