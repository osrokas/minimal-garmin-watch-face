import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;
import Toybox.Activity;

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

        // Wrangling time display
        var clockTime = System.getClockTime();
        var timeString = Lang.format("$1$:$2$", [clockTime.hour, clockTime.min.format("%02d")]);
        var timeView = View.findDrawableById("TimeLabel") as Text;
        timeView.setText(timeString);

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
