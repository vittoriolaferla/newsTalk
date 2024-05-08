import 'package:dima/pages/auth_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../widgets/newsFeed/categoryNewsFeedWidget.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/newsFeed/categorySelectionWidget.dart';

class NewsFeedPage extends StatefulWidget {
  const NewsFeedPage({Key? key}) : super(key: key);

  @override
  NewsFeedPageState createState() => NewsFeedPageState();
}

class NewsFeedPageState extends State<NewsFeedPage> {
  final ScrollController _scrollController = ScrollController();

  String _selectedCategory =
      'General'; // Ensure this matches one of the categories exactly
  List<String> categories = [
    'General',
    'Sports',
    'Entertainment',
    'Health',
    "Business",
    "Technology"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News Feed'),
        centerTitle: true,
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Column(
            children: [
              SizedBox(
                height: constraints.maxHeight * 0.1,
                child: CategorySelectionWidget(
                  categories: categories,
                  selectedCategory: _selectedCategory,
                  onCategorySelected: _onCategorySelected,
                  heightNewsFeed: constraints.maxHeight,
                ),
              ),
              Expanded(
                child: Container(
                  color: Colors.black12,
                  padding: EdgeInsets.only(top: 5, bottom: 5),
                  child: CategoryNewsFeedWidget(
                    key: ValueKey(
                        _selectedCategory), // Use the selected category as a key
                    controller: _scrollController,
                    category: _selectedCategory,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _onCategorySelected(String category, double height) {
    setState(() {
      _selectedCategory = category;
    });
  }
}
