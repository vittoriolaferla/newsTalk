import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../config.dart';
import '../model/article.dart';

//class made to be a singleton, it stores the last document saw per each category
class ArticleRepository {
  static final ArticleRepository _instance = ArticleRepository._internal();

  // Private constructor
  ArticleRepository._internal();

  // Map to hold the last document for each category
  Map<String, DocumentSnapshot> _lastDocuments = {};

  // Public factory
  factory ArticleRepository() {
    return _instance;
  }

  // Fetches the first batch or subsequent batches of articles
  Future<List<Article>> fetchArticles(String category, int? batchSize) async {
    Query query = FirebaseFirestore.instance
        .collection('articles')
        .where('category', isEqualTo: category.toLowerCase())
        .orderBy(FieldPath.documentId);

    // Apply the batch size if provided
    if (batchSize != null) {
      query = query.limit(batchSize);
    }

    // Use the last document specific to the category for pagination
    DocumentSnapshot? lastDocument = _lastDocuments[category];
    if (lastDocument != null) {
      query = query.startAfterDocument(lastDocument);
    }

    QuerySnapshot querySnapshot = await query.get();
    List<Article> articles = querySnapshot.docs
        .map((doc) => Article.fromMap(doc.data() as Map<String, dynamic>))
        .toList();

    // Update the last document for the category
    if (querySnapshot.docs.isNotEmpty) {
      _lastDocuments[category] = querySnapshot.docs.last;
    }

    return articles;
  }

  void resetPagination({String? category}) {
    if (category != null) {
      _lastDocuments.remove(category);
    } else {
      _lastDocuments.clear();
    }
  }
}

Future<List<Article>> retrieveArticlesForCategory(String category) async {
  // Start with a base query
  Query query = FirebaseFirestore.instance
      .collection('articles')
      .where('category', isEqualTo: category.toLowerCase());
  QuerySnapshot querySnapshot = await query.get();

  List<Article> articles = querySnapshot.docs
      .map((doc) => Article.fromMap(doc.data() as Map<String, dynamic>))
      .toList();

  return articles;
}

Future<List<List<Article>>> retrieveArticles() async {
  List<List<Article>> allCategoryArticles = [];
  for (String category in CATEGORIES) {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('articles')
        .where('category', isEqualTo: category.toLowerCase())
        .get();

    List<Article> articles = querySnapshot.docs
        .map((doc) => Article.fromMap(doc.data() as Map<String, dynamic>))
        .toList();
    allCategoryArticles.add(articles);
  }
  return allCategoryArticles;
}

Future<List<Article>> fetchArticlesInBatch(List<String> docIds) async {
  List<Article> articles = [];
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Process in chunks of 10 to adhere to Firestore's limitations
  const chunkSize = 10;
  for (var i = 0; i < docIds.length; i += chunkSize) {
    // Calculate the range for the current chunk
    int end = (i + chunkSize < docIds.length) ? i + chunkSize : docIds.length;
    List<String> chunk = docIds.sublist(i, end);

    // Perform a batched fetch from Firestore
    var snapshot = await firestore
        .collection('articles')
        .where(FieldPath.documentId, whereIn: chunk)
        .get();

    // Convert each document to an Article and add to the list
    for (var doc in snapshot.docs) {
      Article? article = Article.fromMap(doc.data() as Map<String, dynamic>);
      articles.add(article);
    }
  }

  return articles;
}
