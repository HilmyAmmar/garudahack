// pages/sekilas_budaya_page.dart - IMPROVED VERSION
import 'package:flutter/material.dart';
import 'package:kalcer/models/city_info.dart';
import 'package:kalcer/service/ai_service.dart';

class SekilasBudayaPage extends StatefulWidget {
  const SekilasBudayaPage({super.key});

  @override
  State<SekilasBudayaPage> createState() => _SekilasBudayaPageState();
}

class _SekilasBudayaPageState extends State<SekilasBudayaPage> {
  final TextEditingController _searchController = TextEditingController();

  // Use the improved service
  GeminiServiceWithFallback? _geminiService;

  String _currentCity = '';
  CityInfo _currentCityInfo = CityInfo.loading();
  bool _isLoading = false;
  String _initError = '';

  final Map<String, CityInfo> _cityCache = {};

  @override
  void initState() {
    super.initState();
    _initializeService();
  }

  Future<void> _initializeService() async {
    try {
      setState(() {
        _isLoading = true;
        _initError = '';
        _currentCityInfo = CityInfo.loading();
      });

      _geminiService = GeminiServiceWithFallback();
      await _geminiService!.initialize();

      print("✅ GeminiServiceWithFallback initialized successfully");

      setState(() {
        _isLoading = false;
        // Reset to empty state after successful initialization
        _currentCityInfo = CityInfo(
          title: 'Sekilas Budaya Indonesia',
          sorotan: 'Silakan masukkan nama kota untuk melihat informasi budaya.',
          makanan: 'Setiap daerah memiliki makanan khas yang unik.',
          etika: 'Pelajari etika dan norma lokal sebelum berkunjung.',
          unik: 'Temukan keunikan setiap kota di Indonesia.',
        );
      });
    } catch (e) {
      print("❌ Failed to initialize GeminiService: $e");
      setState(() {
        _initError = 'Gagal menginisialisasi layanan AI: ${e.toString()}';
        _isLoading = false;
        _currentCityInfo = CityInfo.error(_initError);
      });
    }
  }

  Future<void> _loadCityData(String cityName) async {
    if (_geminiService == null) {
      setState(() {
        _currentCityInfo = CityInfo.error(
          'Service belum siap. Error: $_initError',
        );
      });
      return;
    }

    final cacheKey = cityName.toLowerCase().trim();

    // Check cache first
    if (_cityCache.containsKey(cacheKey)) {
      setState(() {
        _currentCityInfo = _cityCache[cacheKey]!;
        _currentCity = cityName;
      });

      _showSuccessMessage('Data dimuat dari cache untuk $cityName');
      return;
    }

    setState(() {
      _isLoading = true;
      _currentCityInfo = CityInfo.loading();
    });

    try {
      print('🔄 Loading data for: $cityName');

      // Get city information from AI
      final response = await _geminiService!.getCityInfo(cityName);
      print('✅ AI Response received (${response.length} chars)');

      // Parse the response into CityInfo object
      final cityInfo = CityInfo.fromAIResponse(response);

      // Validate the parsed data
      if (!cityInfo.isValid) {
        throw Exception('Data yang diterima tidak lengkap atau tidak valid');
      }

      setState(() {
        _currentCityInfo = cityInfo;
        _currentCity = cityName;
        _cityCache[cacheKey] = cityInfo;
        _isLoading = false;
      });

      _showSuccessMessage('✅ Data berhasil dimuat untuk $cityName');
    } catch (e) {
      print('❌ Error loading city data: $e');

      final errorMessage = e.toString();
      final errorInfo = CityInfo(
        title: 'Error - $cityName',
        sorotan: 'Gagal memuat informasi untuk $cityName',
        makanan: 'Detail error: $errorMessage',
        etika: 'Silakan periksa koneksi internet dan coba lagi',
        unik:
            errorMessage.contains('bukan kota di Indonesia')
                ? 'Pastikan Anda memasukkan nama kota yang ada di Indonesia'
                : 'Gagal memuat informasi dari server AI',
      );

      setState(() {
        _isLoading = false;
        _currentCityInfo = errorInfo;
        _currentCity = cityName;
      });

      _showErrorMessage(errorMessage, cityName);
    }
  }

  Future<void> _searchCity() async {
    String searchText = _searchController.text.trim();
    if (searchText.isEmpty) {
      _showWarningMessage('Silakan masukkan nama kota terlebih dahulu');
      return;
    }

    // Hide keyboard
    FocusScope.of(context).unfocus();

    await _loadCityData(searchText);
  }

