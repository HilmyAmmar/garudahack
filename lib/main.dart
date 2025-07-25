import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:kalcer/pages/login_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await dotenv.load(fileName: ".env");
    print("✅ .env file loaded successfully");

    final apiKey = dotenv.env['GEMINI_API_KEY'];
    if (apiKey != null && apiKey.isNotEmpty) {
      print(
        "✅ API Key loaded: ${apiKey.substring(0, 10)}...${apiKey.substring(apiKey.length - 4)}",
      );
    } else {
      print("❌ API Key not found or empty");
    }
  } catch (e) {
    print("❌ Error loading .env: $e");
  }

  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: LoginPage());
  }
}
