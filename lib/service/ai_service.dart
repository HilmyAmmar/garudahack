import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class CityImageResult {
  final String imageUrl;
  final String description;
  final String source;

  CityImageResult({
    required this.imageUrl,
    required this.description,
    required this.source,
  });
}

class GeminiServiceWithFallback {
  GenerativeModel? _model;

  final List<String> _modelFallbacks = [
    'gemini-1.5-flash',
    'gemini-1.5-pro',
    'gemini-pro',
    'gemini-1.0-pro',
  ];

  Future<void> initialize() async {
    if (!dotenv.isInitialized) {
      throw Exception('❌ DotEnv belum diinisialisasi!');
    }

    final apiKey = dotenv.env['GEMINI_API_KEY'];
    if (apiKey == null || apiKey.isEmpty) {
      throw Exception('❌ GEMINI_API_KEY tidak valid');
    }

    for (String modelName in _modelFallbacks) {
      try {
        print("🔄 Trying model: $modelName");

        final testModel = GenerativeModel(
          model: modelName,
          apiKey: apiKey,
          generationConfig: GenerationConfig(
            temperature: 0.7,
            maxOutputTokens: 1024,
          ),
        );

        final testContent = [Content.text('Test')];
        await testModel.generateContent(testContent);

        _model = testModel;
        print("✅ Using model: $modelName");
        return;
      } catch (e) {
        print("❌ Model $modelName failed: $e");
        continue;
      }
    }

    throw Exception('❌ Tidak ada model Gemini yang tersedia.');
  }

  // Enhanced city validation and typo correction
  Future<String> validateAndCorrectCity(String inputCity) async {
    if (_model == null) await initialize();

    final validationPrompt = '''
Anda adalah validator lokasi budaya Indonesia. Tugas Anda:

1. Terima entitas yang relevan dengan wilayah Indonesia, seperti:
   - Kota
   - Provinsi
   - Kabupaten
   - Daerah adat
   - Nama suku (misal: Batak, Sunda, Minang)
2. Jika ada typo, perbaiki ke nama yang benar
3. Tolak input yang tidak berhubungan dengan Indonesia

Input: "$inputCity"

Format jawaban HARUS:
VALID: [nama entitas yang telah diperbaiki]
atau
INVALID: [alasan penolakan]

Contoh:
Input: "Jakareta" → VALID: Jakarta
Input: "Sumaterra Utara" → VALID: Sumatera Utara
Input: "Sundaa" → VALID: Sunda
Input: "Tokyo" → INVALID: Tokyo bukan wilayah budaya Indonesia
Input: "Atlantis" → INVALID: Atlantis tidak ada di Indonesia
''';

    try {
      final content = [Content.text(validationPrompt)];
      final response = await _model!.generateContent(content);

      if (response.text == null || response.text!.isEmpty) {
        throw Exception('Gagal memvalidasi input');
      }

      final result = response.text!.trim();
      print("🔍 Validation result: $result");

      if (result.startsWith('VALID:')) {
        return result.substring(6).trim();
      } else if (result.startsWith('INVALID:')) {
        throw Exception(result.substring(8).trim());
      } else {
        throw Exception('Format validasi tidak dikenali');
      }
    } catch (e) {
      print("❌ Validation error: $e");
      throw Exception('Gagal memvalidasi input: $e');
    }
  }

  Future<String> getCityInfo(String cityName) async {
    // First validate and correct the city name
    String validatedCity;
    try {
      validatedCity = await validateAndCorrectCity(cityName);
      print("✅ Validated city: $validatedCity");
    } catch (e) {
      throw Exception('❌ $e');
    }

    if (_model == null) await initialize();

    final prompt = '''
Anda adalah ahli budaya Indonesia terpercaya. Berikan informasi tentang $validatedCity, Indonesia.

PENTING - Aturan Ketat:
- HANYA bahas kota $validatedCity di Indonesia
- JANGAN keluar dari konteks budaya Indonesia
- Gunakan nama kota yang sudah divalidasi: $validatedCity

Format jawaban HARUS PERSIS seperti ini dengan "###" sebagai pemisah:

Sorotan Budaya: [2-3 kalimat tentang sejarah, budaya, dan keunikan $validatedCity sebagai bagian dari Indonesia]
###
Makanan Khas: [2-3 kalimat tentang kuliner khas $validatedCity yang autentik dan terkenal]
###
Etika Lokal: [2-3 kalimat tentang norma sosial, adat sopan santun, dan hal yang perlu diperhatikan di $validatedCity]
###
Unik: [2-3 kalimat tentang landmark, festival, tradisi, atau fakta unik yang hanya ada di $validatedCity]
''';

    try {
      print("🔄 Generating content for: $validatedCity");

      final content = [Content.text(prompt)];
      final response = await _model!.generateContent(content);

      if (response.text == null || response.text!.isEmpty) {
        throw Exception('Response kosong dari Gemini');
      }

      print("✅ Content generated for $validatedCity");
      return response.text!;
    } catch (e) {
      print("❌ Error generating content: $e");
      throw Exception('Gagal mengambil informasi $validatedCity: $e');
    }
  }

