import 'package:dima/model/community.dart';
import 'package:dima/managers/services/community_service.dart';
import 'package:flutter/cupertino.dart';

class CommunityController with ChangeNotifier{
  final CommunityService _communityService = CommunityService();
  List<Community> communities = [];

  Future<List<Community>> fetchCommunities() async {
    try {
      communities = await _communityService.getCommunities();
      return communities;
    } catch (error) {
      // Handle errors, e.g., show an error message to the Community
      print('Error fetching Communitys: $error');
      rethrow;
    }
  }
  
  Future<void> addCommunity(Map<String, dynamic> communityData) async {
    try {
      await _communityService.addCommunity(communityData);
    } catch (error) {
      // Handle errors, e.g., show an error message to the Community
      print('Error adding Community: $error');
    }
  }

  Future<void> updateCommunity(
      String communityId, Map<String, dynamic> newData) async {
    try {
      await _communityService.updateCommunity(communityId, newData);
    } catch (error) {
      // Handle errors, e.g., show an error message to the Community
      print('Error updating Community: $error');
    }
  }

  Future<void> deleteCommunity(String communityId) async {
    try {
      await _communityService.deleteCommunity(communityId);
    } catch (error) {
      // Handle errors, e.g., show an error message to the Community
      print('Error deleting Community: $error');
    }
  }

  Future<Community> getCommunityById(String communityId) async {
    try {
      return await _communityService.getCommunityById(communityId);
    } catch (error) {
      // Handle errors, e.g., show an error message to the Community
      print('Error getting Community: $error');
      rethrow;
    }
  }

  Future<List<Community>> getCommunitysByThreadId(String threadId) async {
    try {
      return await _communityService.getCommunityByThreadId(threadId);
    } catch (error) {
      // Handle errors, e.g., show an error message to the Community
      print('Error getting Communitys: $error');
      rethrow;
    }
  }

  Future<List<Community>> getCommunitiesByUserId(String userId) async {
    try {
      return await _communityService.getCommunitiesByUserId(userId);
    } catch (error) {
      // Handle errors, e.g., show an error message to the Community
      print('Error getting Communitys: $error');
      rethrow;
    }
  }
}