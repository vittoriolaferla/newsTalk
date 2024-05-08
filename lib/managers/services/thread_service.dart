import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dima/model/thread.dart';

class ThreadService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<Thread>> getThreads() async {
    var result = await _db.collection('threads').get();
    List<Thread> threads =
        result.docs.map((doc) => Thread.fromJson(doc.data())).toList();
    return threads;
  }

  Future<void> addThread(Map<String, dynamic> threadData) async {
    await _db.collection('threads').add(threadData);
  }

  Future<void> updateThread(
      String threadId, Map<String, dynamic> newData) async {
    await _db.collection('threads').doc(threadId).update(newData);
  }

  Future<void> deleteThread(String threadId) async {
    await _db.collection('threads').doc(threadId).delete();
  }

  //get thread by id
  Future<Thread> getThreadById(String threadId) async {
    var result =
        await _db.collection('threads').where('id', isEqualTo: threadId).get();
    Thread thread = Thread.fromJson(result.docs.first.data());
    return thread;
  }

  //get threads by community id
  Future<List<Thread>> getThreadsByCommunityId(String communityId) async {
    var result = await _db
        .collection('communities')
        .where('threadIds', arrayContains: communityId)
        .get();
    List<Thread> threads =
        result.docs.map((doc) => Thread.fromJson(doc.data())).toList();
    return threads;
  }

  //get threads by user id as author
  Future<List<Thread>> getThreadsByAuthorId(String authorId) async {
    var result = await _db
        .collection('threads')
        .where('authorId', isEqualTo: authorId)
        .get();
    List<Thread> threads =
        result.docs.map((doc) => Thread.fromJson(doc.data())).toList();
    return threads;
  }

  //get threads by user id as participant
  Future<List<Thread>> getThreadsByParticipantId(String participantId) async {
    var result = await _db
        .collection('threads')
        .where('participantIds', arrayContains: participantId)
        .get();
    List<Thread> threads =
        result.docs.map((doc) => Thread.fromJson(doc.data())).toList();
    return threads;
  }

  //get thread by comment id
  Future<Thread> getThreadByCommentId(String commentId) async {
    var result = await _db
        .collection('threads')
        .where('commentIds', arrayContains: commentId)
        .get();
    Thread thread = Thread.fromJson(result.docs.first.data());
    return thread;
  }
}
