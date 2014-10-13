library webapp_base_ui_angular.example.mm_uia_alert;

import 'package:angular/angular.dart';
import 'package:angular/application_factory.dart';

//import 'package:webapp_base_ui/angular/controllers/message_controller.dart';
//import 'package:webapp_base_ui/angular/services/signal_service.dart';
import 'package:angular_accordion/angular/decorators/flexbox_navi_handler.dart';

import 'package:logging/logging.dart';
import 'package:console_log_handler/console_log_handler.dart';

import 'package:angular_accordion/mm_uia_accordion/mm_uia_accordion.dart';

/// Entry point into app.
main() {
    configLogger();
    applicationFactory().addModule(new SampleModule()).run();
}

/// Demo Module
class SampleModule extends Module {
    SampleModule() {
        install(new AccordionModule());

        // -- controllers
        //type(MessageController);

        // -- services
        //type(SignalService);

        // -- decorator
        bind(NaviHandler);

        //factory(NgRoutingUsePushState, (_) => new NgRoutingUsePushState.value(false));
    }
}

// Weitere Infos: https://github.com/chrisbu/logging_handlers#quick-reference
void configLogger() {
    //hierarchicalLoggingEnabled = false; // set this to true - its part of Logging SDK

    Logger.root.level = Level.FINE;
    Logger.root.onRecord.listen(new LogConsoleHandler());
}