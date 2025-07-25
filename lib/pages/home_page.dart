import 'package:flutter/material.dart';
import 'package:kalcer/widget/card_item.dart';
// Import your BottomSheetForm here
// import 'bottom_sheet_form.dart';

class HomePage extends StatefulWidget {
  final List<Map<String, dynamic>>? posts;

  const HomePage({super.key, this.posts});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> filteredPosts = [];

  List<Map<String, dynamic>> posts = [
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
    {
      'title': 'Makanan Khas Betawi yang Hampir Punah',
      'author': 'Budi Raharjo',
      'subtitle': 'Food Historian, Jakarta Barat',
      'timestamp': '23 Juli 2025 | 14.30 PM',
      'tag1': '#Betawi',
      'tag2': '#Kuliner',
      'content':
          'Sebagai anak Betawi asli, gue sedih banget liat makanan tradisional kita mulai terlupakan. Kerak telor masih ada sih, tapi coba deh cari asinan Betawi yang asli atau sayur besan. Susah banget! Padahal dulu nenek gue sering masak ini...',
      'upvotes': 67,
      'downvotes': 3,
      'comments': 25,
    },
    {
      'title': 'Mengapa Yogyakarta Selalu Jadi "Home"?',
      'author': 'Rina Kusuma',
      'subtitle': 'Travel Writer, Yogyakarta',
      'timestamp': '22 Juli 2025 | 19.45 PM',
      'tag1': '#Yogyakarta',
      'tag2': '#Culture',
      'content':
          'Udah tinggal di berbagai kota, tapi kenapa ya kalau ke Jogja tuh rasanya kayak pulang ke rumah? Mungkin karena warmth dari orang-orangnya, atau karena kotanya yang masih human scale. Di sini masih bisa jalan kaki, naik becak, terus ketemu orang ramah di setiap sudut.',
      'upvotes': 89,
      'downvotes': 2,
      'comments': 34,
    },
    {
      'title': 'Generasi Z dan Tradisi Sunda',
      'author': 'Dika Permana',
      'subtitle': 'Cultural Researcher, Bandung',
      'timestamp': '21 Juli 2025 | 16.20 PM',
      'tag1': '#Sunda',
      'tag2': '#GenZ',
      'content':
          'Menarik banget ngelihat anak-anak muda sekarang yang mulai tertarik sama budaya Sunda. Dari yang dulu malu ngomong bahasa Sunda, sekarang malah bangga. Mungkin karena pengaruh sosmed juga sih, jadi budaya lokal lebih mudah di-explore dan di-share.',
      'upvotes': 156,
      'downvotes': 8,
      'comments': 42,
    },
    {
      'title': 'Ritual Kopi di Aceh yang Tak Lekang Waktu',
      'author': 'Farid Abdullah',
      'subtitle': 'Coffee Enthusiast, Banda Aceh',
      'timestamp': '20 Juli 2025 | 08.15 AM',
      'tag1': '#Aceh',
      'tag2': '#Coffee',
      'content':
          'Warung kopi di Aceh itu bukan sekadar tempat minum kopi. Ini adalah pusat diskusi, tempat bertukar kabar, bahkan tempat menyelesaikan masalah kampung. Tradisi ngopi sambil main dam atau diskusi politik masih kental banget di sini. Modernisasi datang, tapi esensinya tetap sama.',
      'upvotes': 73,
      'downvotes': 1,
      'comments': 19,
    },
    {
      'title': 'Pasar Tradisional vs Mall: Dilema Urban',
      'author': 'Sari Indah',
      'subtitle': 'Urban Planner, Surabaya',
      'timestamp': '19 Juli 2025 | 12.00 PM',
      'tag1': '#Urban',
      'tag2': '#Tradition',
      'content':
          'Sebagai urban planner, gue sering dilemma. Di satu sisi, mall itu praktis dan bersih. Tapi di sisi lain, pasar tradisional punya soul yang nggak bisa digantikan. Interaksi sosial, tawar-menawar, keberagaman yang organic. Gimana caranya kita bisa modernisasi tanpa kehilangan karakter?',
      'upvotes': 94,
      'downvotes': 12,
      'comments': 38,
    },
  ];

  @override
  void initState() {
    super.initState();
    posts = widget.posts ?? _getDefaultPosts(); // Use passed posts or default
    filteredPosts = posts; // Initialize with all posts
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
