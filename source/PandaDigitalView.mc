I can’t write to the workspace (read-only). Below is the full refactored content for `PandaDigital/source/PandaDigitalView.mc`.

```monkeyc
using Toybox.WatchUi as WatchUi;
using Toybox.Graphics as Graphics;
using Toybox.System as System;
using Toybox.Time as Time;
using Toybox.Lang as Lang;
using Toybox.Activity as Activity;
using Toybox.Sensor as Sensor;

function _twoDigit(value) {
    if (value < 10) {
        return "0" + value;
    }
    return value.toString();
}

class TimeDrawable extends WatchUi.Drawable {
    function initialize() {
        WatchUi.Drawable.initialize();
    }

    function draw(dc) {
        var w = dc.getWidth();
        var h = dc.getHeight();

        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);

        var now = Time.now();
        var info = Time.Gregorian.info(now, Time.FORMAT_SHORT);
        var timeStr = _twoDigit(info.hour) + ":" + _twoDigit(info.min);

        var timeFont = Graphics.FONT_LARGE;
        var timeY = (h / 2);

        dc.drawText(w / 2, timeY, timeFont, timeStr, Graphics.TEXT_JUSTIFY_CENTER);
    }
}

class DateDrawable extends WatchUi.Drawable {
    function initialize() {
        WatchUi.Drawable.initialize();
    }

    function draw(dc) {
        var w = dc.getWidth();
        var h = dc.getHeight();

        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);

        var now = Time.now();
        var info = Time.Gregorian.info(now, Time.FORMAT_SHORT);
        var dateStr = info.year.toString() + "-" + _twoDigit(info.month) + "-" + _twoDigit(info.day);

        var timeFont = Graphics.FONT_LARGE;
        var smallFont = Graphics.FONT_SMALL;
        var timeH = dc.getFontHeight(timeFont);
        var dateH = dc.getFontHeight(smallFont);

        var timeY = (h / 2);
        var dateY = timeY - (timeH / 2) - dateH - 4;

        dc.drawText(w / 2, dateY, smallFont, dateStr, Graphics.TEXT_JUSTIFY_CENTER);
    }
}

class StatsDrawable extends WatchUi.Drawable {
    function initialize() {
        WatchUi.Drawable.initialize();
    }

    function draw(dc) {
        var w = dc.getWidth();
        var h = dc.getHeight();

        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);

        var activity = Activity.getActivityInfo();
        var hr = null;
        if (activity != null && activity.currentHeartRate != null) {
            hr = activity.currentHeartRate;
        } else {
            hr = Sensor.getHeartRate();
        }
        var steps = (activity != null) ? activity.steps : null;

        var stats = System.getSystemStats();
        var battery = (stats != null) ? stats.battery : null;

        var hrStr = (hr != null) ? hr.toString() : "--";
        var stepsStr = (steps != null) ? steps.toString() : "--";
        var batStr = (battery != null) ? (battery.toString() + "%") : "--";

        var timeFont = Graphics.FONT_LARGE;
        var timeH = dc.getFontHeight(timeFont);
        var timeY = (h / 2);
        var dataY = timeY + (timeH / 2) + 6;

        var col1 = w / 6;
        var col2 = w / 2;
        var col3 = (w * 5) / 6;

        _drawHeart(dc, col1 - 18, dataY);
        _drawFoot(dc, col2 - 18, dataY);
        _drawBattery(dc, col3 - 18, dataY);

        dc.drawText(col1 - 6, dataY, Graphics.FONT_SMALL, hrStr, Graphics.TEXT_JUSTIFY_LEFT);
        dc.drawText(col2 - 6, dataY, Graphics.FONT_SMALL, stepsStr, Graphics.TEXT_JUSTIFY_LEFT);
        dc.drawText(col3 - 6, dataY, Graphics.FONT_SMALL, batStr, Graphics.TEXT_JUSTIFY_LEFT);
    }

    function _drawHeart(dc, cx, cy) {
        var p = [
            cx - 4, cy - 1,
            cx - 6, cy - 3,
            cx - 4, cy - 6,
            cx,     cy - 3,
            cx + 4, cy - 6,
            cx + 6, cy - 3,
            cx + 4, cy - 1,
            cx,     cy + 4
        ];
        dc.fillPolygon(p);
    }

    function _drawFoot(dc, cx, cy) {
        var p = [
            cx - 2, cy + 4,
            cx - 5, cy + 1,
            cx - 4, cy - 4,
            cx,     cy - 6,
            cx + 4, cy - 4,
            cx + 5, cy + 1,
            cx + 2, cy + 4
        ];
        dc.fillPolygon(p);
        dc.drawLine(cx - 6, cy - 8, cx - 4, cy - 6);
        dc.drawLine(cx - 2, cy - 9, cx - 1, cy - 7);
        dc.drawLine(cx + 2, cy - 9, cx + 1, cy - 7);
        dc.drawLine(cx + 6, cy - 8, cx + 4, cy - 6);
    }

    function _drawBattery(dc, cx, cy) {
        var w = 12;
        var h = 8;
        var x = cx - (w / 2);
        var y = cy - (h / 2);

        dc.drawLine(x, y, x + w, y);
        dc.drawLine(x, y + h, x + w, y + h);
        dc.drawLine(x, y, x, y + h);
        dc.drawLine(x + w, y, x + w, y + h);
        dc.drawLine(x + w + 1, y + 2, x + w + 1, y + h - 2);

        dc.fillRectangle(x + 2, y + 2, w - 4, h - 4);
    }
}

class PandaDigitalView extends WatchUi.WatchFace {
    var _timeDrawable;
    var _dateDrawable;
    var _statsDrawable;

    function initialize() {
        WatchUi.WatchFace.initialize();
    }

    function onLayout(dc) {
        setLayout(Rez.Layouts.WatchFace(dc));

        _timeDrawable = new TimeDrawable();
        _dateDrawable = new DateDrawable();
        _statsDrawable = new StatsDrawable();

        addDrawable(_dateDrawable);
        addDrawable(_timeDrawable);
        addDrawable(_statsDrawable);
    }

    function onUpdate(dc) {
        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_BLACK);
        dc.clear();
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);

        WatchUi.View.onUpdate(dc);
    }
}
```

No tests were run. If you want the icons tweaked or aligned differently, say the shape/style you want.
