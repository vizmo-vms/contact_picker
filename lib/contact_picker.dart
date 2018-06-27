import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/services.dart';

class ContactPicker {
  static const MethodChannel _channel = const MethodChannel('contact_picker');

  Future<Contact> selectContact() async {
    final Map<dynamic, dynamic> result =
        await _channel.invokeMethod('selectContact');
    if (result == null) {
      return null;
    }
    return new Contact.fromMap(result);
  }
}

class Contact {
  Contact(
      {this.fullName,
      this.givenName,
      this.middleName,
      this.prefix,
      this.suffix,
      this.familyName,
      this.company,
      this.jobTitle,
      this.emails,
      this.phones,
      this.postalAddresses,
      this.ims,
      this.displayName,
      this.identifier,
      this.avatar});

  String identifier;
  String displayName;
  String givenName;
  String middleName;
  String prefix;
  String suffix;
  String familyName;
  String company;
  String jobTitle;

  // Avatar of Contact
  Uint8List avatar;

  /// The full name of the contact, e.g. "Dr. Daniel Higgens Jr.".
  String fullName;

 /// The phone numbers of the contact.
  Iterable<PhoneNumber> phones;

  /// The emails of the contact.
  Iterable<Email> emails = [];

  /// The addresses of the contact.
  Iterable<PostalAddress> postalAddresses;

  /// The instant messengers of the contact
  Iterable<Im> ims;

  Contact.fromMap(Map<dynamic, dynamic> m) {
    fullName = m['fullName'];
    identifier = m["identifier"];
    displayName = m["displayName"];
    givenName = m["givenName"];
    middleName = m["middleName"];
    familyName = m["familyName"];
    prefix = m["prefix"];
    suffix = m["suffix"];
    company = m["company"];
    jobTitle = m["jobTitle"];
    emails = (m["emails"] as Iterable)?.map((dynamic m) => new Email.fromMap(m));;
    phones = (m["phones"] as Iterable)?.map((dynamic m) => new PhoneNumber.fromMap(m));
    ims = (m["ims"] as Iterable)?.map((dynamic m) => new Im.fromMap(m));
    postalAddresses = (m["postalAddresses"] as Iterable)?.map((dynamic m) => new PostalAddress.fromMap(m));
    avatar = m["avatar"];
  }

  @override
  String toString() => '$fullName';
}

class PostalAddress {
  PostalAddress(
      {this.pobox,
      this.neighborhood,
      this.label,
      this.street,
      this.city,
      this.postcode,
      this.region,
      this.country});

    factory PostalAddress.fromMap(Map<dynamic, dynamic> m) =>
      new PostalAddress(
    label: m["label"],
    street: m["street"],
    city: m["city"],
    postcode: m["postcode"],
    region: m["region"],
    country: m["country"],
    pobox: m['pobox'],
    neighborhood: m['neighborhood']);


 // String pobox, neighborhood, label, street, city, postcode, region, country;
  /// Address
  final String pobox;

  /// The label associated with the phone number, e.g. "home" or "work".
  final String label;
      /// Address
  final String neighborhood;
    /// Address
  final String street;
    /// Address
  final String city;
    /// Address
  final String postcode;
    /// Address
  final String region;
      /// Address
  final String country;
  

  @override
  String toString() => '$street $city $region $postcode ($label)';
}

/// Represents a phone number selected by the user.
class PhoneNumber {
  PhoneNumber({this.number, this.label});

  factory PhoneNumber.fromMap(Map<dynamic, dynamic> map) =>
      new PhoneNumber(number: map['phone'], label: map['label']);

  /// The formatted phone number, e.g. "+1 (555) 555-5555"
  final String number;

  /// The label associated with the phone number, e.g. "home" or "work".
  final String label;

  @override
  String toString() => '$number ($label)';
}

/// Represents a email address
class Email {
  Email({this.email, this.label});

  factory Email.fromMap(Map<dynamic, dynamic> map) =>
      new Email(email: map['email'], label: map['label']);

  /// The raw email address
  final String email;

  /// The label associated with the email, e.g. "home" or "work".
  final String label;

  @override
  String toString() => '$email ($label)';
}

/// Represents a instant messaging endpoint
class Im {
  Im({this.value, this.label, this.protocol});

  factory Im.fromMap(Map<dynamic, dynamic> map) =>
      new Im(value: map['im'], label: map['label'], protocol: map['protocol']);

  /// The IM endpoint
  final String value;

  /// The label associated with the endpoint, e.g. "home" or "work".
  final String label;

  /// The IM protocol, e.g. Skype, Hangouts ...
  final String protocol;

  @override
  String toString() => '$value $protocol ($label)';
}
