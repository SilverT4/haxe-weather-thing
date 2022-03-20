package util;

import flixel.FlxSprite;
import PathFinder;

using StringTools;

/**A custom FlxSprite class to simplify the process of loading the icon for the current weather, or the icon for a forecast's weather.
    @param x The X position
    @param y The Y position
    @param icon The icon PNG
    @param hour Decides whether the icon is a day or night icon. (7pm-4am are night, 5am-6pm are day)
    @since v0.0.2*/
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