package;

import APIShit; // for the purpose of being able to use the correct things and all that

using StringTools;

/** This class is to get specific info from forecasts and use it in the result states!
@since v0.0.1 (March 2022)*/
class PogTools {
    
    /**The astro function takes your Json data and turns it into an array of strings.

        Key:

    0 -> sunrise
    
    1 -> sunset
    
    2 -> moonrise
    
    3 -> moonset
    
    4 -> moon_phase
    
    5 -> moon_illumination
    
    **No need to add `+ '%'` after the moon illumination, this function adds that automatically!**
        
    @param Astro Your astronomy forecast, usually `YourForecastVar.astro`
    @returns The individual variables from your forecast.
    @since v0.0.1*/
        public static function astro(Astro:ForecastAstro):Array<String> {
        return [Astro.sunrise, Astro.sunset, Astro.moonrise, Astro.moonset, Astro.moon_phase, Astro.moon_illumination + '%'];
    }
    
    /**Generate the alert list for your forecast.

    For use with FlxUIDropDownMenuCustom.
        
    @param Alerts The weather alert array associated with your forecast.
    @returns A list of alert headlines.
    @since v0.0.1*/
    public static function alertNameDrop(Alerts:WeatherAlertArray):Array<String> {
        var toReturn = [];
        var burger = Alerts.alert; //ill figure shit out on my PC, i wrote this on my phone
        for (alert in burger) {
            toReturn.push(alert.event);
        }
        return toReturn;
    }

    /**Get the information from a weather alert to display on screen.

    Key:

    0 - The headline (Who issued the alert)
    
    1 - The message type

    2 - The severity of the alert.

    3 - The urgency of the alert.

    4 - The areas affected

    5 - Alert category

    6 - Certainty of the alert

    7 - What the alert is.

    8 - Notes

    9 - Effective since

    10 - Effective until

    11 - Description (Likely the message)

    12 - Instructions to follow to prepare for this alert
    @param Alert A weather alert.*/
    public static function alertInformation(Alert:WeatherAlert):Array<String> {
        //e
        return [Alert.headline, Alert.msgType, Alert.severity, Alert.urgency, Alert.areas.split('; ').join(', '), Alert.category, Alert.certainty, Alert.event, Alert.note, Alert.effective, Alert.expires, Alert.desc, Alert.instruction]; //BASIC
    }
    
}