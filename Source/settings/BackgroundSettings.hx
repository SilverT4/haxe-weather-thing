package settings;

import flixel.tweens.FlxTween;
import flixel.FlxG;
import flixel.FlxCamera;
import flixel.FlxSubState;
import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.group.FlxGroup.FlxTypedGroup;
using StringTools;

typedef FunnyColor = {
    var Red:Int;
    var Green:Int;
    var Blue:Int;
}
class Meena extends FlxSprite {
    public var STYLE:BitchAssPickMeElephant;
    public var COLOR1:FunnyColor;
    public var COLOR2:FunnyColor;
    public var THEGROUP:FlxTypedGroup<FlxSprite>;
    public var HEI:Int;
    public var WID:Int;
    public function new(COL1:FunnyColor, COL2:FunnyColor, STY:BitchAssPickMeElephant, W:Int, H:Int) {
        super(0, FlxG.height - 250);
        screenCenter(X);
        this.STYLE = STY;
        this.COLOR1 = COL1;
        this.COLOR2 = COL2;
        this.HEI = H;
        this.WID = W;
        THEGROUP = new FlxTypedGroup(); // MAKE IT BEFORE MAKING GRADIENT!!
    }

    public function makeGradient() {
        var FIRST:FlxColor;
        var SECOND:FlxColor;
        var DIMENSION:String;
        var INTENDED_W:Int = WID;
        var INTENDED_H:Int = HEI;
        var INTENDED_X = this.x;
        var INTENDED_Y = this.y;
        var INTENDED_STEP_COUNT:Int;
        switch (STYLE) {
            case BOTTOM_TOP:
                FIRST = gayShit(COLOR1);
                SECOND = gayShit(COLOR2);
                DIMENSION = "height";
                INTENDED_STEP_COUNT = INTENDED_H;
            case TOP_BOTTOM:
                FIRST = gayShit(COLOR2);
                SECOND = gayShit(COLOR1);
                DIMENSION = "height";
                INTENDED_STEP_COUNT = INTENDED_H;
        }
        var myAss = FlxColor.gradient(FIRST, SECOND, INTENDED_STEP_COUNT);
        for (gay => dick in myAss) {
            var theRealCoords = [];
            if (STYLE == TOP_BOTTOM) {
                theRealCoords.push(INTENDED_X);
                theRealCoords.push(gay + INTENDED_Y);
            } else if (STYLE == BOTTOM_TOP) {
                theRealCoords.push(INTENDED_X);
                theRealCoords.push(INTENDED_Y - gay);
            } else {
                trace("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA");
            }
            var actualWidthIndi:Int = WID;
            var actualHeightIndi:Int = 1;
            var Peensum = new FlxSprite(theRealCoords[0], theRealCoords[1]);
            Peensum.makeGraphic(actualWidthIndi, actualHeightIndi, dick);
            THEGROUP.add(Peensum);
        }
    }
    function gayShit(COL:FunnyColor) {
        return FlxColor.fromRGB(COL.Red, COL.Green, COL.Blue);
    }
}
class PreviewSquare extends FlxSprite {
    var dim = 32;
    var posX = 1000;
    var posY = 250;

    public function new(StartColor:FunnyColor) {
        super(posX, posY);
        makeGraphic(dim, dim);
        updateColor(StartColor);
    }
    public function updateColor(NewColor:FunnyColor) {
        this.color = FlxColor.fromRGB(NewColor.Red, NewColor.Green, NewColor.Blue, 255);
    }
}

