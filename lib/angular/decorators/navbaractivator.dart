library webapp_base_ui_angular.angular.decorators.navbaractivator;

import 'dart:html' as html;
import 'package:angular/angular.dart';

import 'package:logging/logging.dart';
// Handlers that are shared between client and server
//import 'package:logging_handlers/logging_handlers_shared.dart';

/**
 * Schaltet die Menüpunkte in der Navbar ein aus.
 */
@Decorator(selector: '[navbaractivator]')
class NavbarActivator {
    final _logger = new Logger('webapp_base_ui_angular.angular.decorators.navbaractivator');

    static const String _classToChange = "active";
    static const String _classForActiveParent = "enabled";
    static const String _dataAttribute = "data-route";

    final Router _router;
    final html.Element _element;
    String _routeToCheck;

    NavbarActivator(this._element, this._router) {
        _logger.fine("NavbarActivator");

        _routeToCheck = _element.getAttribute(_dataAttribute);
        _logger.fine("Route-Name: to check: ${_routeToCheck}");

        _addListener(compareAttribute: (_routeToCheck != null && _routeToCheck.isNotEmpty));
    }

    //--------------------------------------------------------------------------------
    // private

    String _route() {
        final List<String> names = new List();
        _router.activePath.forEach((final Route element) {
            names.add(element.name);
        });
        return names.join("/");
    }

    void _addListener({final bool compareAttribute }) {
        _router.onRouteStart.listen((final RouteStartEvent event) {
            event.completed.then((final bool success) {
                if (success) {
                    final String route = _route();

                    Function check = () => _compareRoutePath();
                    if (!compareAttribute) {
                        check = () => _compareFragment(event.uri);
                    }

                    if (check()) {
                        _element.classes.add(_classToChange);
                        _queryAllParents(_element,until: "nav").where((final html.Element element) => element.tagName.toLowerCase() == "li").forEach((final html.Element element) {
                            element.classes.add(_classForActiveParent);
                        });
                    }
                    else {
                        _element.classes.remove(_classToChange);
                        _queryAllParents(_element,until: "nav").where((final html.Element element) => element.tagName.toLowerCase() == "li").forEach((final html.Element element) {
                            element.classes.remove(_classForActiveParent);
                        });
                    }
                }
            });
        });
    }

    bool _compareRoutePath() {
        final String route = _route();

        _logger.fine("Changed, Route-Name to check: ${_routeToCheck}, Route-Name: $route");
        return (_routeToCheck == route);
    }

    bool _compareFragment(final String uri) {
        _logger.fine("Changed, Uri: ${uri}");

        final html.AnchorElement anchor = (_element.querySelector("a") as html.AnchorElement);
        if (anchor != null && anchor.href != null && anchor.href.indexOf("#") != -1) {
            try {
                final String fragment = anchor.href.substring(anchor.href.indexOf("#") + 1);
                _logger.fine("  -> Fragment: ${fragment}, Route-Name: ${_route()}, Uri: $uri");
                if (fragment == uri) {
                    return true;
                }
            }
            on RangeError
            catch(e) {
                _logger.fine("No fragment in ${anchor.href}");
            }
        }
        return false;
    }

    List<html.Element> _queryAllParents(final html.Element element,{ final String until }) {
        final parents = new List<html.Element>();

        html.Element parent = element.parent;
        while(parent != null) {
            if(parent.id != null && until != null && parent.id.toLowerCase() == until.toLowerCase()) {
                break;
            }

            if(until != null && parent.tagName.toLowerCase() == until.toLowerCase()) {
                break;
            }

            parents.add(parent);
            //_logger.info("Parent: ${parent.tagName.toLowerCase()}");

            parent = parent.parent;
        }

        return parents;
    }
}
