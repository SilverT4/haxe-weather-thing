package util;

import flixel.FlxSprite;
import PathFinder;

using StringTools;

class WeatherIcon extends FlxSprite {
    private var nightHours:Array<Int> = [
        0,
        1,
        2,
        3,
        4,
        19,
        20,
        21,
        22,
        23
    ];
    private var dayHours:Array<Int> = [
        5,
        6,
        7,
        8,
        9,
        10,
        11,
        12,
        13,
        14,
        15,
        16,
        17,
        18
    ];
    var curTime:String = '';
    public function new(x:Float, y:Float, icon:String, hour:Int) {
        super(x, y);
        if (nightHours.contains(hour)) curTime = 'night';
        else if (dayHours.contains(hour)) curTime = 'day';
        else curTime = 'night'; // defaultin to night lmao
        loadGraphic(PathFinder.getIcon(icon, curTime));
    }
}