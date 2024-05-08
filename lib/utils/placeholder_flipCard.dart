import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Widget buildArticlePlaceholder(BuildContext context) {
  return Shimmer.fromColors(
    baseColor: Colors.white!,
    highlightColor: Colors.grey[100]!,
    child: Card(
      child: Column(
        children: [
          Container(
            // Adjust dimensions based on your actual UI
            color: Colors.grey,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(
                  3,
                  (index) => Padding(
                        padding: const EdgeInsets.only(bottom: 5.0),
                        child: Container(
                          height: 10,
                          width: double.infinity,
                          color: Colors.grey,
                        ),
                      )),
            ),
          ),
        ],
      ),
    ),
  );
}
