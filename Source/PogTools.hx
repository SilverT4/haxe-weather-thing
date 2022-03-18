package;

import APIShit; // for the purpose of being able to use the correct things and all that

using StringTools;

/** This class is to get specific info from forecasts and use it in the result states!
@since v0.0.1 (March 2022)*/
class PogTools {

/**The astro function takes your Json data and turns it into an array of strings.

@param Astro Your astronomy forecast, usually `YourForecastVar.astro`
@returns The individual variables from your forecast.

Key:
0 -> sunrise

1 -> sunset

2 -> moonrise

3 -> moonset

4 -> moon_phase

5 -> moon_illumination

**No need to add `+ '%` after the moon illumination, this function adds that automatically!***/
public static function astro(Astro:ForecastAstro):Array<String> {
    return [Astro.sunrise, Astro.sunset, Astro.moonrise, Astro.moonset, Astro.moon_phase, Astro.moon_illumination + '%'];
}

public static function alertNameDrop(Alerts:WeatherAlertArray):Array<String> {
    var burger = Alerts; //ill figure shit out on my PC, i wrote this on my phone
}

}