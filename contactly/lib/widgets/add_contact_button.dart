import 'dart:convert';
import 'package:contactly/models/Contact.dart';
import 'package:contactly/models/Group.dart';
import 'package:contactly/providers/auth.dart';
import 'package:contactly/providers/contact_provider.dart';
import 'package:contactly/providers/group_provider.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class addContact extends StatefulWidget {
  static const routeName = "/addContact";
  addContact({super.key});

  @override
  State<addContact> createState() => _addContactState();
}

class _addContactState extends State<addContact> {
  final GlobalKey<FormState> _Formkey = GlobalKey();

  String? groupId;
  String? gender;
  bool _isLoading = false;

  final FocusNode _phoneNoFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _professionFocus = FocusNode();
  final FocusNode _dobFocus = FocusNode();
  final FocusNode _addressFocus = FocusNode();
  final FocusNode _cityFocus = FocusNode();
  final FocusNode _pincodeFocus = FocusNode();

  final TextEditingController _namecontroller = TextEditingController();

  final TextEditingController _phonecontroller = TextEditingController();

  final TextEditingController _emailcontroller = TextEditingController();

  final TextEditingController _professioncontroller = TextEditingController();

  final TextEditingController _dobController = TextEditingController();

  final TextEditingController _addressController = TextEditingController();

  final TextEditingController _citycontroller = TextEditingController();

  final TextEditingController _pincodeController = TextEditingController();

  late String _uid;
  late String _token;

  // Future<void> _submit() async {
  //   var url = Uri.parse(
  //       'https://contactapp-d93h.onrender.com/applications/upload_contact');

  //   var headers = {'Content-Type': 'application/json'};

  //   var jsonData = {
  //     'id': 123456,
  //     'name': 'acha_yo',
  //     'mob': 111,
  //     'token': '4219d6dd88f9eacf4b37',
  //   };

  //   try {
  //     final response = await http.post(
  //       url,
  //       headers: headers,
  //       body: jsonEncode(jsonData),
  //     );

  //     if (response.statusCode == 200) {
  //       print('Post request successful');
  //       print('Response body: ${response.body}');
  //     } else {
  //       print('Post request failed with status code: ${response.statusCode}');
  //     }
  //   } catch (error) {
  //     print('Error during HTTP request: $error');
  //   }
  // }

