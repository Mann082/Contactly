import 'package:contactly/models/Contact.dart';
import 'package:flutter/material.dart';

class contactDetailScreen extends StatelessWidget {
  static const routeName = "/contactDetails";
  final Contact item;
  const contactDetailScreen({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(item.name),
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.edit)),
            IconButton(
                onPressed: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (_) => const Column(
                            children: [
                              Text(
                                "Hello",
                                style: TextStyle(color: Colors.black),
                              ),
                              Text("data")
                            ],
                          ));
                },
                icon: const Icon(Icons.more_vert))
          ],
        ),
        backgroundColor: Colors.grey[400],
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              Center(
                child: Card(
                  elevation: 15,
                  shape: const CircleBorder(),
                  child: CircleAvatar(
                    backgroundColor: Theme.of(context).primaryColor,
                    radius: 70,
                    child: Text(
                      item.name[0],
                      style: const TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                width: double.infinity,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 25,
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.phone,
                          size: 25,
                        ),
                      ),
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 25,
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.message,
                          size: 25,
                        ),
                      ),
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 25,
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.video_call,
                          size: 25,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Card(
                  color: Colors.grey[200],
                  elevation: 5,
                  child: Container(
                    width: double.infinity,
                    height: 60,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Name:-",
                          style: TextStyle(color: Colors.black),
                        ),
                        Text(
                          item.name,
                          style: const TextStyle(
                              color: Colors.black, fontSize: 35),
                        )
                      ],
                    ),
                  )),
            ],
          ),
        ));
  }
}
