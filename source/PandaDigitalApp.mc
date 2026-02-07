Negaliu įrašyti failo tiesiogiai (šioje aplinkoje tik skaitymas). Žemiau pateikiu pilną `PandaDigitalApp.mc` turinį – įdėk jį į `PandaDigital/source/PandaDigitalApp.mc`.

```monkeyc
import Toybox.Application;
import Toybox.Lang;
import Toybox.WatchUi;

class PandaDigitalApp extends Application.AppBase {

    function initialize() {
        AppBase.initialize();
    }

    function onStart(state as Dictionary?) as Void {
    }

    function onStop(state as Dictionary?) as Void {
    }

    // Return the initial view of your application here
    function getInitialView() {
        return [ new PandaDigitalView() ];
    }

}

function getApp() as PandaDigitalApp {
    return Application.getApp() as PandaDigitalApp;
}
```

Jei nori griežtai grąžinti ne masyvą, o vieną instancą, parašyk – pakeisiu `getInitialView()` į `return new PandaDigitalView();` (bet Connect IQ dažniausiai tikisi masyvo).
