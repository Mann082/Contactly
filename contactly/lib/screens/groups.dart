import 'package:contactly/models/Contact.dart';
import 'package:contactly/providers/group_provider.dart';
import 'package:contactly/widgets/SingleContact.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GroupScreen extends StatefulWidget {
  const GroupScreen({super.key});

  @override
  State<GroupScreen> createState() => _GroupScreenState();
}

class _GroupScreenState extends State<GroupScreen> {
  List<Contact>? contacts = [];
  ListView get getList {
    return ListView.builder(
      itemBuilder: (context, index) => SingleContact(contacts![index]),
      itemCount: contacts?.length,
    );
  }

  @override
  Widget build(BuildContext context) {
    List<String> items = Provider.of<Groups>(context, listen: false).groups;
    String selectedContact = items.first;
    return RefreshIndicator(
      onRefresh: () async {
        setState(() {
          print("rebuilding...");
        });
      },
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 15),
            width: double.infinity,
            alignment: Alignment.center,
            child: DropdownMenu(
                width: 200,
                hintText: "Select Groups",
                initialSelection: "Please Select",
                onSelected: (String? value) {
                  setState(() {
                    print("presssed");
                    selectedContact = value!;
                    contacts = Provider.of<Groups>(context, listen: false)
                        .returnByName(value.toString());
                    print(contacts);
                  });
                },
                // width: double.maxFinite,
                dropdownMenuEntries: items
                    .map((e) => DropdownMenuEntry(value: e, label: e))
                    .toList()),
          ),
          const Divider(thickness: 10),
          Expanded(
              child: (contacts!.isEmpty)
                  ? const Center(
                      child: Text(
                        "No Contacts",
                        style: TextStyle(color: Colors.black),
                      ),
                    )
                  : getList),
        ],
      ),
    );
  }
}
