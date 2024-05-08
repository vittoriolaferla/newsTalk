import 'package:flutter/material.dart';
import '../managers/article_provider.dart';
import '../model/article.dart';
import '../utils/placeholder_flipCard.dart';
import 'articleCard/articleCardDiscovery.dart';

class FeedDiscoveryWidget extends StatelessWidget {
  const FeedDiscoveryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints)
    {
      return FutureBuilder<List<List<Article>>>(
        future: retrieveArticles(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.8,
              ),
              //itemCount: 6,
              itemBuilder: (context, index) {
                return buildArticlePlaceholder(context);
              },
            );
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No articles found'));
          }
          List<Article> articles = snapshot.data!.expand((x) => x).toList();
          return GridView.builder(
            scrollDirection: Axis.horizontal, // Enables horizontal scrolling
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // Single column for horizontal layout
              childAspectRatio: 1.3, // Adjust aspect ratio if needed
              mainAxisSpacing: 5, // Spacing between items in the main axis
            ),
            itemCount: articles.length,
            itemBuilder: (context, index) {
              Article article = articles[index];
              // Calculate the height to be half of the grid height assuming the viewport provides the height context
              //double width = MediaQuery.of(context).size.width* 0.4;
              return ArticleCardDiscovery(
                article: article,
                height: constraints.maxHeight*0.5,
               // width: constraints.maxWidth*0.55,
              );
            },
          );
        },
      );
    });
  }
}
