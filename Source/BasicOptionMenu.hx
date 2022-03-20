package;

import openfl.net.URLRequest;
import flixel.FlxSubState;
import flixel.util.FlxColor;
import flixel.FlxG;
//import filxel.FlxText;
import flixel.FlxState;
import flixel.input.keyboard.FlxKey;
import flixel.text.FlxText;
import openfl.net.FileReference;
import openfl.events.Event;
import openfl.events.IOErrorEvent;
import lime.app.Application;

using StringTools;

/**A very basic option menu. Uses FlxKeys to access different options.
@since v0.0.1*/
class BasicOptionMenu extends FlxState {
    public static var returnTo:Dynamic;
    var OptionList:Array<String> = [
        'Press the I key to open the issues page on the app\'s GitHub repository.',
        #if sys
        'Press the W key to download the weather icons from WeatherAPI.',
        #end
    ];
    public function new () {
        super();
    }

    override function create() {
        var optText = new FlxText(0,0,0, '**Basic Options Menu**', 12);
        optText.screenCenter(X);
        add(optText);
        var optList = new FlxText(0, 0, FlxG.width, OptionList.join('\n'), 16);
        optList.setFormat(null, 16, FlxColor.WHITE, CENTER);
        optList.screenCenter();
        add(optList);
        add(new FlxText(0, FlxG.height - 18, 0, 'Press ESC to return.', 16));
    }
    var _file:FileReference;
    override function update(elapsed:Float) {
        if (FlxG.keys.justPressed.I) {
            SusUtil.openLink('https://github.com/devin503/haxe-weather-thing/issues');
        }
        #if sys
        if (FlxG.keys.justPressed.W) {
            //SusUtil.openLink('https://cdn.weatherapi.com/weather.zip');
            Application.current.window.alert("Now initiating download of weather icons.\n\nPlease download the zip to a folder you'll remember, then extract the zip file to " + Sys.getCwd().replace('\\', '/') + "Assets/Icons\n\nRelaunch the application once you have done so.");
            _file = new FileReference();
            _file.addEventListener(Event.SELECT, onDlComplete);
            _file.addEventListener(Event.CANCEL, onDlCancel);
            _file.addEventListener(IOErrorEvent.IO_ERROR, onDlError);
            _file.download(new URLRequest('https://cdn.weatherapi.com/weather.zip'));
        }
        #end

        if (FlxG.keys.justPressed.ESCAPE) {
            if (returnTo != null) {
                if (returnTo is FlxState) {
                    FlxG.switchState(returnTo);
                } else if (returnTo is FlxSubState) {
                    subState = returnTo;
                    resetSubState();
                }
            } else {
                FlxG.switchState(new LaunchState());
            }
        }
    }
    #if sys
    function onDlComplete(_):Void {
        _file.removeEventListener(Event.SELECT, onDlComplete);
        _file.removeEventListener(Event.CANCEL, onDlCancel);
        _file.removeEventListener(IOErrorEvent.IO_ERROR, onDlError);
        if (@:privateAccess _file.__path != null) {
            FlxG.log.add('File saved to ' + @:privateAccess _file.__path);
        }
        _file = null;
    }

    function onDlCancel(_):Void {
        _file.removeEventListener(Event.SELECT, onDlComplete);
        _file.removeEventListener(Event.CANCEL, onDlCancel);
        _file.removeEventListener(IOErrorEvent.IO_ERROR, onDlError);
        _file = null;
        FlxG.log.notice('Download canceled.');
    }

    function onDlError(_):Void {
        _file.removeEventListener(Event.SELECT, onDlComplete);
        _file.removeEventListener(Event.CANCEL, onDlCancel);
        _file.removeEventListener(IOErrorEvent.IO_ERROR, onDlError);
        _file = null;
        FlxG.log.error('Download failed!');
    }
    #end
}