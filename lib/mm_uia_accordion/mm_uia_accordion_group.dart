part of webapp_base_ui_angular.mm_uia_accordion;


// @formatter:off
@Component(
    selector        : 'accordion-group',
    visibility      : Visibility.CHILDREN,
    templateUrl     : 'packages/angular_accordion/mm_uia_accordion/mm_uia_accordion_group.html',
    useShadowDom    : false
) // @formatter:on
class AccordionGroupComponent implements DetachAware {
    final _logger = new Logger('webapp_base_ui_angular.mm_uia_accordion.AccordionGroupComponent');

    bool _isOpen = false;

    @NgOneWay('params')
    var params;

    @NgAttr('heading')
    var heading;

    var _header;

    @NgTwoWay('header')
    void set header(var html) => _header = html;

    dynamic get header => _header != null ? _header : heading;

    @NgAttr('toolbar')
    var toolbar;

    final AccordionComponent accordion;

    AccordionGroupComponent(this.accordion) {
        _logger.fine('AccordionGroupComponent');
        accordion.addGroup(this);
    }

    @NgTwoWay('is-open') get isOpen => _isOpen;

    set isOpen(var newValue) {
        _isOpen = utils.toBool(newValue);
        if (_isOpen) {
            accordion.closeOthers(this);
        }
    }

    @override
    void detach() {
        this.accordion.removeGroup(this);
    }
}

/*
 * Use accordion-heading below an accordion-group to provide a heading containing HTML
 * <accordion-group>
 *   <accordion-heading>Heading containing HTML - <img src="..."></accordion-heading>
 * </accordion-group>
 */
@Component(selector: 'accordion-heading')
class AccordionHeadingComponent {

    AccordionHeadingComponent(final html.Element element, final AccordionGroupComponent group) {
        //element.remove();
        //element.style.display = "none";
        group.header = element.innerHtml;
    }
}

@Component(selector: 'accordion-toolbar')
class AccordionToolbarComponent {
    final _logger = new Logger('webapp_base_ui_angular.mm_uia_accordion.AccordionToolbarComponent');

    AccordionToolbarComponent(final html.Element element, final AccordionGroupComponent group) {
        //element.remove();
        //        element.style.display = "none";
        //        _logger.info(element.innerHtml);
        group.toolbar = element.innerHtml;
    }

}

class MyBindHtmdModule extends Module {
    MyBindHtmdModule() {
        bind(MyBindHtmlComponent);
    }
}

@Decorator(selector: 'my-bind-html')
class MyBindHtmlComponent {
    final _logger = new Logger('webapp_base_ui_angular.mm_uia_accordion.MyBindHtmlDirective');

    final html.Element element;
    final Scope scope;
    final ViewFactoryCache viewFactoryCache;
    final DirectiveInjector directiveInjector;
    final DirectiveMap directives;

    View _view;
    Scope _childScope;

    MyBindHtmlComponent(this.element, this.scope, this.viewFactoryCache, this.directiveInjector, this.directives);

    @NgOneWay('node')
    set node(value) {

        _cleanUp();

        if (value != null && value != '') {
            _updateContent(viewFactoryCache.fromHtml(value, directives));
        }
    }

    _cleanUp() {
        if (_view == null) return;

        _view.nodes.forEach((node) => node.remove);
        _childScope.destroy();
        _childScope = null;
        element.innerHtml = '';
        _view = null;
    }

    _updateContent(final ViewFactory viewFactory) {
        // create a new scope
        try {
            _childScope = scope.createProtoChild();
            _view = viewFactory(_childScope, directiveInjector);

        }
        catch (e) {
            _logger.shout("Level 1");
            _cleanUp();

            try {
                _childScope = scope.parentScope.createProtoChild();
                _view = viewFactory(_childScope, directiveInjector);
            }

            catch (e) {
                _logger.shout("Level 2");

                _cleanUp();

                _childScope = scope.rootScope.createProtoChild();
                _view = viewFactory(_childScope, directiveInjector);
            }
        }

        _view.nodes.forEach((node) => element.append(node));

    }
}