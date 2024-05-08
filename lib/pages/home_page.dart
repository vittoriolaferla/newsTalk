import 'package:dima/pages/community_home_page.dart';
import 'package:dima/pages/profile_page.dart';
import 'package:flutter/material.dart';

import '../widgets/bottom_nav_bar.dart';
import 'discovery_page.dart';
import 'map_page.dart';
import 'news_feed_page.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home';

  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    NewsFeedPage(), // Assume NewsFeedPage is now a regular widget
    DiscoveryPage(),
    MapPage(),
    //ProfilePage(), // Replace with your actual discovery page
    CommunityHomePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavBar(
        index: _selectedIndex,
        onItemSelected: _onItemTapped,
      ),
    );
  }
}
