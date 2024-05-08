import 'package:dima/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<User>> getUsers() async {
    var result = await _db.collection('users').get();
    List<User> customers =
        result.docs.map((doc) => User.fromJson(doc.data())).toList();
    return customers;
  }

  Future<void> addUser(Map<String, dynamic> customerData) async {
    await _db.collection('users').add(customerData);
  }

  Future<void> updateUser(String userId, Map<String, dynamic> newData) async {
    await _db.collection('users').doc(userId).update(newData);
  }

  Future<void> deleteUser(String userId) async {
    await _db.collection('users').doc(userId).delete();
  }

  //get user by id
  Future<User> getUserById(String userId) async {
    var result =
        await _db.collection('users').where('id', isEqualTo: userId).get();
    User customer = User.fromJson(result.docs.first.data());
    return customer;
  }

  //get users by thread id
  Future<List<User>> getUsersByThreadId(String threadId) async {
    var result = await _db
        .collection('users')
        .where('threadIds', arrayContains: threadId)
        .get();
    List<User> customers =
        result.docs.map((doc) => User.fromJson(doc.data())).toList();
    return customers;
  }

  //get users by community id
  Future<List<User>> getUsersByCommunityId(String communityId) async {
    var result = await _db
        .collection('users')
        //search in array communityIds if there is a match
        .where('communityIds', arrayContains: communityId)
        .get();
    List<User> customers =
        result.docs.map((doc) => User.fromJson(doc.data())).toList();
    return customers;
  }
}
