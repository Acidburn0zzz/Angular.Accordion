library angular_accordion.model;

//import 'dart:html' as html;
//import 'dart:async' as async;
import 'package:logging/logging.dart' as logging;

//---------------------------------------------------------
// Notwendige externe includes
import 'package:di/annotations.dart';

//---------------------------------------------------------
// Eigene Packages

//import 'package:validate/validate.dart';
//import 'package:http_utils/http_utils.dart';

//import 'package:webapp_base_ui/angular/interfaces.dart';
//import "package:webapp_base_signer/signer.dart";

class Address {
    final _logger = new logging.Logger('basispackage.model.Address');

    final String firstname;
    final String lastname;

    Address(this.firstname, this.lastname);

    // - private --------------------------------------------------------------
}

@Injectable()
class Model {
    final _logger = new logging.Logger('basispackage.model.Model');

    final musicians = new List<Address>();

    Model() {
        musicians.add(new Address("Wolfgang Amadeus","Mozart"));
        musicians.add(new Address("Freddie","Mercury"));
        musicians.add(new Address("Frank","Zappa"));
        musicians.add(new Address("Mick","Jagger"));
    }

}

