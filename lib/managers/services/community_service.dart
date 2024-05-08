import 'package:dima/model/community.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CommunityService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<Community>> getCommunities() async {
    var result = await _db.collection('communities').get();
    List<Community> communities =
        result.docs.map((doc) => Community.fromJson(doc.data())).toList();
    return communities;
  }

  Future<void> addCommunity(Map<String, dynamic> commentData) async {
    await _db.collection('communities').add(commentData);
  }

  Future<void> updateCommunity(
      String communityId, Map<String, dynamic> newData) async {
    await _db.collection('communities').doc(communityId).update(newData);
  }

  Future<void> deleteCommunity(String communityId) async {
    await _db.collection('communities').doc(communityId).delete();
  }

  //get community by id
  Future<Community> getCommunityById(String communityId) async {
    var result = await _db
        .collection('communities')
        .where('id', isEqualTo: communityId)
        .get();
    Community community = Community.fromJson(result.docs.first.data());
    return community;
  }

  //get community by thread id
  Future<List<Community>> getCommunityByThreadId(String threadId) async {
    var result = await _db
        .collection('communities')
        .where('threadIds', arrayContains: threadId)
        .get();
    List<Community> communities =
        result.docs.map((doc) => Community.fromJson(doc.data())).toList();
    return communities;
  }

  //get communities by user id
  Future<List<Community>> getCommunitiesByUserId(String userId) async {
    var result = await _db
        .collection('communities')
        .where('memberIds', arrayContains: userId)
        .get();
    List<Community> communities =
        result.docs.map((doc) => Community.fromJson(doc.data())).toList();
    return communities;
  }
}
