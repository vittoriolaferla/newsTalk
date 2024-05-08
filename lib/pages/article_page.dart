import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../model/article.dart';
import '../utils/custom_tag.dart';
import '../utils/image_container.dart';

class ArticleScreen extends StatelessWidget {
  final Article article;
  const ArticleScreen({Key? key, required this.article}) : super(key: key);

  static const routeName = '/article';
  @override
  Widget build(BuildContext context) {
    return ImageContainer(
      width: double.infinity,
      imageUrl: article.urlToImage,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        extendBodyBehindAppBar: true,
        body: ListView(
          children: [
            _NewsHeadline(article: article),
            _NewsBody(article: article)
          ],
        ),
      ),
    );
  }
}

class _NewsBody extends StatelessWidget {
  const _NewsBody({
    Key? key,
    required this.article,
  }) : super(key: key);

  final Article article;

  @override
  Widget build(BuildContext context) {
    String author;
    if (article.author.length > 25) {
      author = article.author.substring(0, article.author.length - 3) + '...';
    } else {
      author =
          article.author.isNotEmpty ? article.author : "Autore Sconosciuto";
    }
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return Container(
        padding: const EdgeInsets.all(20.0),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CustomTag(
                  backgroundColor: Colors.black,
                  children: [
                    CircleAvatar(
                      radius: 15,
                      backgroundImage: NetworkImage(article.urlToAuthor),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      article.author.isNotEmpty ? author : "Autore Sconosciuto",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Colors.white,
                          ),
                    ),
                  ],
                ),
                Spacer(), // Questo spinge il contenuto successivo verso la destra
                Container(
                  alignment: Alignment.centerRight,
                  child: Row(
                    mainAxisSize: MainAxisSize
                        .min, // Riduce al minimo la dimensione della Row
                    children: [
                      CustomTag(
                        backgroundColor: Colors.grey.shade200,
                        children: [
                          const Icon(Icons.timer, color: Colors.grey),
                          Text("5'"),
                        ],
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () => launchURL(article.url),
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.transparent),
                          elevation: MaterialStateProperty.all(0),
                          padding: MaterialStateProperty.all(EdgeInsets.zero),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: CustomTag(
                          backgroundColor: Colors.grey.shade200,
                          children: [
                            Flexible(child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle, // Ensures the container is circular
                                border: Border.all(
                                 color: Colors.white, // Color of the border
                                  width: 1.0, // Thickness of the border
                                ),
                              ),
                              child: Icon(Icons.language, color: Colors.black54),
                            ),
                            ),
                          ],
                        ),


                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            if (article.contentParagraphs != null &&
                article.contentParagraphs!.isNotEmpty)
              ...article.contentParagraphs!
                  .map((p) => Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text:
                                    '${p.paragraphTitle}\n', // Title with a newline
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              TextSpan(
                                text: p.paragraphContent, // Content
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                      fontWeight: FontWeight.normal,
                                      height: 1.5,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ))
                  .toList(),
            const SizedBox(height: 20),
            GridView.builder(
                shrinkWrap: true,
                itemCount: 2,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.25,
                ),
                itemBuilder: (context, index) {
                  return ImageContainer(
                    width: MediaQuery.of(context).size.width * 0.42,
                    imageUrl: article.urlToImage,
                    margin: const EdgeInsets.only(right: 5.0, bottom: 5.0),
                  );
                })
          ],
        ),
      );
    });
  }
}

class _NewsHeadline extends StatelessWidget {
  const _NewsHeadline({
    Key? key,
    required this.article,
  }) : super(key: key);

  final Article article;

  @override
  Widget build(BuildContext context) {
    const Map<String, String> CATEGORIES = {
      'general': 'General',
      'sports': 'Sports',
      'entertainment': 'Entertainment',
      'health': 'Health',
      'business': 'Business',
      'technology': 'Technology'
    };

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.15,
          ),
          CustomTag(
            backgroundColor: Colors.grey.withAlpha(150),
            children: [
              Text(
                CATEGORIES[article.category]!,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Colors.white,
                    ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            article.title,
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  height: 1.25,
                ),
          ),
          const SizedBox(height: 10),
          Text(
            article.description,
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: Colors.white),
          ),
        ],
      ),
    );
  }
}

void launchURL(String url) async {
  final websiteUri = Uri.parse(url);
  await launchUrl(websiteUri, mode: LaunchMode.platformDefault);
}
