class Thread {
  final String id;
  final String articleId;
  String authorId; //creator of the thread
  List<String> participantIds; //users who have commented on the thread
  String communityId;
  int upvotes;
  int downvotes;
  List<String> commentIds;

  Thread({
    required this.id,
    required this.articleId,
    required this.authorId,
    required this.participantIds,
    required this.communityId,
    required this.upvotes,
    required this.downvotes,
    required this.commentIds,
  });

  factory Thread.fromJson(Map<String, dynamic> json) {
    List<String> partecipantsIds = [];
    var participants = json['participantIds'];
    for (var participant in participants) {
      partecipantsIds.add(participant);
    }

    List<String> commentIds = [];
    var comments = json['commentIds'];
    for (var comment in comments) {
      commentIds.add(comment);
    }
    
    return Thread(
      id: json['id'],
      articleId: json['articleId'],
      authorId: json['authorId'],
      participantIds: partecipantsIds,
      communityId: json['communityId'],
      upvotes: json['upvotes'],
      downvotes: json['downvotes'],
      commentIds: commentIds,
    );
  }
}