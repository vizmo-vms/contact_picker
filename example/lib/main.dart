import 'package:flutter/material.dart';
import 'package:contact_picker/contact_picker.dart';
import 'package:simple_permissions/simple_permissions.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final ContactPicker _contactPicker = new ContactPicker();
  Contact _contact;

  bool _hasPermissions = false;

  @override
  void initState() {
    super.initState();

    initPermissions();
  }

  void initPermissions() async {
    final bool granted =
        await SimplePermissions.checkPermission(Permission.ReadContacts);
    setState(() {
      _hasPermissions = granted;
    });
  }

  void _requestPermissions() async {
    final bool granted =
        await SimplePermissions.requestPermission(Permission.ReadContacts);
    setState(() {
      _hasPermissions = granted;
    });
  }

  void _updateContactInfo(Contact c) {
    if (c != null) {
      // print(_contact.toString());

      //Name
      String _firstName = "";
      String _middleName = "";
      String _lastName = "";
      _firstName = _contact.givenName.toString();
      _middleName = _contact.middleName.toString();
      _lastName = _contact.familyName.toString();

      // //Phone Numbers
      // String _home = "";
      // String _cell = "";
      // String _office = "";
      // Iterable<PhoneNumber> _numbers = _contact.phones.toList();
      // for (var item in _numbers) {
      //   if (item.label.contains('home')) {
      //     _home = item.number.toString();
      //   } else if (item.label.contains('mobile')) {
      //     _cell = item.number.toString();
      //   } else if (item.label.contains('work')) {
      //     _office = item.number.toString();
      //   } else {
      //     _cell = item.number.toString();
      //   }
      // }

      //Email
      String _email = "";
      try {
        _email = _contact.emails?.first?.email.toString();
        // print("Email: $_email\n ");
      } catch (e) {
        // print(e);
      }

      //Address Info
      String _street = "";
      String _city = "";
      String _state = "";
      String _zip = "";
      try {
      _street = _contact.postalAddresses?.first?.street.toString();
      _city = _contact.postalAddresses?.first?.city.toString();
      _state = _contact.postalAddresses?.first?.region.toString();
      _zip = _contact.postalAddresses?.first?.postcode.toString();
      } catch (e) {
        // print(e);
      }
     
    } else {
      print("No Contact Selected");
    }
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: const Text('Plugin example app'),
        ),
        body: new Center(
          child: new Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              !_hasPermissions
                  ? new RaisedButton(
                      child: const Text("Request permissions"),
                      onPressed: _requestPermissions,
                      color: Colors.amber,
                    )
                  : new Container(),
              new Container(
                height: 20.0,
              ),
              new RaisedButton(
                child: const Text(
                  "Select Contact",
                  style: const TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  final Contact contact = await _contactPicker.selectContact();
                  setState(() {
                    _contact = contact;
                    _updateContactInfo(_contact);
                  });
                },
                color: Colors.blue,
              ),
              new Container(
                height: 20.0,
              ),
              // new Text(
              //   // _contact == null ? 'No contact selected.' : _contact.toString(),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
