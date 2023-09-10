import 'package:contactly/models/Contact.dart';
import 'package:contactly/models/Group.dart';
import 'package:flutter/material.dart';

class Groups with ChangeNotifier {
  List<Group> _items = [];
  Map<String, List<Contact>> _ites = {
    "group1": [
      Contact(name: "Name1", id: 'TestOrganisation1', mobileNum: "+1234567890"),
      Contact(name: "Name2", id: 'TestOrganisation2', mobileNum: "+1234567890"),
      Contact(name: "Name7", id: 'TestOrganisation7', mobileNum: "+1234567890"),
    ],
    "group2": [
      Contact(name: "Name3", id: 'TestOrganisation3', mobileNum: "+1234567890"),
      Contact(name: "Name4", id: 'TestOrganisation4', mobileNum: "+1234567890"),
    ],
    "group3": [
      Contact(name: "Name5", id: 'TestOrganisation5', mobileNum: "+1234567890"),
      Contact(name: "Name6", id: 'TestOrganisation6', mobileNum: "+1234567890"),
    ],
    "group4": [
      Contact(name: "Name8", id: 'TestOrganisation8', mobileNum: "+1234567890"),
      Contact(name: "Name9", id: 'TestOrganisation9', mobileNum: "+1234567890"),
    ],
    "group5": [
      Contact(
          name: "Name10", id: 'TestOrganisation10', mobileNum: "+1234567890"),
    ]
  };

  List<Group> get items {
    return [..._items];
  }

  List<Contact>? returnByName(String s) {
    return [...?_ites[s]];
  }
  // String get returnIdByName(String s){
  //   return
  // }

  List<String> get groups {
    List<String> result = ["group1", "group2", "group3", "group4", "group5"];
    _items.map((e) {
      result.add(e.groupName);
    });
    return result;
  }
}
