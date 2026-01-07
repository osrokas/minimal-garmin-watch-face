import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;
import Toybox.Activity;
import Toybox.Time;
import Toybox.Time.Gregorian;

// Helper function to get battery status
function batteryStatus() as Integer {
    var batteryLevel = System.getSystemStats().battery.toNumber();  
    return batteryLevel;
}

// Helper function to get heart rate
function getHeartRate() as Number {
    var heartRate = Activity.getActivityInfo().currentHeartRate;
    // Handle case where heart rate is not available
    if (heartRate == null) {
        heartRate = 0;
    }
    return heartRate;
}

function digitWrangler(digit) as String {
    switch (digit) {
        case 1: return "01";
        case 2: return "02";
        case 3: return "03";
        case 4: return "04";
        case 5: return "05";
        case 6: return "06";
        case 7: return "07";
        case 8: return "08";
        case 9: return "09";
        case 10: return "10";
        case 11: return "11";
        case 12: return "12";
        case 13: return "13";
        case 14: return "14";
        case 15: return "15";
        case 16: return "16";
        case 17: return "17";
        case 18: return "18";
        case 19: return "19";
        case 20: return "20";
        case 21: return "21";
        case 22: return "22";
        case 23: return "23";
        case 24: return "24";
        case 25: return "25";
        case 26: return "26";
        case 27: return "27";
        case 28: return "28";
        case 29: return "29";
        case 30: return "30";
        case 31: return "31";
        default: return "";
    }
}

function dayWrangler(day) as String {
    switch (day) {
        case 1: return "Sekmadienis";
        case 2: return "Pirmadienis";
        case 3: return "Antradienis";
        case 4: return "Trečiadienis";
        case 5: return "Ketvirtadienis";
        case 6: return "Penktadienis";
        case 7: return "Šeštadienis";
        default: return "";
    }
}

class WatchFaceFirstView extends WatchUi.WatchFace {

    function initialize() {
        WatchFace.initialize();
    }

    // Load your resources here
    function onLayout(dc as Dc) as Void {
        setLayout(Rez.Layouts.WatchFace(dc));
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() as Void {
    }

    // Update the view
    function onUpdate(dc as Dc) as Void {
        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);

        // Wrangling time 
        var clockTime = System.getClockTime();

        // Wrangle time display
        var timeString = Lang.format("$1$:$2$", [clockTime.hour, clockTime.min.format("%02d")]);
        var timeView = View.findDrawableById("TimeLabel") as Text;
        timeView.setText(timeString);

        // Wrangle date display
        var date = Time.now();
        var today = Gregorian.info(date, Time.FORMAT_SHORT);
        var month = digitWrangler(today.month);
        var day = digitWrangler(today.day);
        var dateString = today.year + "-" + month + "-" + day;
        var dateView = View.findDrawableById("DateLabel") as Text;
        dateView.setText(dateString);

        // Wrangle weekday display
        var weekDayName = dayWrangler(today.day_of_week);
        var weekDayView = View.findDrawableById("WeekDayLabel") as Text;
        weekDayView.setText(weekDayName);

        // Wrangling battery display
        var batteryView = View.findDrawableById("BatteryLabel") as Text;
        var batteryString = batteryStatus() + "%";
        batteryView.setText(batteryString);

        // Wrangling heart rate display
        var heartRateView = View.findDrawableById("HeartRateLabel") as Text;
        var heartRate = getHeartRate();
        heartRateView.setText(heartRate.toString());

        // Drawing battery icon
        var IconBattery  = Application.loadResource(Rez.Drawables.batteryIcon) as BitmapResource;
        dc.drawBitmap(60, 147, IconBattery);

        // Drawing heart rate icon
        var IconHeart  = Application.loadResource(Rez.Drawables.heartIcon) as BitmapResource;
        dc.drawBitmap(118, 23, IconHeart);
        
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() as Void {
    }

    // The user has just looked at their watch. Timers and animations may be started here.
    function onExitSleep() as Void {
    }

    // Terminate any active timers and prepare for slow updates.
    function onEnterSleep() as Void {
    }

}
