// Main Navigation Screen - FIXED VERSION
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

  // Add posts management
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
      'tag2': '#StoryTime',
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
      'tag2': '#StoryTime',
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
      'tag2': '#CultureShock',
      'content':
          'Sebagai urban planner, gue sering dilemma. Di satu sisi, mall itu praktis dan bersih. Tapi di sisi lain, pasar tradisional punya soul yang nggak bisa digantikan. Interaksi sosial, tawar-menawar, keberagaman yang organic. Gimana caranya kita bisa modernisasi tanpa kehilangan karakter?',
      'upvotes': 94,
      'downvotes': 12,
      'comments': 38,
    },
  ];

  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _updatePages();
  }

  void _updatePages() {
    _pages = [
      HomePage(posts: posts, onPostsChanged: _onPostsChanged),
      const SekilasBudayaPage(), // AI Search page
      const MyStoryPage(),
      const ProfilePage(),
    ];
  }

  // Callback when posts are updated
  void _onPostsChanged(List<Map<String, dynamic>> updatedPosts) {
    setState(() {
      posts = updatedPosts;
      _updatePages(); // Recreate pages with updated posts
    });
  }

  // Method to add new post
  void _addPost(Map<String, dynamic> newPost) {
    setState(() {
      posts.insert(0, newPost);
      _updatePages(); // Recreate pages with updated posts
    });
  }

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
        onAddPost: _addPost, // Use the fixed method
      ),
    );
  }
}
