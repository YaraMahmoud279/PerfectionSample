import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Controller/ThemeController.dart';
import '../../Controller/UserControler.dart';
import '../../Shared/AppColors.dart';
import '../../model/UserModel.dart';

class DetailScreen extends StatelessWidget {
  final UserController userController = Get.find();
  final ThemeController themeController = Get.find();

  @override
  Widget build(BuildContext context) {
    final int userId = Get.arguments;

    return FutureBuilder<UserModel>(
      future: userController.fetchUserDetails(userId),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        UserModel userDetails = snapshot.data!;
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(120),
            child: AppBar(
              backgroundColor: themeController.isDarkMode.value
                  ? AppColors.darkBackground
                  : AppColors.primary,
              flexibleSpace: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 25.0),
                      child: Text(
                        'Details',
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: AppColors.darkText,
                        ),
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Information about ${userDetails.firstName}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: AppColors.darkText.withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: [
                Center(
                  child: GestureDetector(
                    onTap: () {
                      Get.to(() => FullScreenAvatarScreen(avatarUrl: userDetails.avatar));
                    },
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        AnimatedContainer(
                          duration: Duration(seconds: 1),
                          curve: Curves.easeInOut,
                          height: 120,
                          width: 120,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: themeController.isDarkMode.value
                                  ? [AppColors.darkBackground, Colors.grey[700]!]
                                  : [AppColors.primary, Colors.blueAccent],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 8,
                                offset: Offset(0, 4),
                              ),
                            ],
                            image: DecorationImage(
                              image: NetworkImage(userDetails.avatar),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                            child: Icon(
                              Icons.circle,
                              color: Colors.white,
                              size: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Card(
                  color: themeController.isDarkMode.value
                      ? AppColors.darkBackground
                      : AppColors.lightBackground,
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  margin: EdgeInsets.only(top: 16),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ExpansionTile(
                          title: Text(
                            '${userDetails.firstName} ${userDetails.lastName}',
                            style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: themeController.isDarkMode.value
                                  ? AppColors.darkText
                                  : AppColors.lightText,
                            ),
                          ),
                          children: [
                            ListTile(
                              title: Text(
                                'Email: ${userDetails.email}',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: themeController.isDarkMode.value
                                      ? AppColors.darkText.withOpacity(0.7)
                                      : AppColors.lightText.withOpacity(0.7),
                                ),
                              ),
                            ),
                            ListTile(
                              title: Text(
                                'ID: ${userDetails.id}',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: themeController.isDarkMode.value
                                      ? AppColors.darkText.withOpacity(0.7)
                                      : AppColors.lightText.withOpacity(0.7),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: themeController.isDarkMode.value
                        ? AppColors.darkBackground
                        : AppColors.primary,
                    padding: EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 5,
                  ),
                  child: Text(
                    'Contact User',
                    style: TextStyle(fontSize: 18, color: AppColors.darkText),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class FullScreenAvatarScreen extends StatelessWidget {
  final String avatarUrl;

  FullScreenAvatarScreen({required this.avatarUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: InteractiveViewer(
          child: Image.network(avatarUrl),
        ),
      ),
    );
  }
}
