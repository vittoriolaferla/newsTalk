class User {
  //login
  final String id;
  final String name;
  final String email;
  final String password;
  //profile
  final String username;
  final String profileImagePath;
  final String bio;
  //activities
  final List<String> communityIds;
  final List<String> threadIds;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.username,
    required this.profileImagePath,
    required this.bio,
    required this.communityIds,
    required this.threadIds,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    List<String> communityIds = [];
    var communities = json['communityIds'];
    for (var community in communities) {
      communityIds.add(community);
    }

    List<String> threadIds = [];
    var threads = json['threadIds'];
    for (var thread in threads) {
      threadIds.add(thread);
    }

    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      password: json['password'],
      username: json['username'],
      profileImagePath: json['profileImagePath'],
      bio: json['bio'],
      communityIds: communityIds,
      threadIds: threadIds,
    );
  }
}
