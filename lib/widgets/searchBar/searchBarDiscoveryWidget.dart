import 'dart:async'; // Import the async library for Timer
import 'package:dima/pages/searching_page.dart';
import 'package:flutter/material.dart';

class SearchBarDiscovery extends StatelessWidget {
  const SearchBarDiscovery({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          // Navigate to the search page on tap
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => SearchingPage()));
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: const [
              Icon(Icons.search),
              SizedBox(width: 10),
              Text('Search...', style: TextStyle(color: Colors.grey)),
            ],
          ),
        ),
      ),
    );
  }
}
