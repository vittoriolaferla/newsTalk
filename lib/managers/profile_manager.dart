import 'package:cloud_firestore/cloud_firestore.dart';

Future<Map<String, dynamic>> fetchUserData(String userId) async {
  try {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('UID', isEqualTo: userId)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      DocumentSnapshot userSnapshot = querySnapshot.docs.first;
      Map<String, dynamic> userData =
          userSnapshot.data() as Map<String, dynamic>;
      return userData;
    } else {
      // If user does not exists
      return {};
    }
  } catch (error) {
    print('Error fetching user data: $error');
    return {};
  }
}
