import 'dart:io';
import 'package:contactly/models/Contact.dart';
import 'package:contactly/providers/auth.dart';
import 'package:contactly/providers/contact_provider.dart';
import 'package:contactly/screens/homepage.dart';
import 'package:contactly/widgets/SingleContact.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as mt;
import 'package:file_picker/file_picker.dart';
import 'package:excel/excel.dart';
import 'package:provider/provider.dart';

class excelUploadScreen extends StatefulWidget {
  static const routeName = "/excelUploadScreen";
  @override
  _excelScreenState createState() => _excelScreenState();
}

class _excelScreenState extends State<excelUploadScreen> {
  List<Contact> objects = [];
  String id = "";
  Future<void> pickAndProcessExcel() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['xlsx'],
    );

    if (result != null && result.files.isNotEmpty) {
      String filePath = result.files.first.path!;
      var bytes = File(filePath).readAsBytesSync();
      var excel = Excel.decodeBytes(bytes);
      bool check = true;
      // print(excel.tables['Sheet1']!.rows);
      for (var table in excel.tables.keys) {
        for (var row in excel.tables[table]!.rows) {
          if (check) {
            check = false;
            continue;
          }
          // Assuming each row represents an object with columns: Name, Age, Email
          print(row[0]!.value);
          print(row[1]!.value as double..round());
          print(row[2]!.value);
          String name = row[0]!.value.toString();
          String phone =
              double.parse(row[1]!.value.toString()).round().toString();
          String email = row[2]!.value.toString();
          // Create an object and add it to the list
          objects
              .add(Contact(id: id, name: name, mobileNum: phone, email: email));
        }
      }

      setState(() {}); // Update the UI with created objects
    }
  }

  @override
  Widget build(BuildContext context) {
    id = Provider.of<Auth>(context, listen: false).uid;
    return Scaffold(
      floatingActionButton: IconButton(
          onPressed: () {
            setState(() {
              objects.clear();
            });
          },
          icon: const Icon(Icons.delete)),
      appBar: AppBar(
        title: const Text('Excel Object Creator'),
        actions: [
          GestureDetector(
            onTap: () {
              Provider.of<Contactsp>(context, listen: false)
                  .addToLocal(objects);
              Navigator.of(context).pop();
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  actions: [
                    TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text("Okay"))
                  ],
                  title: const Text("Successful!"),
                  content: const Text(
                      "All Excel Contacts are Added Successfully!!!"),
                ),
              );
            },
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.only(right: 10, top: 10, bottom: 10),
              decoration: BoxDecoration(
                  border: mt.Border.all(color: Colors.lightBlue),
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.lightBlue),
              height: 20,
              child: const Text("Save",
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: pickAndProcessExcel,
              child: const Text('Pick and Process Excel'),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: objects.length,
                itemBuilder: (context, index) {
                  return SingleContact(objects[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class UserObject {
  final String name;
  final int age;
  final String email;

  UserObject({required this.name, required this.age, required this.email});
}
