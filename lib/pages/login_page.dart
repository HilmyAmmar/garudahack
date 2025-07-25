import 'package:flutter/material.dart';
import 'package:kalcer/screens/main_navigation_screen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isLoading = false;

  // Hardcoded credentials
  final String _validUsername = "user";
  final String _validPassword = "1234";

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  String? _validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'Username tidak boleh kosong';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password tidak boleh kosong';
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

      // Check credentials
      if (_usernameController.text == _validUsername &&
          _passwordController.text == _validPassword) {
        // Handle successful login here
        if (mounted) {
          // Navigate to next page or save login state
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => MainNavigationScreen()),
          );
        }
      } else {
        // Handle failed login
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Username atau password salah!'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }
  }

  Widget get topSection => Column(
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
                color: const Color(0xff721908).withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Image.asset('assets/logo.png', width: 64, height: 64),
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
          color: Color(0xff721908),
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
      backgroundColor: const Color(0xFFFBF5EB),
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
                        Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: topSection,
                        ),
                        SizedBox(height: screenHeight * 0.05),
                        Image.asset(
                          'assets/login_picture.png',
                          height: 150,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              height: 150,
                              width: 150,
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Icon(
                                Icons.image,
                                size: 50,
                                color: Colors.grey,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),

                  // Bottom form section
                  Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Color(0xff721908),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const Text(
                              'Masuk',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFFBF5EB),
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 32),

                            // Username Field
                            TextFormField(
                              controller: _usernameController,
                              validator: _validateUsername,
                              decoration: InputDecoration(
                                labelText: 'Username',
                                labelStyle: const TextStyle(color: Colors.grey),
                                floatingLabelStyle: const TextStyle(
                                  color: Color(0xff721908),
                                ),
                                prefixIcon: const Icon(
                                  Icons.person,
                                  color: Color(0xff721908),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: const BorderSide(
                                    color: Colors.grey,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: const BorderSide(
                                    color: Color(0xff721908),
                                    width: 2,
                                  ),
                                ),
                                filled: true,
                                fillColor: const Color(0xFFFBF5EB),
                              ),
                            ),
                            const SizedBox(height: 16),

                            // Password Field
                            TextFormField(
                              controller: _passwordController,
                              validator: _validatePassword,
                              obscureText: !_isPasswordVisible,
                              decoration: InputDecoration(
                                labelText: 'Password',
                                labelStyle: const TextStyle(color: Colors.grey),
                                floatingLabelStyle: const TextStyle(
                                  color: Color(0xff721908),
                                ),
                                prefixIcon: const Icon(
                                  Icons.lock,
                                  color: Color(0xff721908),
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _isPasswordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: const Color(0xff721908),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _isPasswordVisible = !_isPasswordVisible;
                                    });
                                  },
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: const BorderSide(
                                    color: Colors.grey,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: const BorderSide(
                                    color: Color(0xff721908),
                                    width: 2,
                                  ),
                                ),
                                filled: true,
                                fillColor: const Color(0xFFFBF5EB),
                              ),
                            ),
                            const SizedBox(height: 24),

                            // Login Button
                            SizedBox(
                              height: 50,
                              child: ElevatedButton(
                                onPressed: _isLoading ? null : _handleLogin,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFFFBF5EB),
                                  foregroundColor: const Color(0xff721908),
                                  disabledBackgroundColor: const Color(
                                    0xFFFBF5EB,
                                  ),
                                  disabledForegroundColor: const Color(
                                    0xff721908,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  elevation: 2,
                                ),
                                child:
                                    _isLoading
                                        ? Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            SizedBox(
                                              width: 20,
                                              height: 20,
                                              child: CircularProgressIndicator(
                                                strokeWidth: 2,
                                                valueColor: AlwaysStoppedAnimation<
                                                  Color
                                                >(
                                                  Color(
                                                    0xff721908,
                                                  ), // Your app's primary color
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 12),
                                            const Text(
                                              'Memproses...',
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xff721908),
                                              ),
                                            ),
                                          ],
                                        )
                                        : const Text(
                                          'Masuk',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                              ),
                            ),
                            const SizedBox(height: 16),

                            // Register Link
                            TextButton(
                              onPressed: () => {},
                              child: const Text(
                                'Belum punya akun? Daftar sekarang',
                                style: TextStyle(
                                  color: Color(0xFFFBF5EB),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),

                            // Demo credentials info
                            // Container(
                            //   padding: const EdgeInsets.all(12),
                            //   decoration: BoxDecoration(
                            //     color: const Color(0xFFFBF5EB).withOpacity(0.2),
                            //     borderRadius: BorderRadius.circular(8),
                            //     border: Border.all(
                            //       color: const Color(
                            //         0xFFFBF5EB,
                            //       ).withOpacity(0.5),
                            //     ),
                            //   ),
                            //   child: const Column(
                            //     children: [
                            //       Text(
                            //         'Demo Login:',
                            //         style: TextStyle(
                            //           fontWeight: FontWeight.bold,
                            //           color: Color(0xFFFBF5EB),
                            //         ),
                            //       ),
                            //       SizedBox(height: 4),
                            //       Text(
                            //         'Username: user\nPassword: 1234',
                            //         style: TextStyle(
                            //           color: Color(0xFFFBF5EB),
                            //           fontSize: 12,
                            //         ),
                            //         textAlign: TextAlign.center,
                            //       ),
                            //     ],
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    ),
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
