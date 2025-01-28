

import 'dart:convert';

import 'package:get/state_manager.dart';
import 'package:perfection_sample/model/UserModel.dart';
import 'package:http/http.dart' as http;

class UserController extends GetxController {
  var users = <UserModel>[].obs;
  var isLoading = false.obs;
  var hasMoreUsers = true.obs;
  int currentPage = 1;

  @override
  void onInit() {
    super.onInit();
    loadMoreUsers();
  }

  Future<void> loadMoreUsers() async {
    if (isLoading.value || !hasMoreUsers.value) return;

    isLoading.value = true;
    final response = await http
        .get(Uri.parse('https://reqres.in/api/users?page=$currentPage'));

    if (response.statusCode == 200) {
      var data = json.decode(response.body)['data'];
      var userList =
          (data as List).map((json) => UserModel.fromJson(json)).toList();
      users.addAll(userList);

      if (userList.length < 6) {
        hasMoreUsers.value = false;
      } else {
        currentPage++;
      }
    }

    isLoading.value = false;
  }

  Future<UserModel> fetchUserDetails(int id) async {
    final response =
        await http.get(Uri.parse('https://reqres.in/api/users/$id'));
    if (response.statusCode == 200) {
      var data = json.decode(response.body)['data'];
      return UserModel.fromJson(data);
    } else {
      throw Exception('Failed to load user details');
    }
  }
}
