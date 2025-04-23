package settings;
#if sys
import flixel.FlxG;
import flixel.FlxSubState;
import flixel.FlxSprite;
import haxe.Json;
import openfl.net.FileReference;
import openfl.net.FileFilter;
import openfl.events.IOErrorEvent;
import openfl.errors.IOError;
import openfl.events.Event;
import flixel.group.FlxGroup.FlxTypedGroup;
import sys.io.File;
import TextToSpeech;
using StringTools;

class SaveManager extends FlxSubState {
    var optionList:Array<String> = [
        "Export save data",
        "Import save data",
        "Delete all data",
        "Remove extra fields"
    ];
    var selectedIndic:FNFAlphabet;
    var rightIndic:FNFAlphabet;
    var curSelected:Int = 0;
    var pussy:TextToSpeech;
    function lowestString (s1 : String, s2 : String) : Int
    {
        var desc = true;
        if (s1 == s2) return 0;
            s1 = s1.toLowerCase ();
            s2 = s2.toLowerCase ();
        for (i in 0...s1.length)
        {
            var n1 : Int = s1.charCodeAt (i);
            var n2 : Int = s2.charCodeAt (i);
            if (n1 < n2)
                return (desc ? 1 : -1); // If descending, the other way around
            else if (n2 < n1)
                return (desc ? -1 : 1);
        }
        return (s1.length < s2.length ? (desc ? 1 : -1) : (desc ? -1 : 1));
    }

    public function new() {
        super();
        optionList.sort(lowestString);
        optionList.push("Exit");
    }
    var grpOpts:FlxTypedGroup<FNFAlphabet>;
    override function create() {
        trace(FlxG.save.data);
        pussy = new TextToSpeech("Piss");
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
    }
    override function update(elapsed:Float) {
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
                trace("Okay!");
                doSelectedAction();
            } else {
                close();
            }
        }

        if (bacc) {
            close();
        }
    }
    var daFile:FileReference;
    function doSelectedAction() {
        switch (optionList[curSelected]) {
            case 'Import save data':
                importData();
            case 'Export save data':
                exportData();
            case 'Remove extra fields':
                removeNulls();
            case 'Delete all data':
                // idk yet
        }
    }
    var poot:String = null;
    function importData() {
        pussy.alertText = "Please select a JSON file to import.";
        pussy.readAlert();
        poot = 'import';
        daFile = new FileReference();
        daFile.addEventListener(Event.SELECT, onLoadComplete);
        daFile.addEventListener(Event.CANCEL, onLoadCancel);
        daFile.addEventListener(IOErrorEvent.IO_ERROR, onLoadError);
        daFile.browse([new openfl.net.FileFilter("Json File", "json", "application/json")]);
    }

    function exportData() {
        daFile = new FileReference();
        daFile.addEventListener(Event.SELECT, onSaveComplete);
        daFile.addEventListener(Event.CANCEL, onSaveCancel);
        daFile.addEventListener(IOErrorEvent.IO_ERROR, onSaveError);
        daFile.save(Json.stringify(FlxG.save.data, "\t"), "savedata.json");
    }

    function removeNulls() {
        poot = 'nulls';
        pussy.alertText = "Please select a JSON file to compare your current save data to.";
        pussy.readAlert();
        trace("We need a fucking THING.");
        daFile = new FileReference();
        daFile.addEventListener(Event.SELECT, onLoadComplete);
        daFile.addEventListener(Event.CANCEL, onLoadCancel);
        daFile.addEventListener(IOErrorEvent.IO_ERROR, onLoadError);
        daFile.browse([new openfl.net.FileFilter("Json File", "json", "application/json")]);
    }

    function onLoadComplete(_) {
        daFile.removeEventListener(Event.SELECT, onLoadComplete);
        daFile.removeEventListener(Event.CANCEL, onLoadCancel);
        daFile.removeEventListener(IOErrorEvent.IO_ERROR, onLoadError);
        
        var daPath = null;
        @:privateAccess
        if (daFile.__path != null) daPath = daFile.__path;

        if (daPath != null) {
            trace("File path: " + daPath);
            var daSave:String = File.getContent(daPath);
            if (daSave != null) {
                var bruh = Json.parse(daSave);
                var jester:Map<String, Dynamic> = [];
                var crap:Map<String, Dynamic> = [];
                var fuckMyPussy = Reflect.fields(bruh);
                var justMyShit = Reflect.fields(FlxG.save.data);
                for (field in fuckMyPussy) {
                    trace(field);
                    jester.set(field, Reflect.getProperty(bruh, field));
                }
                for (field in justMyShit) {
                    trace(field);
                    crap.set(field, Reflect.getProperty(FlxG.save.data, field));
                }
                trace(jester);
                try {
                    var sex = 1;
                    if (poot == 'import') {
                        for (poo => py in jester) {
                            trace("Attempting to set " + poo + " to " + py + " in save data!");
                            Reflect.setField(FlxG.save.data, poo, py);
                            trace(Reflect.getProperty(FlxG.save.data, poo)); 
                        }
                    } else if (poot == 'nulls') {
                        for (poo => py in crap) {
                            if (jester.exists(poo)) {
                                trace("Field " + sex + " of " + justMyShit.length + ": Keeping " + poo);
                            } else {
                                trace("Field " + sex + " of " + justMyShit.length + ": Removing field " + poo);
                                Reflect.deleteField(FlxG.save.data, poo);
                            }
                            sex++;
                        }
                    }
                    FlxG.save.flush();
                } catch(e:haxe.Exception) {
                    trace(e);
                    FlxG.sound.play(PathFinder.sound('errorDoh'));
                }
                FlxG.sound.play(PathFinder.sound("balance-Done"));
            }
        }

        daFile = null;
    }
    function onLoadCancel(_) {
        daFile.removeEventListener(Event.SELECT, onLoadComplete);
        daFile.removeEventListener(Event.CANCEL, onLoadCancel);
        daFile.removeEventListener(IOErrorEvent.IO_ERROR, onLoadError);
        daFile = null;
    }

    function onLoadError(_) {
        daFile.removeEventListener(Event.SELECT, onLoadComplete);
        daFile.removeEventListener(Event.CANCEL, onLoadCancel);
        daFile.removeEventListener(IOErrorEvent.IO_ERROR, onLoadError);
        FlxG.sound.play(PathFinder.sound('errorOops'));
        trace(_);
        daFile = null;
    }

    function onSaveComplete(_) {
        daFile.removeEventListener(Event.SELECT, onSaveComplete);
        daFile.removeEventListener(Event.CANCEL, onSaveCancel);
        daFile.removeEventListener(IOErrorEvent.IO_ERROR, onSaveError);
        daFile = null;
    }

    function onSaveCancel(_) {
        daFile.removeEventListener(Event.SELECT, onSaveComplete);
        daFile.removeEventListener(Event.CANCEL, onSaveCancel);
        daFile.removeEventListener(IOErrorEvent.IO_ERROR, onSaveError);
        daFile = null;
    }

    function onSaveError(_) {
        daFile.removeEventListener(Event.SELECT, onSaveComplete);
        daFile.removeEventListener(Event.CANCEL, onSaveCancel);
        daFile.removeEventListener(IOErrorEvent.IO_ERROR, onSaveError);
        trace(_);
        FlxG.sound.play(PathFinder.sound('errorOops'));
        daFile = null;
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
				selectedIndic.x = item.x - 63;
				selectedIndic.y = item.y;
				rightIndic.x = item.x + item.width + 15;
				rightIndic.y = item.y;
			}
		}
    }
}
#end