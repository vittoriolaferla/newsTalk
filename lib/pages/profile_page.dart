import 'package:dima/managers/profile_manager.dart';
import 'package:dima/pages/auth_page.dart';
import 'package:dima/pages/login_or_register_page.dart';
import 'package:dima/widgets/threadBarProfile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String userId = ''; // user UID
  Map<String, dynamic> userData = {};

  Future<void> _fetchUserData() async {
    try {
      // Attendi il completamento della funzione fetchUserData
      Map<String, dynamic>? fetchedData = await fetchUserData(userId);
      // Assegna i dati restituiti alla variabile userData
      if (fetchedData != null) {
        setState(() {
          userData = fetchedData;
        });
      } else {
        // Gestisci il caso in cui i dati non siano stati recuperati correttamente
        print('Failed to fetch user data.');
      }
    } catch (error) {
      // Gestisci eventuali errori durante il recupero dei dati
      print('Error fetching user data: $error');
    }
  }

  @override
  void initState() {
    super.initState();
    // Retrieve used UID
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        setState(() {
          userId = user.uid;
        });
      } else {
        // If user is not logged in, go back to login page
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => AuthPage()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Retrieve user data
    _fetchUserData();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('${userData['name'] ?? 'No data'}',
            style: TextStyle(color: Colors.black)),
        elevation: 0,
        leading: Icon(Icons.menu),
        actions: [
          IconButton(
              onPressed: () => signUserOut(context),
              icon: Icon(Icons.logout_rounded))
        ],
      ),
      backgroundColor: Colors.white,
      body: Column(children: [
        // prfile picture
        Container(
            height: 120,
            width: 120,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey[200],
            )),

        // username

        Padding(
          padding: EdgeInsets.all(20.0),
          child: Text(
            '${userData['username'] ?? 'No data'}',
            style: TextStyle(color: Colors.black, fontSize: 20),
          ),
        ),

        // following, followers and threads

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Following
            Expanded(
                child: Container(
              alignment: Alignment.centerRight,
              child: Column(
                children: [
                  Text('${userData['following'].length ?? 'No data'}',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 24)),
                  Text('Following',
                      style: TextStyle(
                          color: Color.fromARGB(200, 0, 0, 0), fontSize: 15)),
                ],
              ),
            )),

            // Followers
            Expanded(
                child: Container(
              alignment: Alignment.center,
              child: Column(
                children: [
                  Text('${userData['followers'].length ?? 'No data'}',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 24)),
                  Text('Followers',
                      style: TextStyle(
                          color: Color.fromARGB(200, 0, 0, 0), fontSize: 15)),
                ],
              ),
            )),

            // threads
            Expanded(
                child: Container(
              alignment: Alignment.centerLeft,
              child: Column(
                children: [
                  Text('${userData['threads'].length ?? 'No data'}',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 24)),
                  Text('Threads',
                      style: TextStyle(
                          color: Color.fromARGB(200, 0, 0, 0), fontSize: 15)),
                ],
              ),
            )),
          ],
        ),

        // Bio
        const SizedBox(height: 15),
        Text(
          '${userData['bio'] ?? 'No data'}',
          style:
              TextStyle(color: Color.fromARGB(255, 63, 63, 63), fontSize: 17),
          textAlign: TextAlign.center,
        ),

        // edit profile
        const SizedBox(height: 15),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                padding: EdgeInsets.all(5),
                child:
                    Text('Edit profile', style: TextStyle(color: Colors.black)),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(5)))
          ],
        ),

        const SizedBox(height: 15),

        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          decoration: BoxDecoration(
              color: Colors.grey[200], borderRadius: BorderRadius.circular(10)),
          child: const Row(
            children: [
              Icon(Icons.circle, color: Colors.black, size: 12.0),
              SizedBox(width: 8.0),
              Text(
                'Thread 1',
                style: TextStyle(color: Colors.black, fontSize: 16.0),
              ),
            ],
          ),
        ),

        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          decoration: BoxDecoration(
              color: Colors.grey[200], borderRadius: BorderRadius.circular(10)),
          child: const Row(
            children: [
              Icon(Icons.circle, color: Colors.black, size: 12.0),
              SizedBox(width: 8.0),
              Text(
                'Thread 2',
                style: TextStyle(color: Colors.black, fontSize: 16.0),
              ),
            ],
          ),
        ),

        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          decoration: BoxDecoration(
              color: Colors.grey[200], borderRadius: BorderRadius.circular(10)),
          child: const Row(
            children: [
              Icon(Icons.circle, color: Colors.black, size: 12.0),
              SizedBox(width: 8.0),
              Text(
                'Thread 3',
                style: TextStyle(color: Colors.black, fontSize: 16.0),
              ),
            ],
          ),
        ),
      ]),
    );
  }

  void signUserOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    // Navigate to AuthPage after sign out
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => AuthPage()),
    );
  }
}
