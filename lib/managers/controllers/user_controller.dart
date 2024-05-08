import 'package:dima/model/user.dart';
import 'package:dima/managers/services/user_service.dart';
import 'package:flutter/cupertino.dart';

class UserController with ChangeNotifier{
  final UserService _userService = UserService();
  List<User> users = [];

  Future<List<User>> fetchUsers() async {
    try {
      users = await _userService.getUsers();
      return users;
    } catch (error) {
      // Handle errors, e.g., show an error message to the User
      print('Error fetching Users: $error');
      rethrow;
    }
  }
  
  Future<void> addUser(Map<String, dynamic> userData) async {
    try {
      await _userService.addUser(userData);
    } catch (error) {
      // Handle errors, e.g., show an error message to the User
      print('Error adding User: $error');
    }
  }

  Future<void> updateUser(
      String userId, Map<String, dynamic> newData) async {
    try {
      await _userService.updateUser(userId, newData);
    } catch (error) {
      // Handle errors, e.g., show an error message to the User
      print('Error updating User: $error');
    }
  }

  Future<void> deleteUser(String userId) async {
    try {
      await _userService.deleteUser(userId);
    } catch (error) {
      // Handle errors, e.g., show an error message to the User
      print('Error deleting User: $error');
    }
  }

  Future<User> getUserById(String userId) async {
    try {
      return await _userService.getUserById(userId);
    } catch (error) {
      // Handle errors, e.g., show an error message to the User
      print('Error getting User: $error');
      rethrow;
    }
  }

  Future<List<User>> getUsersByThreadId(String threadId) async {
    try {
      return await _userService.getUsersByThreadId(threadId);
    } catch (error) {
      // Handle errors, e.g., show an error message to the User
      print('Error getting Users: $error');
      rethrow;
    }
  }

  Future<List<User>> getUsersByCommunityId(String communityId) async {
    try {
      return await _userService.getUsersByCommunityId(communityId);
    } catch (error) {
      // Handle errors, e.g., show an error message to the User
      print('Error getting Users: $error');
      rethrow;
    }
  }
}