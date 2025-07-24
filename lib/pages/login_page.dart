import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final bool _isPasswordVisible = false;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email tidak boleh kosong';
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Format email tidak valid';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password tidak boleh kosong';
    }
    if (value.length < 6) {
      return 'Password minimal 6 karakter';
    }
    return null;
  }

  Future<void> _handleLogin() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      // Simulate login process
      await Future.delayed(const Duration(seconds: 2));

      setState(() {
        _isLoading = false;
      });

      // Handle successful login here
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Login berhasil!'),
            backgroundColor: Colors.green,
          ),
        );
      }
    }
  }

  void _handleRegister() {
    // Navigate to register page or show register dialog
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Navigasi ke halaman registrasi'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  final topSection = Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      // Logo with animation
      TweenAnimationBuilder(
        duration: const Duration(milliseconds: 1000),
        tween: Tween<double>(begin: 0, end: 1),
        builder: (context, double value, child) {
          return Transform.scale(
            scale: value,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.orange.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.local_fire_department,
                size: 64,
                color: Colors.orange,
              ),
            ),
          );
        },
      ),

      const SizedBox(height: 24),

      // Welcome Text
      const Text(
        'Selamat Datang!',
        style: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: Colors.red,
        ),
      ),
      const SizedBox(height: 8),

      const Text(
        'Terhubung lewat cerita, Mengenal lewat budaya',
        style: TextStyle(fontSize: 16, color: Colors.black87, height: 1.4),
        textAlign: TextAlign.center,
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFFFF4D9),
      body: SafeArea(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight:
                  screenHeight -
                  MediaQuery.of(context).padding.top -
                  MediaQuery.of(context).padding.bottom,
            ),
            child: IntrinsicHeight(
              child: Column(
                children: [
                  // Top section - flexible
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        topSection,
                        SizedBox(height: screenHeight * 0.1),
                        Image.asset(
                          'assets/login_picture.png',
                          height: 200, // bisa ubah lebih besar lagi
                          fit: BoxFit.cover,
                        ),
                      ],
                    ),
                  ),

                  // Bottom form section
                  Container(
                    width: double.infinity,
                    constraints: BoxConstraints(
                      minHeight: screenHeight * 0.4,
                      maxHeight: screenHeight * 0.5,
                    ),
                    decoration: const BoxDecoration(
                      color: Color(0xFFFFE8B0),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                    ),
                    child: const SizedBox(), // <--- ini bikin dia kosong
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