typedef SaveColor = {
    var from:FunnyColor;
    var to:FunnyColor;
    var style:BitchAssPickMeElephant;
}
class BackgroundSettings extends FlxSubState {
    var prevSquare:PreviewSquare;
    var gradSquare:PreviewSquare;
    var funnyTextR:FlxText;
    var funnyTextG:FlxText;
    var funnyTextB:FlxText;
    var funnyShit:FunnyColor;
    var hornyBitch:FunnyColor;
    var hintText:FlxText;
    var bitchGroup:FlxTypedGroup<Meena>;
    public function new() {
        super();
        if (FlxG.save.data.bgColors != null) {
            funnyShit = FlxG.save.data.bgColors.from;
            hornyBitch = FlxG.save.data.bgColors.to;
        } else {
            funnyShit = {
                Red: 0,
                Green: 0,
                Blue: 0
            };
            hornyBitch = {
                Red: 255,
                Green: 255,
                Blue: 255
            };
        }
        trace(funnyShit);
        trace(hornyBitch);
    }
    var pointThingy:FlxSprite;
    var bg:FlxSprite;
    var pointerCam:FlxCamera;
    override function create() {
        trace("pissin start");
        bg = new FlxSprite();
        bg.makeGraphic(FlxG.width, FlxG.height, 0xFF000000);
        add(bg);
        trace("bg");
        funnyTextR = new FlxText(150, 300, 0, Std.string(funnyShit.Red), 16);
        funnyTextG = new FlxText(300, 300, 0, Std.string(funnyShit.Green), 16);
        funnyTextB = new FlxText(450, 300, 0, Std.string(funnyShit.Blue), 16);
        add(funnyTextR);
        trace("red");
        add(funnyTextG);
        trace("green");
        add(funnyTextB);
        trace("blue");
        prevSquare = new PreviewSquare(funnyShit);
        add(prevSquare);
        trace("funny square 1");
        gradSquare = new PreviewSquare(hornyBitch);
        gradSquare.y += 250;
        add(gradSquare);
        trace('funny square 2');
        pointerCam = new FlxCamera();
        pointerCam.bgColor.alpha = 0;
        FlxG.cameras.add(pointerCam, false);
        pointThingy = new FlxSprite();
        pointThingy.loadGraphic(PathFinder.image('oldRobloxCursor'));
        pointThingy.cameras = [pointerCam];
        add(pointThingy);
        trace('funny cursor');
        hintText = new FlxText(0, 0, 0, "Use the up and down arrow keys to change the value of the highlighted color. Use the left and right keys to highlight another color.\nPress SPACE to switch to color 2, or ENTER to exit.", 12);
        add(hintText);
        trace('text shit');
        bitchGroup = new FlxTypedGroup();
        add(bitchGroup);
        trace("pissin confirmed");
    }

    function changeColor(c:String, change:Int = 0) {
        switch (c) {
            case 'r':
                funnyShit.Red += change;
                if (funnyShit.Red > 255) funnyShit.Red = 255;
                else if (funnyShit.Red < 0) funnyShit.Red = 0;
                funnyTextR.text = Std.string(funnyShit.Red);
            case 'g':
                funnyShit.Green += change;
                if (funnyShit.Green > 255) funnyShit.Green = 255;
                else if (funnyShit.Green < 0) funnyShit.Green = 0;
                funnyTextG.text = Std.string(funnyShit.Green);
            case 'b':
                funnyShit.Blue += change;
                if (funnyShit.Blue > 255) funnyShit.Blue = 255;
                else if (funnyShit.Blue < 0) funnyShit.Blue = 0;
                funnyTextB.text = Std.string(funnyShit.Blue);
        }
        //prevSquare.updateColor(funnyShit);
    }
    function changeColorAlt(c:String, change:Int = 0) {
        switch (c) {
            case 'r':
                hornyBitch.Red += change;
                if (hornyBitch.Red > 255) hornyBitch.Red = 255;
                else if (hornyBitch.Red < 0) hornyBitch.Red = 0;
                funnyTextR.text = Std.string(hornyBitch.Red);
            case 'g':
                hornyBitch.Green += change;
                if (hornyBitch.Green > 255) hornyBitch.Green = 255;
                else if (hornyBitch.Green < 0) hornyBitch.Green = 0;
                funnyTextG.text = Std.string(hornyBitch.Green);
            case 'b':
                hornyBitch.Blue += change;
                if (hornyBitch.Blue > 255) hornyBitch.Blue = 255;
                else if (hornyBitch.Blue < 0) hornyBitch.Blue = 0;
                funnyTextB.text = Std.string(hornyBitch.Blue);
        }
        //gradSquare.updateColor(hornyBitch);
    }
    var cols = ['r', 'g', 'b'];
    var ct = 0;
    function switchColor(change:Int = 0) {
        ct += change;
        if (ct < 0) ct = cols.length - 1;
        if (ct >= cols.length) ct = 0;
        cc = cols[ct];
        pointThingy.x = getCurColChanger().getGraphicMidpoint().x + 12;
        pointThingy.y = getCurColChanger().y + 18;
    }

