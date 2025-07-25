import 'package:flutter/material.dart';
import 'package:kalcer/widget/card_item.dart';

class HomePage extends StatefulWidget {
  final List<Map<String, dynamic>>? posts;
  final Function(List<Map<String, dynamic>>)? onPostsChanged;

  const HomePage({super.key, this.posts, this.onPostsChanged});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> filteredPosts = [];
  List<Map<String, dynamic>> posts = [];

  @override
  void initState() {
    super.initState();
    posts = widget.posts ?? _getDefaultPosts();
    filteredPosts = posts;
  }

  @override
  void didUpdateWidget(HomePage oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Update posts when widget is updated from parent
    if (widget.posts != null && widget.posts != oldWidget.posts) {
      setState(() {
        posts = widget.posts!;
        _filterPosts(_searchController.text);
      });
    }
  }

  List<Map<String, dynamic>> _getDefaultPosts() {
    return [
      {
        'title': 'Depok = Gotham City',
        'author': 'Syarna Savitri',
        'subtitle': 'Cultural Storyteller, Jakarta Utara',
        'timestamp': '24 Juli 2025 | 17.16 PM',
        'tag1': '#Depok',
        'tag2': '#CultureShock',
        'content':
            'Ini hal yang menurut gue paling menarik. Warga Depok itu sadar banget kota mereka sering jadi bahan bercandaan. Meme tentang Depok udah viral dari dulu. Tapi mereka nggak marah, malah sering ikut nimbrung. Mereka tahu kok, Depok itu absurd. Tapi justru dari kekacauan itulah muncul semacam rasa memiliki.',
        'upvotes': 42,
        'downvotes': 5,
        'comments': 18,
      },
    ];
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void addPost(Map<String, dynamic> newPost) {
    setState(() {
      posts.insert(0, newPost);
      _filterPosts(_searchController.text);
    });

    // Notify parent about the change
    if (widget.onPostsChanged != null) {
      widget.onPostsChanged!(posts);
    }
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
