// Copyright 2017 Michael Goderbauer. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

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
                  });
                },
                color: Colors.blue,
              ),
              new Container(
                height: 20.0,
              ),
              new Text(
                _contact == null ? 'No contact selected.' : _contact.toString(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
