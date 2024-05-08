import 'dart:math';

import 'package:dima/model/thread.dart';
class Community {
  final String id;
  final String name;
  final String category;
  String bio;
  String backgroundImagePath;
  String profileImagePath;
  List<Thread> recentThreads;
  List<String> memberIds;

  Community({
    required this.id,
    required this.name,
    required this.category,
    required this.bio,
    required this.backgroundImagePath,
    required this.profileImagePath,
    required this.recentThreads,
    required this.memberIds,
  });

  factory Community.fromJson(Map<String, dynamic> json) {
    List<Thread> recentThreads = [];
    var threads = json['recentThreads'];
    for (var thread in threads) {
      recentThreads.add(Thread.fromJson(thread));
    }

    List<String> memberIds = [];
    var members = json['memberIds'];
    for (var member in members) {
      memberIds.add(member);
    }

    return Community(
      id: json['id'],
      name: json['name'],
      category: json['category'],
      bio: json['bio'],
      backgroundImagePath: json['backgroundImagePath'],
      profileImagePath: json['profileImagePath'],
      recentThreads: recentThreads,
      memberIds: memberIds,
    );
  }

  String generateRandomId({int length = 8}) {
    const characters = 'abcdefghijklmnopqrstuvwxyz0123456789';
    Random random = Random();
    String randomId = '';

    for (int i = 0; i < length; i++) {
      randomId += characters[random.nextInt(characters.length)];
    }
    return randomId;
  }
}
