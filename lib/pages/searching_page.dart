import 'package:algolia/algolia.dart';
import 'package:dima/widgets/searchBar/searchBarSearchingWidget.dart';
import 'package:flutter/material.dart';
import '../config.dart';
import '../model/article.dart';
import '../widgets/articleCard/articleCardDiscovery.dart';
import '../managers/article_provider.dart';

class SearchingPage extends StatefulWidget {
  const SearchingPage({Key? key}) : super(key: key);

  @override
  SearchingPageState createState() => SearchingPageState();
}

class SearchingPageState extends State<SearchingPage> {
  late Algolia algolia;
  List<Article> searchResults = [];
  bool isSearching = false;

  void onSearch(String query, String category) async {
    setState(() {
      isSearching = true; // Show a loading indicator or similar
    });
    // Assuming ArticleProvider().searchFirestore returns a Future<List<Article>>
    if (query != '') {
      await fetchArticles(query, category);
    }
    setState(() {
      // searchResults = results;
      isSearching = false;
    });
  }

  @override
  void initState() {
    algolia = const Algolia.init(
        applicationId: AlgoliaApplicationID, apiKey: AlgoliaAPIKey);
  }

  Future<void> fetchArticles(String searchQuery, String category) async {
    searchResults = [];
    String filterString = category != "All" ? 'category:"$category"' : "";
    AlgoliaQuery query =
        algolia.instance.index('article_index').query(searchQuery);
    // Apply the category filter if needed
    if (filterString.isNotEmpty) {
      query = query.filters(filterString);
    }

    final snap = await query.getObjects();
    final results = snap.hits;
    // Extract document IDs (objectIDs) from Algolia results
    List<String> docIds = results.map((result) => result.objectID).toList();

    // Fetch articles in batches to avoid exceeding Firestore limits
    List<Article> fetchedArticles = await fetchArticlesInBatch(docIds);

    // Assuming you have a way to handle or display these articles
    searchResults.addAll(fetchedArticles);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints)
    { return Column(
        children: [
          Container(
          height: constraints.maxHeight*0.1,
          child:
          SearchBarSearching(onSearch: onSearch),
          ),
          Expanded(
            // This should prevent the RenderFlex error for the list
            child: isSearching
                ? Center(child: CircularProgressIndicator())
                : searchResults.isEmpty
                    ? Center(child: Text('No results found.'))
                    :   GridView.builder(
            scrollDirection: Axis.horizontal, // Enables horizontal scrolling
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // Single column for horizontal layout
              childAspectRatio: 1.3, // Adjust aspect ratio if needed
              mainAxisSpacing: 5, // Spacing between items in the main axis
            ),
            itemCount: searchResults.length,
            itemBuilder: (context, index) {
              Article article = searchResults[index];
              // Calculate the height to be half of the grid height assuming the viewport provides the height context
              //double width = MediaQuery.of(context).size.width* 0.4;
              return ArticleCardDiscovery(
                article: article,
              height: constraints.maxHeight*0.45
               // width: constraints.maxWidth*0.55,
              );
            },
          ))

        ],
      );
    }
      )
    );
  }
}
