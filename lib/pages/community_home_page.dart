import 'package:dima/model/thread.dart';
import 'package:dima/widgets/community_waiting_approval.dart';
import 'package:flutter/material.dart';
import 'package:dima/model/community.dart';

class CommunityHomePage extends StatefulWidget {
  //final Community community;
  //final List<Thread> threads;

  const CommunityHomePage({
    Key? key,
    //required this.community,
    //required this.threads,
  }) : super(key: key);

  @override
  _CommunityHomePageState createState() => _CommunityHomePageState();
}

class _CommunityHomePageState extends State<CommunityHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Community"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            height: 200, // Adjust as needed
            decoration: BoxDecoration(
              image: DecorationImage(
                //image: NetworkImage(widget.community.backgroundImagePath),
                image: AssetImage('assets/images/community_background.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 50, // Adjust as needed
                    //backgroundImage: NetworkImage(widget.community.profileImagePath),
                    backgroundImage: AssetImage('assets/images/community_profile.jpg'),
                  ),
                  SizedBox(height: 30),
                  Text(
                    //widget.community.name,
                    'Community Name',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    //widget.community.bio,
                    'Community Bio',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Handle request access button click
              showDialog(
                context: context,
                builder: (context) => WaitingForApproval(),
              );
            },
            child: Text('Request Access'),
          ),
          const Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Recent Threads',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          // List of recent activities
          const ListTile(
            title: Text('Activity 1'),
            subtitle: Text('Description of activity 1'),
          ),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Most Popular Threads',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          // List of recent activities
          const ListTile(
            title: Text('Activity 2'),
            subtitle: Text('Description of activity 2'),
          ),
        ],
      ),
    );
  }
}
