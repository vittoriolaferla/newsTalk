import 'dart:async'; // Import the async library for Timer
import 'package:dima/config.dart';
import 'package:dima/pages/searching_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

class SearchBarSearching extends StatefulWidget {
  final Function(String, String) onSearch;
  final List<String> categories = [
    'All',
    'General',
    'Sports',
    'Entertainment',
    'Health',
    "Business",
    "Technology"
  ];

  SearchBarSearching({super.key, required this.onSearch});

  @override
  _SearchBarSearchingState createState() => _SearchBarSearchingState();
}

class _SearchBarSearchingState extends State<SearchBarSearching> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  String selectedCategory = "All"; // Initialize with "All"

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: _controller,
        focusNode: _focusNode,
        onSubmitted: (value) => widget.onSearch(
            value, selectedCategory), // Include category in search
        decoration: InputDecoration(
          hintText: 'Search...',
          fillColor: Colors.white,
          filled: true,
          prefixIcon: const Icon(Icons.search),
          suffixIcon: Row(
            mainAxisSize: MainAxisSize
                .min, // Added to prevent expanding beyond the TextField
            children: [
              Text(selectedCategory,
                  style: TextStyle(
                      color: Colors.black)), // Display selected category
              PopupMenuButton<String>(
                icon: const Icon(Icons.arrow_drop_down),
                onSelected: (value) {
                  setState(() {
                    selectedCategory = value;
                  });
                  // Optionally trigger a search immediately upon selecting a category
                },
                itemBuilder: (BuildContext context) {
                  return widget.categories.map((String choice) {
                    return PopupMenuItem<String>(
                      value: choice,
                      child: Text(choice),
                    );
                  }).toList();
                },
              ),
            ],
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
