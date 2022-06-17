import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone_flutter/presentation/controllers/auth_controller.dart';
import 'package:instagram_clone_flutter/presentation/screens/add_post_screen.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  final List<Widget> _pages = const [
    Text('Home'),
    Text('Search'),
    Text("Profile"),
  ];
  final AuthController authController = Get.find();

  void setIndex(int index) {
    if (index == 2) {
      Get.toNamed(AddPostScreen.routeName);
    } else {
      setState(() {
        currentIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: setIndex,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        unselectedIconTheme: const IconThemeData(
          color: Colors.black,
        ),
        selectedIconTheme: const IconThemeData(
          color: Colors.black,
        ),
        items: [
          const BottomNavigationBarItem(
            label: "",
            icon: Icon(
              Icons.home_filled,
            ),
          ),
          const BottomNavigationBarItem(
            label: "",
            icon: Icon(
              Icons.search,
            ),
          ),
          const BottomNavigationBarItem(
            label: "",
            icon: Icon(
              Icons.add_a_photo_outlined,
            ),
          ),
          BottomNavigationBarItem(
            label: "",
            icon: Obx(
              () => ClipRRect(
                borderRadius: BorderRadius.circular(40),
                child: authController.user != null
                    ? CachedNetworkImage(
                        fit: BoxFit.cover,
                        width: 40,
                        height: 40,
                        imageUrl: authController.user!.photoURL!,
                      )
                    : const Icon(
                        Icons.person_outline,
                      ),
              ),
            ),
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: _pages[currentIndex],
    );
  }
}
