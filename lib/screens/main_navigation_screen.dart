// Main Navigation Screen
import 'package:flutter/material.dart';
import 'package:kalcer/pages/home_page.dart';
import 'package:kalcer/pages/my_story.dart';
import 'package:kalcer/pages/profil.dart';
import 'package:kalcer/pages/sekilas_budaya.dart';
import 'package:kalcer/widget/bottom_navbar.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const SekilasBudayaPage(), // SekilasBudayaPage di index 1 (Pencarian AI)
    const MyStoryPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _pages),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
