
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../model/article.dart';
import '../../utils/utilsFunctionsMapPage.dart';

class ArticleCardMap extends StatelessWidget {
  final Article article;
  final double? height;
  final double? width;
  final Function(double, double) onLocationTap;

  const ArticleCardMap({
    Key? key,
    required this.article,
    required this.onLocationTap,
    this.height,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell
      (
      onTap: () => showCustomDialogWithArticleInfo(article, context),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            height: height,
            color: Colors.white,
            child: Stack(
              children: [
                Positioned.fill(
                  child: Image.network(
                    article.urlToImage,
                    fit: BoxFit.cover,
                    alignment: Alignment.center,
                    loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Container(
                        color: Colors.grey,
                        child: Center(child: CircularProgressIndicator()),
                      );
                    },
                    errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                      return Container(
                        color: Colors.grey,
                        child: Center(child: Icon(Icons.error)),
                      );
                    },
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.center,
                      colors: [Colors.black.withOpacity(0.8), Colors.transparent],
                      stops: [0.1, 0.9],
                    ),
                  ),
                ),
                Positioned(
                  left: 10,
                  top: 10,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: IconButton(
                      icon: const Icon(FontAwesomeIcons.mapLocationDot, color: Colors.black,),
                      color: Colors.white,
                      onPressed: () => onLocationTap(
                          article.coordinates.latitude,
                          article.coordinates.longitude),
                    ),
                  ),
                ),
                Positioned(
                  top: 10, // Adjust the positioning as needed
                  right: 10, // Adjust the positioning as needed
                  child: Container(
                    padding: EdgeInsets.all(
                        2), // Space between the CircleAvatar and its border, adjust as needed
                    decoration: BoxDecoration(
                      color: Colors
                          .white, // Background color behind the CircleAvatar
                      shape: BoxShape
                          .circle, // Ensures the container is also circular
                      border: Border.all(
                        color: Colors.black, // Color of the border
                        width: 2.0, // Thickness of the border
                      ),
                    ),
                    child: CircleAvatar(
                      radius:
                      15, // Adjust the size of the CircleAvatar as needed
                      backgroundImage: NetworkImage(
                        article.urlToAuthor,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      article.title,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),);
  }
}
