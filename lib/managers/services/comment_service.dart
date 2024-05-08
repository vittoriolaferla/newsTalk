import 'package:dima/model/comment.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CommentService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<Comment>> getComments() async {
    var result = await _db.collection('comments').get();
    List<Comment> comments =
        result.docs.map((doc) => Comment.fromJson(doc.data())).toList();
    return comments;
  }

  Future<void> addComment(Map<String, dynamic> commentData) async {
    await _db.collection('comments').add(commentData);
  }

  Future<void> updateComment(
      String commentId, Map<String, dynamic> newData) async {
    await _db.collection('comments').doc(commentId).update(newData);
  }

  Future<void> deleteComment(String commentId) async {
    await _db.collection('comments').doc(commentId).delete();
  }

  //get comment by id
  Future<Comment> getCommentById(String commentId) async {
    var result =
        await _db.collection('comments').where('id', isEqualTo: commentId).get();
    Comment comment = Comment.fromJson(result.docs.first.data());
    return comment;
  }

  //get comments by thread id
  Future<List<Comment>> getCommentsByThreadId(String threadId) async {
    var result = await _db
        .collection('comments')
        .where('threadId', isEqualTo: threadId)
        .get();
    List<Comment> comments =
        result.docs.map((doc) => Comment.fromJson(doc.data())).toList();
    return comments;
  }

  //get comments by user id
  Future<List<Comment>> getCommentsByUserId(String userId) async {
    var result = await _db
        .collection('comments')
        .where('userId', isEqualTo: userId)
        .get();
    List<Comment> comments =
        result.docs.map((doc) => Comment.fromJson(doc.data())).toList();
    return comments;
  }
}
