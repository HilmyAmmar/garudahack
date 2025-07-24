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
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, String>> filteredPosts = [];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Map<String, String>> posts = List.generate(4, (index) {
    return {
      'title': 'Understanding Flutter Layout #$index',
      'author': 'User$index',
      'content':
          '''Ini hal yang menurut gue paling menarik. Warga Depok itu sadar banget kota mereka sering jadi bahan bercandaan. Meme tentang Depok udah viral dari dulu. Tapi mereka ngaak marah, malah sering ikut nimbrung. Mereka tahu kok, Depok itu absurd. Tapi justru dari kekacauan itulah muncul semacam rasa memiliki. Kayak, "Iya sih berantakan, tapi ini tempat gue. Dan gue pun mulai ngerti. Di balik angkot ngawur, jalanan semrawut, dan macet tak berkesudahan... Depok itu punya jiwa, Punya kehangatan. Ada sesuatu yang nggak bisa dijelasin tapi bikin betah''',
      'info1': '${index + 1} hours ago',
      'info2': '${index * 2 + 5} replies',
      'tag': 'Review',
    };
  });

  @override
  void initState() {
    super.initState();
    filteredPosts = posts; // Initialize with all posts
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterPosts(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredPosts = posts;
      } else {
        filteredPosts =
            posts.where((post) {
              return post['title']!.toLowerCase().contains(
                    query.toLowerCase(),
                  ) ||
                  post['author']!.toLowerCase().contains(query.toLowerCase()) ||
                  post['content']!.toLowerCase().contains(query.toLowerCase());
            }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBF5EB),
      body: SafeArea(
        child: Column(
          children: [
            // Header Section with Timeline title and Search
            Container(
              padding: const EdgeInsets.all(20.0),
              decoration: const BoxDecoration(color: Color(0xFFFBF5EB)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Timeline Title
                  Row(
                    children: [
                      const Icon(
                        Icons.timeline,
                        color: Color(0xff721908),
                        size: 28,
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        'Timeline',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff721908),
                        ),
                      ),
                      const Spacer(),
                      // Profile/Notification icons
                      IconButton(
                        onPressed: () {
                          // Handle notifications
                        },
                        icon: const Icon(
                          Icons.notifications_outlined,
                          color: Color(0xff721908),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Search TextField
                  TextField(
                    controller: _searchController,
                    onChanged: _filterPosts,
                    decoration: InputDecoration(
                      hintText: 'Cari cerita, pengguna, atau topik...',
                      hintStyle: const TextStyle(color: Colors.grey),
                      prefixIcon: const Icon(
                        Icons.search,
                        color: Color(0xff721908),
                      ),
                      suffixIcon:
                          _searchController.text.isNotEmpty
                              ? IconButton(
                                onPressed: () {
                                  _searchController.clear();
                                  _filterPosts('');
                                },
                                icon: const Icon(
                                  Icons.clear,
                                  color: Colors.grey,
                                ),
                              )
                              : null,
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: const BorderSide(
                          color: Colors.grey,
                          width: 0.5,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: const BorderSide(
                          color: Color(0xff721908),
                          width: 2,
                        ),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Posts List
            Expanded(
              child:
                  filteredPosts.isEmpty && _searchController.text.isNotEmpty
                      ? _buildEmptyState()
                      : ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: filteredPosts.length,
                        itemBuilder: (context, index) {
                          final post = filteredPosts[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: CardItem(post: post),
                          );
                        },
                      ),
            ),
          ],
        ),
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
      // Floating Action Button for Create Post
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Handle create new post
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Buat cerita baru'),
              backgroundColor: Color(0xff721908),
            ),
          );
        },
        backgroundColor: const Color(0xff721908),
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search_off, size: 64, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            'Tidak ada hasil ditemukan',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Coba kata kunci yang berbeda',
            style: TextStyle(fontSize: 14, color: Colors.grey[500]),
          ),
        ],
      ),
    );
  }
}