  void _showSuccessMessage(String message) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  void _showErrorMessage(String error, String cityName) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Gagal memuat data: $error'),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 4),
          action: SnackBarAction(
            label: 'Coba Lagi',
            textColor: Colors.white,
            onPressed: () => _loadCityData(cityName),
          ),
        ),
      );
    }
  }

  void _showWarningMessage(String message) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.orange,
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  void _clearSearch() {
    _searchController.clear();
    setState(() {
      _currentCity = '';
      _currentCityInfo = CityInfo(
        title: 'Sekilas Budaya Indonesia',
        sorotan: 'Silakan masukkan nama kota untuk melihat informasi budaya.',
        makanan: 'Setiap daerah memiliki makanan khas yang unik.',
        etika: 'Pelajari etika dan norma lokal sebelum berkunjung.',
        unik: 'Temukan keunikan setiap kota di Indonesia.',
      );
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBF5EB),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header Section
            _buildHeaderSection(),

            // Summary Section
            _buildSummarySection(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderSection() {
    return Stack(
      children: [
        // Background Image
        Container(
          height: 300,
          width: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                'https://a.travel-assets.com/findyours-php/viewfinder/images/res70/210000/210083-Central-Java.jpg',
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),

        // Overlay Gradient
        Container(
          height: 300,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withOpacity(0.3),
                Colors.black.withOpacity(0.7),
              ],
            ),
          ),
        ),

        // Title and Status
        Positioned(
          left: 40,
          bottom: 80,
          right: 100,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _currentCityInfo.title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              _buildStatusIndicator(),
            ],
          ),
        ),

        // Search Bar
        Positioned(left: 40, right: 40, bottom: 10, child: _buildSearchBar()),
      ],
    );
  }

  Widget _buildStatusIndicator() {
    if (_isLoading) {
      return Row(
        children: [
          const SizedBox(
            width: 16,
            height: 16,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            _currentCity.isEmpty
                ? 'Menginisialisasi...'
                : 'Memuat data $_currentCity...',
            style: TextStyle(
              color: Colors.white.withOpacity(0.8),
              fontSize: 12,
            ),
          ),
        ],
      );
    } else if (_initError.isNotEmpty) {
      return Text(
        '⚠️ Service Error',
        style: TextStyle(color: Colors.orange[300], fontSize: 12),
      );
    } else if (_currentCityInfo.isError) {
      return Text(
        '❌ Load Error',
        style: TextStyle(color: Colors.red[300], fontSize: 12),
      );
    } else if (_currentCity.isNotEmpty) {
      return Text(
        '✅ Data ready',
        style: TextStyle(color: Colors.green[300], fontSize: 12),
      );
    }

    return Text(
      '🔍 Siap untuk pencarian',
      style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 12),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFFBF5EB),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: TextField(
        controller: _searchController,
        onSubmitted: (_) => _searchCity(),
        enabled: !_isLoading,
        decoration: InputDecoration(
          hintText:
              'Cari kota Indonesia (contoh: Jakarta, Bandung, Yogyakarta)',
          hintStyle: const TextStyle(fontSize: 12),
          prefixIcon: const Icon(Icons.search, color: Color(0xff721908)),
          suffixIcon: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (_searchController.text.isNotEmpty)
                IconButton(
                  icon: const Icon(Icons.clear, color: Color(0xff721908)),
                  onPressed: _clearSearch,
                ),
              IconButton(
                icon:
                    _isLoading
                        ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Color(0xff721908),
                            ),
                          ),
                        )
                        : const Icon(
                          Icons.arrow_forward,
                          color: Color(0xff721908),
                        ),
                onPressed: _isLoading ? null : _searchCity,
              ),
            ],
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 15,
          ),
        ),
      ),
    );
  }

  Widget _buildSummarySection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(30),
      decoration: const BoxDecoration(
        color: Color(0xFFFBF5EB),
        // borderRadius: BorderRadius.only(
        //   topLeft: Radius.circular(24),
        //   topRight: Radius.circular(24),
        // ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Align(
            alignment: Alignment.center,
            child: Text(
              'Informasi Budaya',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xff721908),
              ),
            ),
          ),
          const SizedBox(height: 20),
          _buildContentSections(),
        ],
      ),
    );
  }

  Widget _buildContentSections() {
    if (_currentCity.isEmpty && !_currentCityInfo.isError) {
      return _buildEmptyState();
    } else if (_isLoading) {
      return _buildLoadingState();
    } else {
      return Column(
        children: [
          _buildSection('Sorotan Budaya', _currentCityInfo.sorotan),
          _buildSection('Makanan Khas', _currentCityInfo.makanan),
          _buildSection('Etika & Norma Lokal', _currentCityInfo.etika),
          _buildSection(
            _currentCity.isEmpty ? 'Keunikan Indonesia' : 'Fakta Unik',
            _currentCityInfo.unik,
          ),
        ],
      );
    }
  }

  Widget _buildEmptyState() {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Icon(Icons.search_outlined, size: 48, color: Color(0xff721908)),
            SizedBox(height: 16),
            Align(
              alignment: Alignment.center,
              child: Text(
                'Silakan masukkan nama kota Indonesia untuk melihat informasi budayanya.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Color(0xff721908), fontSize: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingState() {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xff721908)),
            ),
            SizedBox(height: 16),
            Text(
              'Memuat informasi budaya dari Gemini AI...',
              style: TextStyle(color: Color(0xff721908), fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xff721908),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.8),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: const Color(0xff721908).withOpacity(0.2)),
          ),
          child: Text(
            content,
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF5D4037),
              height: 1.5,
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
