class CityInfo {
  final String title;
  final String sorotan;
  final String makanan;
  final String etika;
  final String unik;

  CityInfo({
    required this.title,
    required this.sorotan,
    required this.makanan,
    required this.etika,
    required this.unik,
  });

  // Factory constructor untuk loading state
  factory CityInfo.loading() {
    return CityInfo(
      title: 'Memuat...',
      sorotan: 'Sedang memuat informasi budaya...',
      makanan: 'Sedang mencari makanan khas...',
      etika: 'Sedang mengumpulkan etika lokal...',
      unik: 'Sedang mencari keunikan...',
    );
  }

  // Factory constructor untuk error state
  factory CityInfo.error(String message) {
    return CityInfo(
      title: 'Error',
      sorotan: 'Terjadi kesalahan saat memuat informasi.',
      makanan: 'Detail error: $message',
      etika: 'Silakan periksa koneksi internet dan coba lagi.',
      unik: 'Atau hubungi administrator jika masalah berlanjut.',
    );
  }

  // Factory constructor dari AI response
  factory CityInfo.fromAIResponse(String aiResponse) {
    try {
      // Split berdasarkan separator ###
      final sections = aiResponse.split('###');

      if (sections.length < 4) {
        throw Exception(
          'Format response AI tidak lengkap. Sections found: ${sections.length}',
        );
      }

      // Extract city name dari sorotan bagian pertama
      String cityName = 'Kota Indonesia';
      final sorotanText = sections[0].trim();

      // Coba extract nama kota dari text
      final sorotanWords = sorotanText.split(' ');
      for (int i = 0; i < sorotanWords.length; i++) {
        final word = sorotanWords[i];
        // Jika kata dimulai dengan huruf kapital dan bukan kata umum
        if (word.isNotEmpty &&
            word[0] == word[0].toUpperCase() &&
            ![
              'Sorotan',
              'Budaya',
              'Kota',
              'Indonesia',
              'Daerah',
              'Wilayah',
            ].contains(word)) {
          cityName = word;
          break;
        }
      }

      return CityInfo(
        title: 'Sekilas Budaya $cityName',
        sorotan: _cleanSection(sections[0], 'Sorotan Budaya:'),
        makanan: _cleanSection(sections[1], 'Makanan Khas:'),
        etika: _cleanSection(sections[2], 'Etika Lokal:'),
        unik: _cleanSection(sections[3], 'Unik:'),
      );
    } catch (e) {
      print('❌ Error parsing AI response: $e');
      print('📄 Raw response: $aiResponse');

      return _fallbackParsing(aiResponse);
    }
  }

  // Method helper untuk membersihkan section
  static String _cleanSection(String section, String header) {
    String cleaned = section.trim();

    // Remove header jika ada
    if (cleaned.startsWith(header)) {
      cleaned = cleaned.substring(header.length).trim();
    }

    // Remove bullet points atau numbering
    cleaned = cleaned.replaceAll(RegExp(r'^[-•*]\s*'), '');
    cleaned = cleaned.replaceAll(RegExp(r'^\d+\.\s*'), '');

    // Ensure tidak kosong
    if (cleaned.isEmpty) {
      cleaned = 'Informasi tidak tersedia.';
    }

    return cleaned;
  }

  // Fallback parsing jika format standar gagal
  static CityInfo _fallbackParsing(String aiResponse) {
    try {
      // Coba parsing dengan berbagai pemisah
      List<String> sections = [];

      // Coba dengan newline double
      if (aiResponse.contains('\n\n')) {
        sections = aiResponse.split('\n\n');
      }
      // Coba dengan single newline
      else if (aiResponse.contains('\n')) {
        sections =
            aiResponse.split('\n').where((s) => s.trim().isNotEmpty).toList();
      }
      // Jika tidak ada pemisah, bagi manual
      else {
        final words = aiResponse.split(' ');
        final length = words.length;
        sections = [
          words.take(length ~/ 4).join(' '),
          words.skip(length ~/ 4).take(length ~/ 4).join(' '),
          words.skip(length ~/ 2).take(length ~/ 4).join(' '),
          words.skip(3 * length ~/ 4).join(' '),
        ];
      }

      // Pastikan minimal ada 4 sections
      while (sections.length < 4) {
        sections.add('Informasi tidak tersedia.');
      }

      return CityInfo(
        title: 'Sekilas Budaya Indonesia',
        sorotan: _cleanSection(sections[0], ''),
        makanan: _cleanSection(sections[1], ''),
        etika: _cleanSection(sections[2], ''),
        unik: _cleanSection(sections[3], ''),
      );
    } catch (e) {
      print('❌ Fallback parsing juga gagal: $e');

      // Last resort - return basic info dengan raw response
      return CityInfo(
        title: 'Informasi Budaya',
        sorotan:
            aiResponse.length > 100
                ? '${aiResponse.substring(0, 100)}...'
                : aiResponse,
        makanan: 'Makanan khas daerah Indonesia sangat beragam.',
        etika: 'Hormati budaya dan adat istiadat setempat.',
        unik: 'Setiap daerah di Indonesia memiliki keunikan tersendiri.',
      );
    }
  }

  // Method untuk debugging
  @override
  String toString() {
    return '''
CityInfo {
  title: $title,
  sorotan: ${sorotan.length > 50 ? '${sorotan.substring(0, 50)}...' : sorotan},
  makanan: ${makanan.length > 50 ? '${makanan.substring(0, 50)}...' : makanan},
  etika: ${etika.length > 50 ? '${etika.substring(0, 50)}...' : etika},
  unik: ${unik.length > 50 ? '${unik.substring(0, 50)}...' : unik},
}''';
  }

  // Method untuk validasi
  bool get isValid {
    return title.isNotEmpty &&
        sorotan.isNotEmpty &&
        makanan.isNotEmpty &&
        etika.isNotEmpty &&
        unik.isNotEmpty;
  }

  // Method untuk mengecek apakah loading
  bool get isLoading {
    return title == 'Memuat...' || sorotan.contains('Sedang memuat');
  }

  // Method untuk mengecek apakah error
  bool get isError {
    return title == 'Error' || sorotan.contains('Terjadi kesalahan');
  }
}
