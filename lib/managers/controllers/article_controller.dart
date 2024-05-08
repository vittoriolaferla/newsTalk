import 'package:dima/model/article.dart';
import 'package:dima/managers/services/article_service.dart';
import 'package:flutter/cupertino.dart';

class ArticleController with ChangeNotifier{
  final ArticleService _articleService = ArticleService();
  List<Article> articles = [];

  Future<List<Article>> fetchArticles() async {
    try {
      articles = await _articleService.getArticles();
      return articles;
    } catch (error) {
      // Handle errors, e.g., show an error message to the Article
      print('Error fetching Articles: $error');
      rethrow;
    }
  }

  Future<void> deleteArticle(String articleId) async {
    try {
      await _articleService.deleteArticle(articleId);
    } catch (error) {
      // Handle errors, e.g., show an error message to the Article
      print('Error deleting Article: $error');
    }
  }

  Future<Article> getArticleById(String articleId) async {
    try {
      return await _articleService.getArticleById(articleId);
    } catch (error) {
      // Handle errors, e.g., show an error message to the Article
      print('Error getting Article: $error');
      rethrow;
    }
  }

  Future<List<Article>> getArticlesByCategory(String category) async {
    try {
      return await _articleService.getArticlesByCategory(category);
    } catch (error) {
      // Handle errors, e.g., show an error message to the Article
      print('Error getting Articles by category: $error');
      rethrow;
    }
  }

  Future<List<Article>> getArticlesBySource(String source) async {
    try {
      return await _articleService.getArticlesBySource(source);
    } catch (error) {
      // Handle errors, e.g., show an error message to the Article
      print('Error getting Articles by source: $error');
      rethrow;
    }
  }

  Future<List<Article>> getArticlesByAuthor(String author) async {
    try {
      return await _articleService.getArticlesByAuthor(author);
    } catch (error) {
      // Handle errors, e.g., show an error message to the Article
      print('Error getting Articles by author: $error');
      rethrow;
    }
  }

  Future<List<Article>> getArticlesByLanguage(String language) async {
    try {
      return await _articleService.getArticlesByLanguage(language);
    } catch (error) {
      // Handle errors, e.g., show an error message to the Article
      print('Error getting Articles by language: $error');
      rethrow;
    }
  }
}