library webapp_base_ui_angular.angular.decorators.flexbox_navi_handler;

import 'dart:html' as html;
import 'package:angular/angular.dart';


@Decorator(selector: '[flexbox-navi-handler]')
class NaviHandler {

    NaviHandler() {
        _togglerFor("a#toggle-sidenav", "hideSideNav");
        _togglerFor("a#toggle-debugcss", "debugCSS");
        _togglerFor("a#toggle-sidebar", "hideSideBar");
        _togglerFor("a#toggle-log", "showLog");

        // Muss händisch gesetzt werden da es sein kann dass eine Seite noch nicht
        // geladen ist un dann ist der #sidenav selektor nicht vorhanden.
        /*
        if(dom.querySelector("#sidebar") == null) {
            dom.querySelector("body").classes.toggle("noSideBar");
        }
        */

        if (html.querySelector("#log") == null) {
            html.querySelector("body").classes.toggle("noLog");
        }


        if (html.querySelector("#sidenav") == null) {
            html.querySelector("body").classes.toggle("noSideNav");
        }

    }

    //-------------------------------------------------------------------------
    // private

    void _togglerFor(final String selector, final String classToToggle) {
        html.querySelector(selector).onClick.listen((final html.MouseEvent event) {
            event.preventDefault();
            event.stopPropagation();
            html.querySelector("body").classes.toggle(classToToggle);
        });
    }
}