  // Enhanced image generation with better URLs and validation
  Future<List<CityImageResult>> fetchCityImages(String cityName) async {
    try {
      print('🖼️ Loading images for: $cityName');

      // Validate city name first
      String validatedCity;
      try {
        validatedCity = await validateAndCorrectCity(cityName);
      } catch (e) {
        validatedCity = cityName; // Use original if validation fails
      }

      List<CityImageResult> images = [];

      // Method 1: High-quality Unsplash source URLs (no API needed)
      final unsplashKeywords = _getUnsplashKeywords(validatedCity);
      for (int i = 0; i < unsplashKeywords.length && images.length < 4; i++) {
        final keyword = unsplashKeywords[i];
        final imageUrl = 'https://source.unsplash.com/800x600/?$keyword';

        images.add(
          CityImageResult(
            imageUrl: imageUrl,
            description: _formatKeywordDescription(keyword, validatedCity),
            source: 'Unsplash',
          ),
        );
      }

      // Method 2: Lorem Picsum with city-specific seeds
      final seeds = _generateSeeds(validatedCity);
      for (int i = 0; i < seeds.length && images.length < 8; i++) {
        final seed = seeds[i];
        final imageUrl = 'https://picsum.photos/seed/$seed/800/600';

        images.add(
          CityImageResult(
            imageUrl: imageUrl,
            description:
                'Pemandangan Indonesia - ${seed.replaceAll(RegExp(r'[^a-zA-Z]'), ' ').trim()}',
            source: 'Lorem Picsum',
          ),
        );
      }

      // Method 3: Additional fallback URLs
      images.addAll(_getFallbackImages(validatedCity));

      // Test URLs and return working ones
      List<CityImageResult> workingImages = [];
      for (var image in images.take(12)) {
        // Test more URLs
        try {
          final uri = Uri.parse(image.imageUrl);
          final response = await http
              .head(uri)
              .timeout(const Duration(seconds: 5));

          if (response.statusCode == 200) {
            workingImages.add(image);
            print("✅ Working image: ${image.imageUrl}");
            if (workingImages.length >= 6) break;
          }
        } catch (e) {
          print("❌ Image URL failed: ${image.imageUrl} - $e");
          continue;
        }
      }

      // Ensure we have at least some images
      if (workingImages.isEmpty) {
        workingImages = _getGuaranteedWorkingImages(validatedCity);
      }

      print('✅ Images loaded: ${workingImages.length}');
      return workingImages.take(6).toList();
    } catch (e) {
      print('❌ Error fetching city images: $e');
      return _getGuaranteedWorkingImages(cityName);
    }
  }

