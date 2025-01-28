import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Controller/ThemeController.dart';
import '../../Controller/UserControler.dart';
import '../splash/AppColors.dart';
import '../../model/UserModel.dart';

class HomeScreen extends StatelessWidget {
  final UserController userController = Get.put(UserController());
  final ThemeController themeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(120),
        child: Obx(() => AppBar(
              backgroundColor: themeController.isDarkMode.value
                  ? AppColors.darkBackground
                  : AppColors.primary,
              actions: [
                Obx(() => Switch(
                      value: themeController.isDarkMode.value,
                      onChanged: (value) {
                        themeController.toggleTheme();
                      },
                      activeColor: AppColors.lightText,
                      inactiveThumbColor: AppColors.lightText,
                    )),
              ],
              flexibleSpace: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome Back!',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppColors.lightBackground,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Explore our users and their details.',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: AppColors.darkText,
                      ),
                    ),
                  ],
                ),
              ),
            )),
      ),
      body: Obx(() {
        if (userController.isLoading.value && userController.users.isEmpty) {
          return Center(child: CircularProgressIndicator());
        }

        bool hasMoreUsers = userController.hasMoreUsers.value;

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: userController.users.length + (hasMoreUsers ? 1 : 0),
          itemBuilder: (context, index) {
            if (index == userController.users.length) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Obx(() => ElevatedButton(
                      onPressed: () {
                        if (!userController.isLoading.value) {
                          userController.loadMoreUsers();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: themeController.isDarkMode.value
                            ? AppColors.darkBackground
                            : AppColors.primary,
                        padding: EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: userController.isLoading.value
                          ? Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CircularProgressIndicator(
                                  color: AppColors.lightBackground,
                                  strokeWidth: 2,
                                ),
                                SizedBox(width: 12),
                                Text(
                                  'Loading...',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.lightBackground,
                                  ),
                                ),
                              ],
                            )
                          : Text(
                              'Load More',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: AppColors.lightBackground,
                              ),
                            ),
                    )),
              );
            }

            UserModel user = userController.users[index];
            return InkWell(
              onTap: () {
                Get.toNamed('/detail', arguments: user.id);
              },
              child: Obx(() => Card(
                    color: themeController.isDarkMode.value
                        ? AppColors.darkBackground
                        : AppColors.lightBackground,
                    elevation: 4,
                    shadowColor: Colors.black26,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(user.avatar),
                        radius: 30,
                      ),
                      title: Text(
                        '${user.firstName} ${user.lastName}',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: themeController.isDarkMode.value
                              ? AppColors.lightBackground
                              : AppColors.lightText,
                        ),
                      ),
                      subtitle: Text(
                        user.email,
                        style: TextStyle(
                          fontSize: 14,
                          color: themeController.isDarkMode.value
                              ? AppColors.darkText
                              : AppColors.lightText,
                        ),
                      ),
                    ),
                  )),
            );
          },
        );
      }),
    );
  }
}
