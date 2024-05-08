
import 'package:flutter/material.dart';

import '../widgets/bottom_nav_bar.dart';
import '../widgets/feedDiscoveryWidget.dart';
import '../widgets/searchBar/searchBarDiscoveryWidget.dart';
import 'news_feed_page.dart';

class DiscoveryPage extends StatelessWidget {
  const DiscoveryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Discovery'),
          centerTitle: true,
        ),
        body: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
          return Scaffold(
            body: Container(
              color: Colors.black12,
              child: Column(
                children: [
                  Container(
                    height: constraints.maxHeight * 0.1,
                    child: SearchBarDiscovery(),
                  ),
                  Expanded(
                    child: FeedDiscoveryWidget(),
                  ),
                ],
              ),
            ),
          );
        }));
  }


}
