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

    @NgAttr('heading')
    var heading;

    @NgAttr('toolbar')
    var toolbar;

    final AccordionComponent accordion;

    html.Element _extraHeader = null;

    @NgTwoWay("header")
    dynamic get header {
       return _extraHeader != null ? _extraHeader : heading;
    }

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
@Decorator(selector: 'accordion-heading')
class AccordionHeadingComponent {

    AccordionHeadingComponent(final html.Element element,final AccordionGroupComponent group) {
        element.remove();
        group.heading = element;
    }
}

@Decorator(selector: 'accordion-toolbar')
class AccordionToolbarComponent {

    AccordionToolbarComponent(final html.Element element,final AccordionGroupComponent group) {
        element.remove();
        group.toolbar = element;
    }

}