import 'package:contactly/models/Contact.dart';
import 'package:contactly/screens/Contact_details.dart';
import 'package:flutter/material.dart';

class SingleContact extends StatelessWidget {
  final Contact item;
  const SingleContact(this.item, {super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: CircleAvatar(
              backgroundColor: Theme.of(context).primaryColor,
              child: Text(
                item.name[0].toUpperCase(),
                style: const TextStyle(fontWeight: FontWeight.bold),
              )),
          title: Text(item.name),
          subtitle: Text(item.mobileNum),
          trailing: const Icon(Icons.info_outline),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => contactDetailScreen(item: item),
                ));
          },
        ),
        const Divider()
      ],
    );
  }
}
