package settings;

import flixel.util.FlxTimer;
import flixel.ui.FlxButton;
import flixel.FlxSprite;
import flixel.FlxG;
import flixel.FlxState;
import flixel.ui.FlxBar;
import flixel.addons.ui.FlxUITabMenu;
import flixel.addons.ui.FlxUI;
import flixel.text.FlxText;
import FlxUIDropDownMenuCustom;
import SusUtil;
import PogTools;
import PathFinder;
import LaunchState;

using StringTools;

/**Initial setup state. This appears the first time you launch the app.
    @since v0.0.2*/
class InitialSetup extends FlxState {
    var progBar:FlxBar;
    var progress:Int = 0;
    var stepCount:Int = 6;
    var curStep:Int = 0;
    var needSwitch:Bool = false;
    var jej:FlxText; // intro text stuff
    var hintText:FlxText;

    public function new() {
        super();
    }

    override function create() {
        #if desktop FlxG.sound.playMusic(PathFinder.sound('funnyinst'), 0.8); #end
        var bg = new FlxSprite(0);
        bg.loadGraphic(PathFinder.image('rainBgDesat'));
        bg.setGraphicSize(Std.int(bg.width * 1.25));
        bg.screenCenter();
        bg.color = 0xFF00007F;
        add(bg);
        curStep = 1;
        progress = Std.int((curStep / stepCount) * 100);
        trace((curStep / stepCount) * 100);
        progBar = new FlxBar(0, 0, LEFT_TO_RIGHT, 150, 32, this, 'progress', 0, 100, true);
        progBar.screenCenter(X);
        add(progBar);
        jej = new FlxText(0, 0, 0, 'Welcome!\n\nThis application can display the weather for your area or another area.\n\nAll you need to do is type in the location you want to look at,\nand then you can see the forecast!\n\nBefore you can start, though, we\'d like to do a quick setup.', 16);
        jej.setFormat(null, 16, 0xFFFFFFFF, CENTER);
        jej.screenCenter();
        add(jej);

        hintText = new FlxText(0, FlxG.height - 14, 0, 'Press ENTER to continue', 12);
        add(hintText);
    }

    override function update(elapsed:Float) {
        if (FlxG.keys.justPressed.ENTER && curStep != 2) {
            curStep += 1;
            switchScreen(curStep);
        }

        if (FlxG.keys.justPressed.ENTER && blockEnter) {
            trace('oops');
            FlxG.sound.play(PathFinder.sound('fart'));
            hintText.text = 'Please use the OK button here!';
        }

        if (readyToExit && FlxG.keys.justPressed.ENTER) {
            FlxG.save.data.finishedSetup = true;
            FlxG.sound.music.fadeOut(1.5, 0, function(twn:flixel.tweens.FlxTween) {
                trace('pp');
                FlxG.save.flush();
                Sys.exit(0);
            });
        }

        super.update(elapsed);
    }
    var blockEnter:Bool = false;
    function switchScreen(stepNext:Int) {
        if (blockEnter) blockEnter = false;
        progress = Std.int((curStep / stepCount) * 100);
        trace('bussy');
        trace(progress);
        switch (stepNext) {
            case 2:
                doUnitQuestion();
            case 3:
                explainSearchScreen();
            case 4:
                explainForecastScreen();
            case 5:
                explainAstroAlerts();
            case 6:
                finishUp();
        }
    }
    var readyToExit:Bool = false;
    var unitDrop:FlxUIDropDownMenuCustom;
    var okButton_Unit:FlxButton;
    function doUnitQuestion() {
        jej.kill(); // i'm keeping it for later.
        hintText.text = 'What temperature unit do you prefer? Farhenheit or Celsius?';

        unitDrop = new FlxUIDropDownMenuCustom(100, 250, SusUtil.makeDropList(['Farhenheit', 'Celsius']), function(unit:String) {
            if (unit == '0') {
                LaunchState.temperatureUnits = 'F';
                FlxG.save.data.tempUnits = ['F', 'mi'];
            } else {
                LaunchState.temperatureUnits = 'C';
                FlxG.save.data.tempUnits = ['C', 'km'];
            }
        });

        add(unitDrop);

        okButton_Unit = new FlxButton(unitDrop.x + 160, unitDrop.y, 'OK', function() {
            if (curStep == 2) {
                curStep += 1;
                switchScreen(curStep);
            } else {
                FlxG.sound.play(PathFinder.sound('reverbFart'), 1, false, null, true, hideButton);
            }
        });

        add(okButton_Unit);
        new FlxTimer().start(0.3, function(tmr:FlxTimer) {
            blockEnter = true;
        });
    }

    function hideButton() {
        if (okButton_Unit != null && okButton_Unit.alive) okButton_Unit.kill();
    }

    function explainSearchScreen() {
        jej.revive();
        unitDrop.kill();
        hintText.text = 'Press ENTER to continue';

        jej.text = 'Now let me explain the search screen. When you launch this application after completing this\ninitial setup, a substate will open with an input box, two buttons, and a dropdown.\n\nIn the input box, replace the text with a location and click Search. The app will freeze for a\nmoment while it searches for locations matching your input.\n\nThe drop down will contain a list of results. Use it to select your location, then click go.';
        jej.screenCenter();
    }

    function explainForecastScreen() {
        jej.text = 'Next up, the forecast screen. This is a tabbed menu.\n\nIt contains any alerts in your area, the current forecast, an astronomy forecast,\nand the hourly forecast for the day. I\'ll explain the tabs in the next screens.';
        jej.screenCenter();
    }

    function explainAstroAlerts() {
        jej.text = 'The astronomy forecast tab contains information about sunrise, sunset,\nmoonrise, moonset, moon phase, and moon illumination.\n\nThe alerts tab contains a dropdown to look at the information\nof any alerts issued by the NWS or other entities for your area.';
        jej.screenCenter();
    }

    function finishUp() {
        if (okButton_Unit != null) {
            okButton_Unit.kill();
        }
        jej.text = 'You\'re all set!\n\nGive us a second to finish up and then you\'re ready to go!';
        jej.screenCenter();
        new FlxTimer().start(3, function(tmr:FlxTimer) {
            trace('yes');
            readyToExit = true;
            hintText.text = 'Press ENTER to exit';
        });
    }
}