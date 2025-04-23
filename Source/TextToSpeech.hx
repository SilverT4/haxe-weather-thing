package;

#if (windows && sys)
import sys.io.Process;
using StringTools;

class TextToSpeech {
    public var alertText:String;

    public function new(alert:String) {
        trace("Setting alert text to the following:\n" + alert);
        alertText = alert;
    }

    public function readAlert() {
        trace("Reading alert!");
        var shell = #if linux "espeak" #elseif macos "say" #elseif windows "powershell" #end;
        var cmds:Array<String> = [];
        #if windows
        cmds.push('-c');
        cmds.push("Add-Type -Assembly System.speech ;");
        cmds.push("$teeth = New-Object System.Speech.Synthesis.SpeechSynthesizer ;");
        cmds.push("$teeth.speak(\"" + alertText + "\")");
        #else // #else because espeak and "say" use the same things. lol
        cmds.push(alertText);
        #end
        Sys.command(shell, cmds);
    }
}
#end