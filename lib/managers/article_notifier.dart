import 'package:flutter/material.dart';
import '../managers/article_provider.dart'; // Adjust the import based on your project structure
import '../model/article.dart';

class ArticleProvider with ChangeNotifier {
  Map<String, List<Article>> _articlesByCategory = {};

  List<Article> getArticlesForCategory(String category) =>
      _articlesByCategory[category] ?? [];

  Future<void> fetchArticlesForCategory(String category) async {
    if (!_articlesByCategory.containsKey(category) ||
        _articlesByCategory[category]!.isEmpty) {
      // Simulate a network fetch
      var articles = await ArticleRepository().fetchArticles(category, 10);
      _articlesByCategory[category] = articles;
      notifyListeners(); // Notify widgets listening to the provider
    }
  }

  Future<void> loadMoreArticles(String category) async {
    // Ensure the category is already present; initialize if not (safeguard)
    _articlesByCategory.putIfAbsent(category, () => []);

    // Fetch more articles for the given category.
    // The ArticleRepository should internally manage how to fetch the next set of articles.
    var newArticles = await ArticleRepository().fetchArticles(category, 10);

    // Check if new articles are fetched and add them to the current list.
    if (newArticles.isNotEmpty) {
      _articlesByCategory[category]!.addAll(
          newArticles); // Safely add new articles since the list is initialized
      notifyListeners(); // Notify all listening widgets to rebuild with the updated articles.
    }
  }

  Future<void> clearAndFetchArticlesForCategory(String category) async {
    // Clear existing articles for the category
    _articlesByCategory[category] = [];

    // Fetch new articles. Make sure this method is asynchronous and returns a Future.
    await fetchArticlesForCategory(
        category); // Assuming this already returns a Future<void>

    notifyListeners(); // Notify listeners about the change.
  }
}
