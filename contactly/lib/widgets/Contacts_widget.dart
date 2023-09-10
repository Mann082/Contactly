import 'package:contactly/models/Contact.dart';
import '../providers/contact_provider.dart';
import 'package:contactly/widgets/SingleContact.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Contacts extends StatefulWidget {
  Contacts({super.key});

  @override
  State<Contacts> createState() => _ContactsState();
}

class _ContactsState extends State<Contacts> {
  final ScrollController _scrollController = ScrollController();
  Widget _getList(List<Contact> _ContactsList) {
    return ListView.builder(
      controller: _scrollController,
      itemCount: _ContactsList.length,
      itemBuilder: (context, index) {
        return SingleContact(_ContactsList[index]);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var ctProvider = Provider.of<Contactsp>(context);
    return FutureBuilder(
      future: ctProvider.storage.ready,
      builder: (context, snapshot) {
        if (snapshot.data == null) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return FutureBuilder(
          future: ctProvider.fetchAndSetContacts(context),
          builder: (context, snapshot) =>
              snapshot.connectionState == ConnectionState.waiting
                  ? const Center(child: CircularProgressIndicator())
                  : Scrollbar(
                      thumbVisibility: true,
                      controller: _scrollController,
                      trackVisibility: true,
                      interactive: true,
                      radius: const Radius.circular(10),
                      thickness: 10,
                      hoverThickness: 15,
                      child: (ctProvider.items.isEmpty)
                          ? const Center(
                              child: Text(
                                "No Contacts",
                                style: TextStyle(color: Colors.black),
                              ),
                            )
                          : _getList(ctProvider.items),
                    ),
        );
      },
    );
  }
}

  // Widget build(BuildContext context) {
  //   final List<Contact> _ContactsList = Provider.of<Contactsp>(context).items;
  //   // Map<Char, Contact> mappedContacts= _getmap(ContactsList);
  //   return RefreshIndicator(
  //     onRefresh: () => Provider.of<Contactsp>(context, listen: false)
  //         .fetchAndSetContacts(context),
  //     child: FutureBuilder(
  //       future: Provider.of<Contactsp>(context).fetchAndSetContacts(context),
  //       builder: (ctx, snapshot) =>
  //           snapshot.connectionState == ConnectionState.waiting
  //               ? const Center(
  //                   child: CircularProgressIndicator(),
  //                 )
  //               : Scrollbar(
  //                   thumbVisibility: true,
  //                   controller: _scrollController,
  //                   trackVisibility: true,
  //                   interactive: true,
  //                   radius: const Radius.circular(10),
  //                   thickness: 10,
  //                   hoverThickness: 15,
  //                   child: _getList(_ContactsList),
  //                 ),
  //     ),
  //   );
  // }