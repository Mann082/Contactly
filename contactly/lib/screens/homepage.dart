import 'package:contactly/models/searchDeligate.dart';
import 'package:contactly/screens/groups.dart';
import 'package:contactly/widgets/add_contact_button.dart';
import 'package:contactly/widgets/sms.dart';
import '../widgets/Contacts_widget.dart';
import 'package:contactly/widgets/drawer.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  static const routeName = "/home";
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<Map<String, Object>> _pages = [];
  int _selectedPage = 2;
  @override
  void initState() {
    _pages = [
      {"page": GroupScreen(), "title": "Groups"},
      {"page": SMSScreen(), "title": "SMS"},
      {"page": Contacts(), "title": "All Contacts"},
    ];
    super.initState();
  }

  void _change(int idx) {
    setState(() {
      _selectedPage = idx;
    });
  }

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          floatingActionButton: CircleAvatar(
            maxRadius: 30,
            backgroundColor: Theme.of(context).primaryColor,
            child: IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                  Navigator.of(context).pushNamed(addContact.routeName);
                }),
          ),
          drawer: const Maindrawer(),
          appBar: AppBar(
            title: Text(_pages[_selectedPage]["title"] as String),
            actions: [
              IconButton(
                  onPressed: () {
                    showSearch(
                        context: context, delegate: CustomSearchDeligate());
                  },
                  icon: const Icon(Icons.search))
            ],
          ),
          body: Container(
            color: Theme.of(context).primaryColor,
            child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                  color: Color.fromARGB(255, 255, 255, 255),
                  // boxShadow: [BoxShadow(blurStyle: BlurStyle.solid)]),
                  // decoration: BoxDecoration(
                  //     border: Border.all(color: Colors.black, width: 0),
                  //     borderRadius: BorderRadius.only(
                  //         topLeft: Radius.circular(20),
                  //         topRight: Radius.circular(20))),
                ),
                child: _pages[_selectedPage]["page"] as Widget),
          ),
          bottomNavigationBar: BottomNavigationBar(
              onTap: _change,
              backgroundColor: Colors.white,
              selectedItemColor: Colors.blue,
              unselectedItemColor: Colors.grey,
              // elevation:,
              currentIndex: _selectedPage,
              type: BottomNavigationBarType.fixed,
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(Icons.groups),
                    label: "Groups",
                    backgroundColor: Colors.white),
                BottomNavigationBarItem(
                    icon: Icon(Icons.message),
                    label: "SMS",
                    backgroundColor: Colors.white),
                BottomNavigationBarItem(
                    icon: Icon(Icons.contacts),
                    backgroundColor: Colors.white,
                    label: "Contacts")
              ]),
        ));
  }
}