  // Get specific keywords for Unsplash based on Indonesian cities
  List<String> _getUnsplashKeywords(String cityName) {
    final baseKeywords = [
      'indonesia,architecture',
      'indonesian,culture',
      'traditional,indonesia',
      'indonesia,landscape',
      'indonesia,temple',
      'indonesia,city',
    ];

    // City-specific keywords
    final citySpecific = <String>[];
    switch (cityName.toLowerCase()) {
      case 'jakarta':
        citySpecific.addAll([
          'jakarta,indonesia',
          'jakarta,skyline',
          'monas,jakarta',
          'indonesia,modern,city',
        ]);
        break;
      case 'bandung':
        citySpecific.addAll([
          'bandung,indonesia',
          'west,java,indonesia',
          'indonesia,mountains',
          'sundanese,culture',
        ]);
        break;
      case 'surabaya':
        citySpecific.addAll([
          'surabaya,indonesia',
          'east,java,indonesia',
          'indonesia,port,city',
          'javanese,culture',
        ]);
        break;
      case 'medan':
        citySpecific.addAll([
          'medan,indonesia',
          'north,sumatra,indonesia',
          'batak,culture',
          'sumatra,indonesia',
        ]);
        break;
      case 'yogyakarta':
      case 'jogja':
        citySpecific.addAll([
          'yogyakarta,indonesia',
          'jogja,indonesia',
          'borobudur,indonesia',
          'javanese,palace',
        ]);
        break;
      case 'bali':
        citySpecific.addAll([
          'bali,indonesia',
          'balinese,temple',
          'bali,rice,terraces',
          'bali,culture',
        ]);
        break;
      case 'semarang':
        citySpecific.addAll([
          'semarang,indonesia',
          'central,java,indonesia',
          'lawang,sewu',
          'javanese,architecture',
        ]);
        break;
      case 'makassar':
        citySpecific.addAll([
          'makassar,indonesia',
          'south,sulawesi,indonesia',
          'bugis,culture',
          'sulawesi,indonesia',
        ]);
        break;
      default:
        citySpecific.addAll([
          '$cityName,indonesia',
          'indonesia,traditional,architecture',
          'indonesia,local,culture',
          'indonesia,heritage',
        ]);
    }

    // Combine and return
    final allKeywords = [...citySpecific, ...baseKeywords];
    return allKeywords.take(8).toList();
  }

  // Generate seeds for Lorem Picsum
  List<String> _generateSeeds(String cityName) {
    final city = cityName.toLowerCase().replaceAll(' ', '');
    return [
      city,
      '${city}1',
      '${city}2',
      '${city}culture',
      '${city}indo',
      'indonesia$city',
    ];
  }

  // Format keyword for description
  String _formatKeywordDescription(String keyword, String cityName) {
    final words = keyword
        .split(',')
        .map(
          (word) => word
              .trim()
              .split(' ')
              .map(
                (w) => w.isNotEmpty ? w[0].toUpperCase() + w.substring(1) : w,
              )
              .join(' '),
        )
        .join(' ');

    return '$words di $cityName';
  }

  // Fallback images with different approaches
  List<CityImageResult> _getFallbackImages(String cityName) {
    return [
      // LoremFlickr (another good source)
      CityImageResult(
        imageUrl: 'https://loremflickr.com/800/600/indonesia,architecture',
        description: 'Arsitektur Indonesia',
        source: 'LoremFlickr',
      ),
      CityImageResult(
        imageUrl: 'https://loremflickr.com/800/600/indonesia,culture',
        description: 'Budaya Indonesia',
        source: 'LoremFlickr',
      ),
      // PlaceIMG (reliable placeholder service)
      CityImageResult(
        imageUrl: 'https://placeimg.com/800/600/arch',
        description: 'Arsitektur - $cityName',
        source: 'PlaceIMG',
      ),
      CityImageResult(
        imageUrl: 'https://placeimg.com/800/600/nature',
        description: 'Alam - $cityName',
        source: 'PlaceIMG',
      ),
    ];
  }

  // Guaranteed working images (last resort)
  List<CityImageResult> _getGuaranteedWorkingImages(String cityName) {
    return [
      CityImageResult(
        imageUrl: 'https://picsum.photos/800/600?random=1',
        description: 'Pemandangan $cityName 1',
        source: 'Picsum Random',
      ),
      CityImageResult(
        imageUrl: 'https://picsum.photos/800/600?random=2',
        description: 'Pemandangan $cityName 2',
        source: 'Picsum Random',
      ),
      CityImageResult(
        imageUrl: 'https://picsum.photos/800/600?random=3',
        description: 'Pemandangan $cityName 3',
        source: 'Picsum Random',
      ),
      CityImageResult(
        imageUrl:
            'https://via.placeholder.com/800x600/4CAF50/FFFFFF?text=Indonesia',
        description: 'Indonesia - $cityName',
        source: 'Placeholder',
      ),
    ];
  }
}

// Keep the old class name for backward compatibility
class EnhancedGeminiServiceNoUnsplash extends GeminiServiceWithFallback {}

// Additional service for model checking
class GeminiService {
  Future<List<String>> getAvailableModels() async {
    // This is a simplified version - in real implementation,
    // you might want to test each model
    return [
      'gemini-1.5-flash',
      'gemini-1.5-pro',
      'gemini-pro',
      'gemini-1.0-pro',
    ];
  }
}
