import 'package:flutter/material.dart';

class MyStoryPage extends StatefulWidget {
  const MyStoryPage({super.key});

  @override
  State<MyStoryPage> createState() => _MyStoryPageState();
}

class _MyStoryPageState extends State<MyStoryPage>
    with TickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, dynamic>> _myPosts = [
    {
      'title': 'Pengalaman Pertama di Yogyakarta',
      'subtitle': 'Perjalanan budaya yang tak terlupakan',
      'timestamp': '22 Juli 2025 | 14.30 PM',
      'tag1': '#Storytime',
      'tag2': '#CultureShock',
      'content':
          'Yogyakarta benar-benar kota yang istimewa. Dari Keraton yang megah hingga Malioboro yang ramai, setiap sudut kota ini menyimpan cerita. Yang paling berkesan adalah saat pertama kali melihat Tugu Yogya di malam hari...',
      'upvotes': 28,
      'downvotes': 2,
      'comments': 12,
      'status': 'published',
      'views': 156,
    },
    {
      'title': 'Makanan Khas Bandung yang Wajib Dicoba',
      'subtitle': 'Kuliner legendaris dari Kota Kembang',
      'timestamp': '20 Juli 2025 | 09.15 AM',
      'tag1': '#Review',
      'tag2': '#DoAndDont',
      'content':
          'Bandung memang surga kuliner! Dari batagor yang gurih, siomay yang segar, hingga pisang molen yang manis. Tapi yang paling istimewa menurut saya adalah nasi timbel dengan lalapan segar...',
      'upvotes': 42,
      'downvotes': 1,
      'comments': 18,
      'status': 'published',
      'views': 203,
    },
    {
      'title': 'Tradisi Unik di Desa Toraja',
      'subtitle': 'Menyaksikan upacara Rambu Solo',
      'timestamp': '18 Juli 2025 | 16.45 PM',
      'tag1': '#CultureShock',
      'tag2': '#AskLocal',
      'content':
          'Berkunjung ke Tana Toraja memberikan pengalaman spiritual yang luar biasa. Upacara Rambu Solo yang saya saksikan mengajarkan bagaimana masyarakat Toraja menghormati leluhur mereka...',
      'upvotes': 35,
      'downvotes': 0,
      'comments': 8,
      'status': 'draft',
      'views': 89,
    },
  ];

  final List<Map<String, dynamic>> _savedPosts = [
    {
      'title': 'Rahasia Tersembunyi di Bali Utara',
      'author': 'Made Wirawan',
      'subtitle': 'Local Guide, Singaraja',
      'timestamp': '23 Juli 2025 | 11.20 AM',
      'tag1': '#AskLocal',
      'tag2': '#Review',
      'content':
          'Bali Utara punya pesona yang berbeda dari Bali Selatan. Air terjun tersembunyi, pantai hitam yang eksotis, dan desa-desa tradisional yang masih asli...',
      'upvotes': 67,
      'downvotes': 3,
      'comments': 24,
    },
  ];

  List<Map<String, dynamic>> filteredMyPosts = [];
  List<Map<String, dynamic>> filteredSavedPosts = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    filteredMyPosts = _myPosts;
    filteredSavedPosts = _savedPosts;
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _filterPosts(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredMyPosts = _myPosts;
        filteredSavedPosts = _savedPosts;
      } else {
        filteredMyPosts =
            _myPosts
                .where(
                  (post) =>
                      post['title']!.toLowerCase().contains(
                        query.toLowerCase(),
                      ) ||
                      post['content']!.toLowerCase().contains(
                        query.toLowerCase(),
                      ),
                )
                .toList();

        filteredSavedPosts =
            _savedPosts
                .where(
                  (post) =>
                      post['title']!.toLowerCase().contains(
                        query.toLowerCase(),
                      ) ||
                      post['content']!.toLowerCase().contains(
                        query.toLowerCase(),
                      ) ||
                      post['author']!.toLowerCase().contains(
                        query.toLowerCase(),
                      ),
                )
                .toList();
      }
    });
  }

  void _clearSearch() {
    _searchController.clear();
    _filterPosts('');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBF5EB),
      body: SafeArea(
        child: Column(
          children: [
            // Header Section
            Container(
              padding: const EdgeInsets.all(20.0),
              decoration: const BoxDecoration(color: Color(0xFFFBF5EB)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title and Stats Row
                  Row(
                    children: [
                      const Icon(
                        Icons.auto_stories,
                        color: Color(0xff721908),
                        size: 28,
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        'Cerita Saya',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff721908),
                        ),
                      ),
                      const Spacer(),
                      // Stats Summary
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xff721908).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.visibility,
                              size: 16,
                              color: Color(0xff721908),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '${_myPosts.fold<int>(0, (sum, post) => sum + (post['views'] as int))}',
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff721908),
                              ),
                            ),
                          ],
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
                      hintText: 'Cari cerita saya...',
                      hintStyle: const TextStyle(color: Colors.grey),
                      prefixIcon: const Icon(
                        Icons.search,
                        color: Color(0xff721908),
                      ),
                      suffixIcon:
                          _searchController.text.isNotEmpty
                              ? IconButton(
                                onPressed: _clearSearch,
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

                  const SizedBox(height: 16),

                  // Tab Bar
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(
                        color: Colors.grey.withOpacity(0.3),
                        width: 0.5,
                      ),
                    ),
                    child: TabBar(
                      controller: _tabController,
                      indicator: BoxDecoration(
                        color: const Color(0xff721908),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      labelColor: Colors.white,
                      unselectedLabelColor: const Color(0xff721908),
                      labelStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                      unselectedLabelStyle: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                      tabs: [
                        Tab(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.edit, size: 16),
                              const SizedBox(width: 8),
                              Text('Postingan (${_myPosts.length})'),
                            ],
                          ),
                        ),
                        Tab(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.bookmark, size: 16),
                              const SizedBox(width: 8),
                              Text('Tersimpan (${_savedPosts.length})'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Tab Content
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  // My Posts Tab
                  _buildMyPostsTab(),
                  // Saved Posts Tab
                  _buildSavedPostsTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMyPostsTab() {
    if (filteredMyPosts.isEmpty && _searchController.text.isNotEmpty) {
      return _buildEmptyState(
        'Tidak ada postingan ditemukan',
        'Coba kata kunci yang berbeda',
      );
    }

    if (filteredMyPosts.isEmpty) {
      return _buildEmptyState(
        'Belum ada cerita',
        'Mulai bagikan pengalaman budaya Anda dengan menekan tombol + di bawah',
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: filteredMyPosts.length,
      itemBuilder: (context, index) {
        final post = filteredMyPosts[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: _buildMyPostCard(post),
        );
      },
    );
  }

  Widget _buildSavedPostsTab() {
    if (filteredSavedPosts.isEmpty && _searchController.text.isNotEmpty) {
      return _buildEmptyState(
        'Tidak ada cerita tersimpan ditemukan',
        'Coba kata kunci yang berbeda',
      );
    }

    if (filteredSavedPosts.isEmpty) {
      return _buildEmptyState(
        'Belum ada cerita tersimpan',
        'Simpan cerita menarik dari pengguna lain dengan menekan ikon bookmark',
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: filteredSavedPosts.length,
      itemBuilder: (context, index) {
        final post = filteredSavedPosts[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: _buildSavedPostCard(post),
        );
      },
    );
  }

  Widget _buildMyPostCard(Map<String, dynamic> post) {
    final isDraft = post['status'] == 'draft';

    return Container(
      decoration: BoxDecoration(
        color: isDraft ? const Color(0x20721908) : const Color(0x40721908),
        borderRadius: BorderRadius.circular(12),
        border:
            isDraft
                ? Border.all(
                  color: const Color(0xff721908).withOpacity(0.3),
                  style: BorderStyle.solid,
                  width: 1,
                )
                : null,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with status and menu
            Row(
              children: [
                // Status Badge
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: isDraft ? Colors.orange : Colors.green,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        isDraft ? Icons.edit : Icons.check_circle,
                        size: 12,
                        color: Colors.white,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        isDraft ? 'Draft' : 'Published',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                // More Menu
                PopupMenuButton<String>(
                  icon: const Icon(Icons.more_vert, color: Color(0xff721908)),
                  onSelected: (value) => _handlePostAction(value, post),
                  itemBuilder:
                      (context) => [
                        const PopupMenuItem(
                          value: 'edit',
                          child: Row(
                            children: [
                              Icon(
                                Icons.edit,
                                size: 16,
                                color: Color(0xff721908),
                              ),
                              SizedBox(width: 8),
                              Text('Edit'),
                            ],
                          ),
                        ),
                        PopupMenuItem(
                          value: isDraft ? 'publish' : 'unpublish',
                          child: Row(
                            children: [
                              Icon(
                                isDraft ? Icons.publish : Icons.unpublished,
                                size: 16,
                                color: Color(0xff721908),
                              ),
                              const SizedBox(width: 8),
                              Text(isDraft ? 'Publish' : 'Unpublish'),
                            ],
                          ),
                        ),
                        const PopupMenuItem(
                          value: 'delete',
                          child: Row(
                            children: [
                              Icon(Icons.delete, size: 16, color: Colors.red),
                              SizedBox(width: 8),
                              Text(
                                'Delete',
                                style: TextStyle(color: Colors.red),
                              ),
                            ],
                          ),
                        ),
                      ],
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Tags
            Row(
              children: [
                if (post['tag1'] != null) _buildTag(post['tag1']!),
                if (post['tag1'] != null && post['tag2'] != null)
                  const SizedBox(width: 8),
                if (post['tag2'] != null) _buildTag(post['tag2']!),
              ],
            ),

            const SizedBox(height: 12),

            // Title
            Text(
              post['title']!,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF721908),
              ),
            ),

            const SizedBox(height: 8),

            // Content Preview
            Text(
              post['content']!,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF721908),
                height: 1.4,
              ),
            ),

            const SizedBox(height: 12),

            // Timestamp
            Text(
              post['timestamp']!,
              style: TextStyle(
                fontSize: 12,
                color: const Color(0xFF721908).withOpacity(0.7),
              ),
            ),

            const SizedBox(height: 12),

            // Stats Row
            Row(
              children: [
                _buildStatChip(Icons.thumb_up, post['upvotes'].toString()),
                const SizedBox(width: 8),
                _buildStatChip(Icons.thumb_down, post['downvotes'].toString()),
                const SizedBox(width: 8),
                _buildStatChip(
                  Icons.chat_bubble_outline,
                  post['comments'].toString(),
                ),
                const Spacer(),
                _buildStatChip(Icons.visibility, post['views'].toString()),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSavedPostCard(Map<String, dynamic> post) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0x40721908),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Author Info
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: const Color(0xFF721908),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        post['author']!,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Color(0xFF721908),
                        ),
                      ),
                      Text(
                        post['subtitle']!,
                        style: const TextStyle(
                          color: Color(0xFF721908),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                // Bookmark Icon
                IconButton(
                  onPressed: () => _removeSavedPost(post),
                  icon: const Icon(Icons.bookmark, color: Color(0xff721908)),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Tags
            Row(
              children: [
                if (post['tag1'] != null) _buildTag(post['tag1']!),
                if (post['tag1'] != null && post['tag2'] != null)
                  const SizedBox(width: 8),
                if (post['tag2'] != null) _buildTag(post['tag2']!),
              ],
            ),

            const SizedBox(height: 12),

            // Title
            Text(
              post['title']!,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF721908),
              ),
            ),

            const SizedBox(height: 8),

            // Content Preview
            Text(
              post['content']!,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF721908),
                height: 1.4,
              ),
            ),

            const SizedBox(height: 12),

            // Timestamp and Stats
            Row(
              children: [
                Text(
                  post['timestamp']!,
                  style: TextStyle(
                    fontSize: 12,
                    color: const Color(0xFF721908).withOpacity(0.7),
                  ),
                ),
                const Spacer(),
                _buildStatChip(Icons.thumb_up, post['upvotes'].toString()),
                const SizedBox(width: 8),
                _buildStatChip(
                  Icons.chat_bubble_outline,
                  post['comments'].toString(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTag(String tag) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFF721908),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        tag,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildStatChip(IconData icon, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFF721908).withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: const Color(0xFF721908)),
          const SizedBox(width: 4),
          Text(
            value,
            style: const TextStyle(
              color: Color(0xFF721908),
              fontSize: 10,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(String title, String subtitle) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.auto_stories_outlined, size: 64, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Text(
              subtitle,
              style: TextStyle(fontSize: 14, color: Colors.grey[500]),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  void _handlePostAction(String action, Map<String, dynamic> post) {
    switch (action) {
      case 'edit':
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Fitur edit akan segera tersedia')),
        );
        break;
      case 'publish':
        setState(() {
          post['status'] = 'published';
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('✅ Cerita berhasil dipublish'),
            backgroundColor: Colors.green,
          ),
        );
        break;
      case 'unpublish':
        setState(() {
          post['status'] = 'draft';
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('📝 Cerita dijadikan draft'),
            backgroundColor: Colors.orange,
          ),
        );
        break;
      case 'delete':
        _showDeleteConfirmation(post);
        break;
    }
  }

  void _showDeleteConfirmation(Map<String, dynamic> post) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Hapus Cerita'),
            content: Text(
              'Apakah Anda yakin ingin menghapus "${post['title']}"?',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Batal'),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _myPosts.remove(post);
                    filteredMyPosts.remove(post);
                  });
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('🗑️ Cerita berhasil dihapus'),
                      backgroundColor: Colors.red,
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child: const Text(
                  'Hapus',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
    );
  }

  void _removeSavedPost(Map<String, dynamic> post) {
    setState(() {
      _savedPosts.remove(post);
      filteredSavedPosts.remove(post);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('📖 Cerita dihapus dari tersimpan'),
        backgroundColor: Colors.orange,
      ),
    );
  }
}
