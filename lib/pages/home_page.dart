import 'package:flutter/material.dart';
import 'package:kalcer/widget/bottom_navbar.dart';
import 'package:kalcer/widget/card_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Map<String, String>> posts = List.generate(20, (index) {
    return {
      'title': 'Understanding Flutter Layout #$index',
      'author': 'User$index',
      'content':
          '''Ini hal yang menurut gue paling menarik. Warga Depok itu sadar banget kota mereka sering jadi bahan bercandaan. Meme tentang Depok udah viral dari dulu. Tapi mereka ngaak marah, malah sering ikut nimbrung. Mereka tahu kok, Depok itu absurd. Tapi justru dari kekacauan itulah muncul semacam rasa memiliki. Kayak, "Iya sih berantakan, tapi ini tempat gue. Dan gue pun mulai ngerti. Di balik angkot ngawur, jalanan semrawut, dan macet tak berkesudahan... Depok itu punya jiwa, Punya kehangatan. Ada sesuatu yang nggak bisa dijelasin tapi bikin betah''',
      'info1': '${index + 1} hours ago',
      'info2': '${index * 2 + 5} replies',
      'tag': '#flutter',
    };
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBF5EB), // ← warna background halaman
      appBar: AppBar(
        title: const Text("Forum Feed"),
        backgroundColor: const Color(0xFFFBF5EB), // ← warna AppBar
        elevation: 0, // ← opsional biar lebih flat
        foregroundColor: Colors.black,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: SafeArea(
          child: CustomBottomNavBar(
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index) {
          final post = posts[index];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: CardItem(post: post),
          );
        },
      ),
    );
  }
}
