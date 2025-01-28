import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:perfection_sample/Controller/UserControler.dart';
import 'package:perfection_sample/model/UserModel.dart';

class DetailScreen extends StatelessWidget {
  final UserController userController = Get.find();

   DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final int userId = Get.arguments;

    return Scaffold(
      appBar: AppBar(title: const Text("User Details")),
      body: FutureBuilder<UserModel>(
        future: userController.fetchUserDetails(userId),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final user = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                CircleAvatar(
                    radius: 50, backgroundImage: NetworkImage(user.avatar)),
                const SizedBox(height: 16),
                Text('${user.firstName} ${user.lastName}',
                    style:
                        const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Text(user.email, style: const TextStyle(fontSize: 16)),
              ],
            ),
          );
        },
      ),
    );
  }
}
