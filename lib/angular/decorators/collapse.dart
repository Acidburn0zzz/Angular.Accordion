library webapp_base_ui_angular.decorator.collapse;

import 'dart:html' as html;
//import 'dart:async';

import "package:angular/angular.dart";
import 'package:angular/core/annotation_src.dart';

import 'package:logging/logging.dart';

//---------------------------------------------------------
// Eigene Packages

//import 'package:http_utils/http_utils.dart';
//import 'package:validate/validate.dart';

//import 'package:webapp_base_dart/communication.dart';
//import 'package:webapp_base_dart/events.dart';
//import 'package:webapp_base_ui/uievents.dart';


/**
 * Collapse Module.
 *    Weitere Infos: https://docs.angulardart.org/#di.Module
 */
class CollapseModule extends Module {
    CollapseModule() {
        bind(CollapseDecorator);
    }
}

typedef void _Action();

// @formatter:off    
/// Collapse-Decorator
@Decorator(selector: '[collapse]')
class CollapseDecorator {
    final _logger = new Logger('webapp_base_ui.decorator.collapse.CollapseDecorator');

    final String _classToSet = "collapse";

    bool _collapse = true;

    final html.Element _element;

    CollapseDecorator(this._element) {
        _logger.fine("$_element");
    }

    @NgTwoWay("collapse")  // =>
    void set isCollapse(final bool value) {
        _collapse = value;
        if(_collapse) {
            _shrink();
        } else {
            _expand();
        }
    }


    // --------------------------------------------------------------------------------------------
    // EventHandler

    void handleEvent(final html.Event e) {
        _logger.fine("Event: handleEvent");
    }

    // -- private ---------------------------------------------------------------------------------

    void _shrink() {
        _logger.fine("Shrink!");
        _element.classes.add(_classToSet);
    }

    void _expand() {
        _logger.fine("Expand!");
        _element.classes.remove(_classToSet);
    }
}
        