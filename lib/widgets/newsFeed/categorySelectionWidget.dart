import 'package:flutter/material.dart';

class CategorySelectionWidget extends StatelessWidget {
  final List<String> categories;
  final String selectedCategory;
  final Function(String, double) onCategorySelected;
  final double heightNewsFeed;

  const CategorySelectionWidget(
      {Key? key,
      required this.categories,
      required this.selectedCategory,
      required this.onCategorySelected,
      required this.heightNewsFeed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: categories.length,
      itemBuilder: (context, index) {
        bool isSelected =
            categories[index].toLowerCase() == selectedCategory.toLowerCase();
        return GestureDetector(
          onTap: () => onCategorySelected(categories[index], heightNewsFeed),
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 20),
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            decoration: isSelected
                ? BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(20),
                  )
                : BoxDecoration(
                    // For non-selected categories, keep it plain
                    ),
            child: Text(
              categories[index],
              style: TextStyle(
                // Change text color based on selection for better contrast
                color: isSelected ? Colors.black : Colors.grey,
              ),
            ),
          ),
        );
      },
    );
  }
}
