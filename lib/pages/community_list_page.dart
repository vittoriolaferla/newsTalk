import 'package:dima/managers/controllers/community_controller.dart';
import 'package:dima/model/community.dart';
import 'package:dima/widgets/community_list_item.dart';
import 'package:flutter/material.dart';
import 'package:dima/widgets/bottom_nav_bar.dart';

class CommunityListPage extends StatelessWidget {
  final List<Community> communities = [];

  @override
  Widget build(BuildContext context) {
    CommunityController communityController = CommunityController();
    return Container(
      padding: const EdgeInsets.all(0),
      child: FutureBuilder(
          future: Future.wait([communityController.fetchCommunities()]),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                return Scaffold(
                  body: Column(children: [
                    AppBar(
                      title: const Text('Community List'),
                      centerTitle: true,
                    ),
                    _listView(
                      context,
                      snapshot.data?[0] as List<Community>,
                    ),
                    //BottomNavBar(),
                  ]),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text(snapshot.error.toString()),
                );
              } else {
                return const Center(
                  child: Text('Error'),
                );
              }
            } else {
              return Center(
                  child: SizedBox(
                width: 80,
                height: 80,
                child: CircularProgressIndicator(
                  strokeWidth: 5,
                  valueColor: AlwaysStoppedAnimation<Color>(
                      Colors.black.withOpacity(0.5)),
                ),
              ));
            }
          }),
    );
  }

  Widget _listView(BuildContext context, List<Community> communities) {
    return ListView(
      padding: const EdgeInsets.all(5),
      children: [
        ListView.builder(
          itemCount: communities.length,
          physics: const ScrollPhysics(),
          padding: const EdgeInsets.all(0),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6.0)),
              child: WidgetCommunityItem(
                community: communities[index],),
            );
          },
        )
      ],
    );
  }
}
