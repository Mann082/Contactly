import 'package:contactly/providers/auth.dart';
import 'package:contactly/screens/excel_upload_screen.dart';
import 'package:contactly/screens/settings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Maindrawer extends StatelessWidget {
  const Maindrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Container(
          padding: const EdgeInsets.only(top: 30),
          alignment: Alignment.center,
          height: 120,
          color: Theme.of(context).primaryColor,
          child: Text(
            "Welcome ${Provider.of<Auth>(context, listen: false).name}",
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 30, color: Colors.white),
          ),
        ),
        const Divider(),
        TextButton(
          onPressed: () {},
          child: const Row(
            children: [Icon(Icons.person_2_rounded), Text("Profile")],
          ),
        ),
        const Divider(),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            Navigator.of(context).pushNamed(excelUploadScreen.routeName);
          },
          child: const Row(
            children: [Icon(Icons.upload), Text("Upload Excel")],
          ),
        ),
        const Divider(),
        TextButton(
            onPressed: () {
              Navigator.of(context).pushNamed(Settings.routeName);
            },
            child: const Row(
              children: [Icon(Icons.settings), Text("Settings")],
            )),
        const Divider(),
        TextButton(
            onPressed: () {
              Provider.of<Auth>(context, listen: false).logout();
            },
            child: const Row(
              children: [Icon(Icons.logout), Text("Logout")],
            )),
      ]),
    );
  }
}
