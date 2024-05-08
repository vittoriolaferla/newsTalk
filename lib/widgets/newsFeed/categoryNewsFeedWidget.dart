import 'package:dima/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:provider/provider.dart';
import '../../managers/article_notifier.dart';
import '../../managers/article_provider.dart';
import '../../model/article.dart';
import '../../utils/placeholder_flipCard.dart'; // Assuming this is your placeholder widget
import '../articleCard/articleCardHome.dart';

class CategoryNewsFeedWidget extends StatefulWidget {
  final ScrollController controller;
  final String category;

  CategoryNewsFeedWidget({
    Key? key,
    required this.controller,
    required this.category,
  }) : super(key: key);

  @override
  _CategoryNewsFeedWidgetState createState() => _CategoryNewsFeedWidgetState();
}

class _CategoryNewsFeedWidgetState extends State<CategoryNewsFeedWidget> {
  List<Article> _articles = [];
  bool _isFetchingInitialData = false;
  bool _isLoadingMore = false; // Flag to track initial data fetch state

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Ensure the fetch operation is only done once if needed.
    if (Provider.of<ArticleProvider>(context)
        .getArticlesForCategory(widget.category)
        .isEmpty) {
      _fetchInitialArticles();
    }
  }

  void _fetchInitialArticles() async {
    _isFetchingInitialData = true;
    await Provider.of<ArticleProvider>(context, listen: false)
        .fetchArticlesForCategory(widget.category);
    if (mounted) {
      setState(() {
        _articles.addAll(Provider.of<ArticleProvider>(context, listen: false)
            .getArticlesForCategory(widget.category));
        _isFetchingInitialData = false;
      });
    }
  }

  void _loadMoreArticles() async {
    if (!_isLoadingMore) {
      setState(() => _isLoadingMore = true);
      await Provider.of<ArticleProvider>(context, listen: false)
          .loadMoreArticles(widget.category);
      if (mounted) {
        setState(() {
          _articles = [];
          _articles.addAll(Provider.of<ArticleProvider>(context, listen: false)
              .getArticlesForCategory(widget.category));
          _isLoadingMore = false; // Reset loading state
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_articles.isEmpty) {
      _articles.addAll(Provider.of<ArticleProvider>(context, listen: false)
          .getArticlesForCategory(widget.category));
    }
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        // Determine item count, including the loading indicator if needed
        int itemCount = _isFetchingInitialData ? 5 : _articles.length + 1;
        return RefreshIndicator(
            onRefresh: () async {
              // Clear articles and fetch new ones for the current category
              await Provider.of<ArticleProvider>(context, listen: false)
                  .clearAndFetchArticlesForCategory(widget.category);
              // Update local state to reflect changes
            },
            child: Swiper(
              itemCount: itemCount,
              onIndexChanged: (int index) {
                if (index == _articles.length && !_isLoadingMore) {
                  _loadMoreArticles();
                }
              },
              itemBuilder: (context, index) {
                if (_isFetchingInitialData) {
                  // Show placeholder cards during initial fetch
                  return buildArticlePlaceholder(context);
                } else if (index >= _articles.length) {
                  // Show a loading indicator as the last item
                  return buildArticlePlaceholder(context);
                } else {
                  // Show actual article cards
                  return ArticleCardHome(
                    article: _articles[index],
                    height: constraints.maxHeight,
                    width: constraints.maxWidth,
                  );
                }
              },
              itemWidth: constraints.maxWidth * 0.9,
              itemHeight: constraints.maxHeight,
              viewportFraction: 0.85,
              scale: 0.9,
              loop: false,
            ));
      },
    );
  }
}
