import 'package:contactly/models/Contact.dart' as ct;
import 'package:contactly/providers/group_provider.dart';
import '../providers/contact_provider.dart';
import 'package:contactly/widgets/SingleContact.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomSearchDeligate extends SearchDelegate {
  List<ct.Contact> ContactList = [];
  List<String> groupName = [];
  @override
  List<Widget>? buildActions(BuildContext context) {
    ContactList = Provider.of<Contactsp>(context, listen: false).items;
    return [
      IconButton(
        onPressed: () {
          query = "";
        },
        icon: const Icon(Icons.clear),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    ContactList = Provider.of<Contactsp>(context, listen: false).items;
    groupName = Provider.of<Groups>(context, listen: false).groups;
    List<ct.Contact> matchQuery = [];
    Set<ct.Contact> matchSet = {};
    for (var cont in ContactList) {
      if (cont.name.toLowerCase().contains(query.toLowerCase())) {
        matchSet.add(cont);
      }
    }
    for (var name in groupName) {
      if (name.toLowerCase().contains(query.toLowerCase())) {
        List<ct.Contact>? groupedContacts =
            Provider.of<Groups>(context, listen: false).returnByName(name);
        matchSet.addAll(groupedContacts!);
      }
    }
    matchQuery = matchSet.toList();
    return ListView.builder(
      itemBuilder: (context, index) {
        return SingleContact(matchQuery[index]);
      },
      itemCount: matchQuery.length,
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    ContactList = Provider.of<Contactsp>(context, listen: false).items;
    groupName = Provider.of<Groups>(context, listen: false).groups;
    List<ct.Contact> matchQuery = [];
    Set<ct.Contact> matchSet = {};
    for (var cont in ContactList) {
      if (cont.name.toLowerCase().contains(query.toLowerCase())) {
        matchSet.add(cont);
      }
    }
    for (var name in groupName) {
      if (name.toLowerCase().contains(query.toLowerCase())) {
        List<ct.Contact>? groupedContacts =
            Provider.of<Groups>(context, listen: false).returnByName(name);
        matchSet.addAll(groupedContacts!);
      }
    }
    matchQuery = matchSet.toList();
    return ListView.builder(
      itemBuilder: (context, index) {
        return SingleContact(matchQuery[index]);
      },
      itemCount: matchQuery.length,
    );
  }
}