  Future<void> _submit() async {
    if (_Formkey.currentState!.validate()) {
      _Formkey.currentState!.save();
      setState(() {
        _isLoading = true;
      });
      // try {
      // var url = Uri.https(
      //     "contactapp-d93h.onrender.com", "/applications/upload_contact/");
      // var headers = {"Content-Type": "application/json"};
      // print(url);
      // var body = {
      //   "id": _uid,
      //   "token": _token,
      //   "mob": _phonecontroller.text.isEmpty ? null : _phonecontroller.text,
      //   "name": _namecontroller.text.isEmpty ? null : _namecontroller.text,
      //   "email": _emailcontroller.text.isEmpty ? null : _emailcontroller.text,
      //   "profession": _professioncontroller.text.isEmpty
      //       ? null
      //       : _professioncontroller.text,
      //   // "dob": _dobController.text.isEmpty ? null : _dobController.text,
      //   "address":
      //       _addressController.text.isEmpty ? null : _addressController.text,
      //   "city": _citycontroller.text.isEmpty ? null : _citycontroller.text,
      //   "pincode":
      //       _pincodeController.text.isEmpty ? null : _pincodeController.text,
      //   "gender": gender,
      // };

      // print(body);
      //   final response =
      //       await http.post(url, headers: headers, body: jsonEncode(body));
      //   print(jsonDecode(response.body));
      // } catch (err) {
      //   print(err.toString());
      // }
      Contact newct = Contact(
          id: _uid,
          name: _namecontroller.text,
          mobileNum: _phonecontroller.text);
      List<Contact> l = [];
      l.add(newct);
      Provider.of<Contactsp>(context, listen: false).addToServer(l, context);
      setState(() {
        _isLoading = false;
      });
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    _uid = Provider.of<Auth>(context, listen: false).uid;
    _token = Provider.of<Auth>(context, listen: false).token;
    final size = MediaQuery.of(context).size.width;
    final List<String> groupsList = Provider.of<Groups>(context).groups;
    return Scaffold(
      appBar: AppBar(
        title: const Text("New Contact"),
        actions: [
          GestureDetector(
            onTap: _submit,
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.only(right: 10, top: 10, bottom: 10),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.lightBlue),
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.lightBlue),
              height: 20,
              child: const Text("Save",
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          )
        ],
      ),
      // backgroundColor: Colors.grey[400],
      body: (_isLoading)
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Form(
              key: _Formkey,
              child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: _namecontroller,
                        keyboardType: TextInputType.name,
                        decoration: const InputDecoration(
                            labelText: "Name",
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.black, width: 3))),
                        validator: (value) {
                          if (value!.length <= 3) {
                            return "Please Enter a Name";
                          } else {
                            return null;
                          }
                        },
                        onEditingComplete: () => _phoneNoFocus.requestFocus(),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: _phonecontroller,
                        keyboardType: TextInputType.number,
                        focusNode: _phoneNoFocus,
                        decoration: const InputDecoration(
                            labelText: "Phone Number",
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.black, width: 3))),
                        validator: (value) {
                          if (value == null || value.length == 0) {
                            return "Please Enter a Mobile Number";
                          }
                          return null;
                        },
                        onEditingComplete: () => _emailFocus.requestFocus(),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: _emailcontroller,
                        focusNode: _emailFocus,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                            labelText: "Email",
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.black, width: 3))),
                        validator: (value) {
                          if (value!.length == 0 || value == null) return null;
                          if (value != null &&
                              !value.contains('.') &&
                              !value.contains('&')) {
                            return "Please Enter a valid Email Address Number";
                          }
                          return null;
                        },
                        onEditingComplete: () =>
                            _professionFocus.requestFocus(),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: _professioncontroller,
                        keyboardType: TextInputType.name,
                        focusNode: _professionFocus,
                        decoration: const InputDecoration(
                            labelText: "Profession",
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.black, width: 3))),
                        validator: (value) {
                          return null;
                        },
                        onEditingComplete: () => _dobFocus.requestFocus(),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      DropdownMenu(
                          width: size - 20,
                          label: const Text("Gender"),
                          menuStyle: const MenuStyle(
                              elevation: MaterialStatePropertyAll(15)),
                          onSelected: (value) {
                            gender = value!;
                          },
                          dropdownMenuEntries: const [
                            DropdownMenuEntry(value: "Male", label: "Male"),
                            DropdownMenuEntry(value: "Female", label: "Female")
                          ]),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: _dobController,
                        focusNode: _dobFocus,
                        keyboardType: TextInputType.datetime,
                        decoration: const InputDecoration(
                            labelText: "DOB",
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.black, width: 3))),
                        validator: (value) => null,
                        onEditingComplete: () => _addressFocus.requestFocus(),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: _addressController,
                        focusNode: _addressFocus,
                        keyboardType: TextInputType.streetAddress,
                        decoration: const InputDecoration(
                            labelText: "Address",
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.black, width: 3))),
                        validator: (value) => null,
                        onEditingComplete: () => _cityFocus.requestFocus(),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: _citycontroller,
                        focusNode: _cityFocus,
                        keyboardType: TextInputType.name,
                        decoration: const InputDecoration(
                            labelText: "City",
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.black, width: 3))),
                        validator: (value) => null,
                        onEditingComplete: () => _pincodeFocus.requestFocus(),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: _pincodeController,
                        focusNode: _pincodeFocus,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                            labelText: "Pincode",
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.black, width: 3))),
                        validator: (value) => null,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      DropdownMenu(
                        label: const Text("Select Group"),
                        width: size - 20,
                        menuStyle: const MenuStyle(
                            elevation: MaterialStatePropertyAll(15)),
                        dropdownMenuEntries: groupsList
                            .map((e) => DropdownMenuEntry(
                                  value: e,
                                  label: e,
                                ))
                            .toList(),
                        onSelected: (value) {
                          groupId = value!;
                        },
                      )
                    ],
                  )),
            ),
    );
  }

  @override
  void dispose() {
    _phoneNoFocus.dispose();
    _emailFocus.dispose();
    _professionFocus.dispose();
    _dobFocus.dispose();
    _addressFocus.dispose();
    _cityFocus.dispose();
    _pincodeFocus.dispose();
    _addressController.dispose();
    _citycontroller.dispose();
    _dobController.dispose();
    _emailcontroller.dispose();
    _namecontroller.dispose();
    _phonecontroller.dispose();
    _pincodeController.dispose();
    super.dispose();
  }
}
