import 'package:contactly/models/Contact.dart';

class Group {
  final String groupId;
  final String groupName;
  final String id;
  List<Contact> groupedContacts = [];
  String groupScope;
  String sharedWith;
  Group(
      {required this.groupId,
      required this.groupName,
      required this.id,
      required this.groupedContacts,
      this.groupScope = "",
      this.sharedWith = ""});
}
