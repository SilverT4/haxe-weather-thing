package winUtils;

import lime.system.Locale;
import openfl.system.Capabilities;
import openfl.system.System;
#if (windows && sys)
import sys.io.Process;
import haxe.Json;
import sys.FileSystem;
using StringTools;

class Balabolka {
    public static var VoiceList:Array<String> = [];
    public var curVoice:String = 'Sidney -p 59';
    public var processId:Null<Int> = null;
    public var daBurger:Process;
    public var noob:haxe.io.Bytes;
    public static function getVoiceList() {
        var giggity:Process = new Process(getCwd() + 'winTts\\balcon.exe', ['-l']);
        return giggity.stdout.readString(Std.int(Math.POSITIVE_INFINITY));
    }

    static function getCwd() {
        var shit = Sys.getCwd();
        return shit.replace('/', '\\');
    }

    public function new() {
        trace("READY.");
        #if debug
        flixel.FlxG.console.registerClass(Process);
        #end
    }

    public function setVoice(voiceName:String) {
        this.curVoice = voiceName;
    }

    public function readAlert(daAlert:String) {
        var daArgs = ['-i'];
        daArgs.insert(0, '-n ' + curVoice);
        var daPath = getCwd() + 'winTts/';
        daArgs.push('-d $daPath' + 'weatherAlerts.bxd');
        #if debug
        lime.system.Clipboard.text = daAlert;
        trace(daPath + " " + daArgs.join(" "));
        #end
        if (daBurger == null) daBurger = new Process(daPath + 'balcon', daArgs);
        processId = daBurger.getPid();
        noob = daBurger.stdout.readAll();
        daBurger.stdin.writeString(daAlert);
        //Sys.command(daPath + 'balcon', daArgs);
    }
}
#end