    function getCurColChanger() {
        if (cc == 'r') return funnyTextR;
        else if (cc == 'g') return funnyTextG;
        else return funnyTextB;
    }
    var cc:String = 'r';
    var changingSec:Bool = false;
    var curScreen:String = 'colours';
    override function update(elapsed:Float) {
        var leftP = FlxG.keys.justPressed.LEFT;
        var rightP = FlxG.keys.justPressed.RIGHT;
        var upP = FlxG.keys.justPressed.UP;
        var downP = FlxG.keys.justPressed.DOWN;
        var upHold = FlxG.keys.pressed.UP;
        var downHold = FlxG.keys.pressed.DOWN;
        var switchIt = FlxG.keys.justPressed.SPACE;
        var done = FlxG.keys.justPressed.ENTER;
        var screenSwitch = FlxG.keys.justPressed.L;
        if (screenSwitch && curScreen == 'colours') {
            commitGreatSins();
        } else if (screenSwitch && curScreen == 'gradients') {
            killMeena();
        }
        if (leftP) {
            switchColor(-1);
        }
        if (rightP) {
            switchColor(1);
        }
        if ((upP || downP || upHold || downHold) && curScreen == 'colours') {
            if (upP || upHold) {
                if (changingSec) changeColorAlt(cc, 1);
                else changeColor(cc, 1);
            }
            else {
                if (changingSec) changeColorAlt(cc, -1);
                else changeColor(cc, -1);
            }
        }
        if (switchIt) {
            trace("switching");
            doSwitch();
        }
        if (screenSwitch) {
            trace("screen switch");
        }
        if (done) {
            FlxG.save.data.bgColors = {
                from: funnyShit,
                to: hornyBitch
            };
            FlxG.save.flush();
            close();
        }
        // switching and saving are a wip atm
        if (prevSquare != null) {
            prevSquare.update(elapsed);
            prevSquare.updateColor(funnyShit);
        }
        if (gradSquare != null) {
            gradSquare.update(elapsed);
            gradSquare.updateColor(hornyBitch);
        }
        super.update(elapsed);
    }

    function doSwitch() {
        changingSec = !changingSec;
        hintText.text = (changingSec) ? "Use the up and down arrow keys to change the value of the color which you see an arrow under. Use the left and right keys to highlight another color.\nPress SPACE to switch to color 1, or ENTER to exit." : "Use the up and down arrow keys to change the value of the color which you see an arrow under. Use the left and right keys to highlight another color.\nPress SPACE to switch to color 2, or ENTER to exit.";
        hintText.text += " Press the L key to select a gradient style.";
        if (changingSec) {
           funnyTextR.text = Std.string(hornyBitch.Red);
           funnyTextG.text = Std.string(hornyBitch.Green);
           funnyTextB.text = Std.string(hornyBitch.Blue);
        } else {
            funnyTextR.text = Std.string(funnyShit.Red);
            funnyTextG.text = Std.string(funnyShit.Green);
            funnyTextB.text = Std.string(funnyShit.Blue);
        }
    }

    function killMeena() {
        for (gun in bitchGroup) {
            gun.destroy();
            gun = null;
            bitchGroup.remove(gun); // idk
        }
        curScreen = 'colours';
    }

    function commitGreatSins() {
        var yourSins = [BOTTOM_TOP, TOP_BOTTOM];
        for (e in 0...1) {
            trace("sins cutely");
            var sin = new Meena(funnyShit, hornyBitch, yourSins[e], 32, 32);
            sin.y = (160 * e) + 70;
            sin.makeGradient();
            bitchGroup.add(sin);
            add(sin.THEGROUP);
        }
        curScreen = 'gradients';
    }
}

enum BitchAssPickMeElephant {
/**
 * The default (Gradient goes from colour 1 at the bottom to colour 2 at the top.)
 */
 BOTTOM_TOP;
/**
 * Inverted version of the default (Gradient goes from colour 1 at the top to colour 2 at the bottom.)
 */
 TOP_BOTTOM;
}