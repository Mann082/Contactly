import 'package:flutter/material.dart';

class detailTile extends StatelessWidget {
  final String title;
  final String detail;
  const detailTile({super.key, required this.title, required this.detail});

  @override
  Widget build(BuildContext context) {
    return Card(
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
              Text(
                title,
                style: TextStyle(color: Colors.black),
              ),
              Text(
                detail,
                style: const TextStyle(color: Colors.black, fontSize: 35),
              )
            ],
          ),
        ));
  }
}
