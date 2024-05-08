import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/widgets.dart';

import '../../model/article.dart';
import '../../pages/article_page.dart';
 // Adjust this import based on your project structure

class ArticleCardHome extends StatefulWidget {
  final Article article;
  final double? height;
  final double? width;

  const ArticleCardHome({
    Key? key,
    required this.article,
    this.height,
    this.width,
  }) : super(key: key);

  @override
  _ArticleCardHomeState createState() => _ArticleCardHomeState();
}

class _ArticleCardHomeState extends State<ArticleCardHome> {
  @override
  Widget build(BuildContext context) {
    final article = widget.article;
    return Stack(children: [
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            height: widget.height,
            color: Colors.white,
            child: Column(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ArticleScreen(article: article),
                        ),
                      );
                    },
                    child: Stack(
                      children: [
                        Image.network(
                          article.urlToImage,
                          fit: BoxFit.cover,
                          alignment: Alignment.center,
                          width: double.infinity,
                          height: double.infinity,
                          loadingBuilder: (BuildContext context, Widget child,
                              ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null)
                              return child; // Image has loaded
                            return Container(
                              color:
                                  Colors.grey, // Gray background while loading
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            );
                          },
                          errorBuilder: (BuildContext context, Object exception,
                              StackTrace? stackTrace) {
                            return Container(
                              color: Colors.grey, // Gray background on error
                              child: Center(
                                child: Icon(Icons.error),
                              ),
                            );
                          },
                        ),
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.center,
                              colors: [
                                Colors.black.withOpacity(
                                    0.8), // More opaque black for a smoother transition
                                Colors
                                    .transparent, // Gradually becomes transparent
                              ],
                              stops: [
                                0.1,
                                0.9
                              ], // Adjust stops for smoother transition
                            ),
                          ),
                        ),
                        // Text container for title
                        Center(
                          child: Container(
                            height: widget.height! * 0.75,
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                padding: EdgeInsets.all(
                                    10), // Padding to ensure text is not at the very edge
                                child: Text(
                                  article.title,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines:
                                  4, // Allows text to expand up to three lines
                                  overflow: TextOverflow
                                      .ellipsis,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                              top: 15, // Adjust the positioning as needed
                              right: 15, // Adjust the positioning as needed
                              child: Container(
                                padding: EdgeInsets.all(
                                    2), // Space between the CircleAvatar and its border, adjust as needed
                                decoration: BoxDecoration(
                                  color: Colors
                                      .white, // Background color behind the CircleAvatar
                                  shape: BoxShape
                                      .circle, // Ensures the container is also circular

                                ),
                                child: CircleAvatar(
                                  radius:
                                      25, // Adjust the size of the CircleAvatar as needed
                                  backgroundImage: NetworkImage(
                                    article.urlToAuthor,
                                  ),
                                ),
                              ),
                            ),
                      ],
                    ),
                  ),
                ),
                if (article.contentParagraphs != null &&
                    article.contentParagraphs!.isNotEmpty)
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    height: widget.height! * 0.35,
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.only(left: 5, right: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              article.description,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                              maxLines:
                                  3, // Allows text to expand up to three lines
                              overflow: TextOverflow
                                  .ellipsis, // Adds '...' if text exceeds the space available in three lines
                            ),
                            SizedBox(height: 8),
                            RichText(
                              text: TextSpan(
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16), // Default text style
                                children: [
                                  TextSpan(
                                      text: article.contentParagraphs!.first
                                          .paragraphContent),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    ]);
  }
}
