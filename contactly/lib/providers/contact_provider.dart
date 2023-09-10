import 'dart:convert';
import 'package:localstorage/localstorage.dart';

import 'package:http/http.dart' as http;
import 'package:contactly/models/Contact.dart';
import 'package:contactly/providers/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Contactsp with ChangeNotifier {
  ContactList _local = ContactList([]);
  ContactList _server = ContactList([]);
  bool initialized = false;
  final LocalStorage storage = LocalStorage('contact-app.json');
  // List<Contact> _items = [
  // Contact(name: "Name1", id: 'TestOrganisation1', mobileNum: "+1234567890"),
  // Contact(name: "Name2", id: 'TestOrganisation2', mobileNum: "+1234567890"),
  // Contact(name: "Name3", id: 'TestOrganisation3', mobileNum: "+1234567890"),
  // Contact(name: "Name4", id: 'TestOrganisation4', mobileNum: "+1234567890"),
  // Contact(name: "Name5", id: 'TestOrganisation5', mobileNum: "+1234567890"),
  // Contact(name: "Name6", id: 'TestOrganisation6', mobileNum: "+1234567890"),
  // Contact(name: "Name7", id: 'TestOrganisation7', mobileNum: "+1234567890"),
  // Contact(name: "Name8", id: 'TestOrganisation8', mobileNum: "+1234567890"),
  // Contact(name: "Name9", id: 'TestOrganisation9', mobileNum: "+1234567890"),
  // Contact(name: "Name10", id: 'TestOrganisation10', mobileNum: "+1234567890"),
  // ];
  List<Contact> get items {
    List<Contact> temp = [..._local.items];
    temp.addAll(_server.items);
    return temp;
  }

  Future<void> fetchAndSetContactsLocal(BuildContext context) async {
    var uid = Provider.of<Auth>(context, listen: false).uid;
    if (initialized == false) {
      var items = storage.getItem("contacts");
      List<Contact> fetched = [];
      if (items != null) {
        fetched = List<Contact>.from((items as List).map((e) {
          return Contact(
              id: e['id'], name: e['name'], mobileNum: e['mobileNum']);
        }));
        // items.map((e) {
        //   Contact temp =
        //       Contact(id: e['id'], name: e['name'], mobileNum: e['mobileNum']);
        //   fetched.add(temp);
        // });
      }
      _local.items = fetched;
      initialized = true;
    }
  }

  Future<void> addToLocal(List<Contact> l) async {
    _local.items.addAll(l);
    await _saveLocal();
    notifyListeners();
  }

  Future<void> addToServer(List<Contact> l, BuildContext context) async {
    try {
      var url = Uri.https(
          "contactapp-d93h.onrender.com", "/applications/upload_contact/");
      List<List<String?>> l1 = [];
      for (var i in l) {
        l1.add(i.toList());
      }
      Map<String, dynamic> toUpload = {
        'id': Provider.of<Auth>(context, listen: false).uid,
        'token': Provider.of<Auth>(context, listen: false).token,
        'data': l1
      };
      var response = await http.post(url,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(toUpload));
      print(l[0].toList());
      print(toUpload);
      print(jsonEncode(toUpload).toString());
      print(response.body);
      print("uploaded successfully");
    } catch (err) {
      print(err.toString());
    }
  }

  _saveLocal() {
    storage.setItem('contacts', _local.toJSONEncodable());
  }

  _clearStorage() async {
    await storage.clear();
    notifyListeners();
  }

  Future<void> deleteLocal() async {
    _local.items.clear();
    await _clearStorage();
  }

  Future<void> fetchAndSetContacts(BuildContext context) async {
    await fetchAndSetContactsServer(context);
    await fetchAndSetContactsLocal(context);
  }

  Future<void> fetchAndSetContactsServer(BuildContext context) async {
    var uid = Provider.of<Auth>(context, listen: false).uid;
    var token = Provider.of<Auth>(context, listen: false).token;
    List<Contact> temp = [..._server.items];
    try {
      final url = Uri.https("contactapp-d93h.onrender.com",
          "/applications/get_contacts/", {'id': uid, 'token': token});
      print('This code is running');
      var response = await http.get(url);
      _server.items.clear();
      final Map<String, dynamic> responseData = json.decode(response.body);
      print(response.body);
      List<dynamic> contactData = responseData['data'];
      for (var m in contactData) {
        var e = m;
        Contact temp = Contact(
            mobileNum: e[0] as String,
            name: e[1] as String,
            email: e[2] as String?,
            profession: e[3] as String?,
            relation: e[4] as String?,
            dob: e[5] as String?,
            address: e[6] as String?,
            city: e[7] as String?,
            pincode: e[8] as String?,
            gender: e[9] as String?,
            id: uid);
        _server.items.add(temp);
      }
    } catch (err) {
      _server.items.clear();
      _server.items = [...temp];
      print(err.toString());
    }
  }

//   Future<void> fetchAndSetContacts(BuildContext context) async {
//     var uid = Provider.of<Auth>(context, listen: false).uid;
//     var token = Provider.of<Auth>(context, listen: false).token;
//     // final url = Uri.https("contactapp-d93h.onrender.com",
//     //     "/applications/get_contacts/", {'id': uid, 'token': token});
//     try {
//       final url = Uri.https("contactapp-d93h.onrender.com",
//           "/applications/get_contacts/", {'id': uid, 'token': token});
//       print('This code is running');
//       var response = await http.get(url);
//       final Map<String, dynamic> responseData = json.decode(response.body);
//       print(response.body);
//       List<dynamic> contactData = responseData['data'];
//       List<List<String?>> ctd = [];
//       for (var x in contactData) {
//         ctd.add(x);
//       }
//       ctd.map((a) {
//         //output format
// // mobile_num, name, email, profession, relation, dob, address, city, pincode, gender
//         List<String?> e = a;
//         Contact temp = Contact(
//             mobileNum: e[0] as String,
//             name: e[1] as String,
//             email: e[2],
//             profession: e[3],
//             relation: e[4],
//             dob: e[5],
//             address: e[6],
//             city: e[7],
//             pincode: e[8],
//             gender: e[9],
//             id: uid);
//         _items.add(temp);
//       });
//     } catch (err) {
//       print(err.toString());
//     }
//   }
}
