import 'package:contactly/providers/contact_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});
  static const routeName = "/settings";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      backgroundColor: Colors.grey[400],
      body: Center(
        child: Column(
          children: [
            GestureDetector(
              child: const ListTile(
                  title: Text("Delete All Contacts"), tileColor: Colors.white),
              onTap: () => showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                        title: const Text("Warning!!"),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text("No")),
                          TextButton(
                              onPressed: () {
                                Provider.of<Contactsp>(context, listen: false)
                                    .deleteLocal();
                                Navigator.of(context).pop();
                              },
                              child: const Text("Yes"))
                        ],
                        content: const Text(
                          "Are you sure you want to delete all Contacts?",
                          style: TextStyle(color: Colors.black),
                        ),
                      )),
            )
          ],
        ),
      ),
    );
  }
}
