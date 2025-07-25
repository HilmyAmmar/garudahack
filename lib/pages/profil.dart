import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _bioController = TextEditingController();
  final _locationController = TextEditingController();
  final _taglineController = TextEditingController();

  bool _isEditing = false;
  bool _isLoading = false;

  // Sample user data
  final Map<String, dynamic> _userData = {
    'name': 'Syarna Savitri',
    'email': 'syarna.savitri@email.com',
    'bio':
        'Cultural Storyteller yang suka mengeksplorasi keberagaman budaya Indonesia. Pecinta cerita rakyat dan tradisi lokal.',
    'location': 'Jakarta Utara',
    'tagline': 'Cultural Storyteller',
    'joinDate': '15 Januari 2024',
    'totalPosts': 12,
    'totalUpvotes': 347,
    'totalComments': 89,
  };

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  void _loadUserData() {
    _nameController.text = _userData['name'] ?? '';
    _emailController.text = _userData['email'] ?? '';
    _bioController.text = _userData['bio'] ?? '';
    _locationController.text = _userData['location'] ?? '';
    _taglineController.text = _userData['tagline'] ?? '';
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _bioController.dispose();
    _locationController.dispose();
    _taglineController.dispose();
    super.dispose();
  }

  String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Nama tidak boleh kosong';
    }
    return null;
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

  Future<void> _handleSave() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      // Simulate save process
      await Future.delayed(const Duration(seconds: 2));

      // Update user data
      _userData['name'] = _nameController.text;
      _userData['email'] = _emailController.text;
      _userData['bio'] = _bioController.text;
      _userData['location'] = _locationController.text;
      _userData['tagline'] = _taglineController.text;

      setState(() {
        _isLoading = false;
        _isEditing = false;
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('✅ Profil berhasil diperbarui!'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }

  void _handleEdit() {
    setState(() {
      _isEditing = true;
    });
  }

  void _handleCancel() {
    setState(() {
      _isEditing = false;
    });
    _loadUserData(); // Reset form data
  }

  void _handleLogout() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Logout'),
            content: const Text('Apakah Anda yakin ingin keluar?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Batal'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pushReplacementNamed(context, '/login');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Logout'),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBF5EB),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Header Section
              Stack(
                children: [
                  // Background with gradient
                  Container(
                    height: 280,
                    width: double.infinity,
                    color: Color(0xff721908),
                  ),

                  // Profile content
                  Positioned(
                    left: 20,
                    right: 20,
                    top: 20,
                    child: Column(
                      children: [
                        // App bar
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Profil',
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFFBF5EB),
                              ),
                            ),
                            IconButton(
                              onPressed: _handleLogout,
                              icon: const Icon(
                                Icons.logout,
                                color: Color(0xFFFBF5EB),
                              ),
                              tooltip: 'Logout',
                            ),
                          ],
                        ),

                        const SizedBox(height: 12),

                        // Profile picture
                        TweenAnimationBuilder(
                          duration: const Duration(milliseconds: 800),
                          tween: Tween<double>(begin: 0, end: 1),
                          builder: (context, double value, child) {
                            return Transform.scale(
                              scale: value,
                              child: Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: const Color(0xFFFBF5EB),
                                    width: 4,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.2),
                                      blurRadius: 10,
                                      offset: const Offset(0, 5),
                                    ),
                                  ],
                                ),
                                child: CircleAvatar(
                                  radius: 46,
                                  backgroundColor: const Color(0xFFFBF5EB),
                                  child: Text(
                                    _userData['name']
                                            ?.substring(0, 1)
                                            .toUpperCase() ??
                                        'U',
                                    style: const TextStyle(
                                      fontSize: 36,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xff721908),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),

                        const SizedBox(height: 12),

                        // User name and location
                        Text(
                          _userData['name'] ?? 'Unknown User',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFFBF5EB),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.location_on,
                              size: 16,
                              color: Color(0xFFFBF5EB),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              _userData['location'] ?? 'Unknown Location',
                              style: TextStyle(
                                fontSize: 14,
                                color: const Color(0xFFFBF5EB).withOpacity(0.8),
                              ),
                            ),
                            const SizedBox(),
                          ],
                        ),
                        // Tagline (jika tersedia)
                        if (_userData['tagline'] != null &&
                            _userData['tagline'].toString().isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(top: 2),
                            child: Text(
                              _userData['tagline'],
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Color(0xFFFDF1D4),
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),

              // Stats Section
              Container(
                margin: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildStatItem(
                        'Posts',
                        _userData['totalPosts'].toString(),
                        Icons.article,
                      ),
                      _buildDivider(),
                      _buildStatItem(
                        'Upvotes',
                        _userData['totalUpvotes'].toString(),
                        Icons.thumb_up,
                      ),
                      _buildDivider(),
                      _buildStatItem(
                        'Komentar',
                        _userData['totalComments'].toString(),
                        Icons.chat_bubble,
                      ),
                    ],
                  ),
                ),
              ),

              // Profile Form Section
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Section title with edit button
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Informasi Profil',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff721908),
                              ),
                            ),
                            if (!_isEditing)
                              IconButton(
                                onPressed: _handleEdit,
                                icon: const Icon(
                                  Icons.edit,
                                  color: Color(0xff721908),
                                ),
                                tooltip: 'Edit Profil',
                              ),
                          ],
                        ),

                        const SizedBox(height: 20),

                        // Name Field
                        _buildFormField(
                          controller: _nameController,
                          label: 'Nama Lengkap',
                          icon: Icons.person,
                          validator: _validateName,
                          enabled: _isEditing,
                        ),
                        const SizedBox(height: 16),

                        // Email Field
                        _buildFormField(
                          controller: _emailController,
                          label: 'Email',
                          icon: Icons.email,
                          validator: _validateEmail,
                          enabled: _isEditing,
                        ),
                        const SizedBox(height: 16),

                        // Location Field
                        _buildFormField(
                          controller: _locationController,
                          label: 'Lokasi',
                          icon: Icons.location_on,
                          enabled: _isEditing,
                        ),
                        const SizedBox(height: 16),

                        // Tagline Field
                        _buildFormField(
                          controller: _taglineController,
                          label: 'Tagline',
                          icon: Icons.workspace_premium,
                          enabled: _isEditing,
                        ),
                        const SizedBox(height: 16),

                        // Bio Field
                        _buildFormField(
                          controller: _bioController,
                          label: 'Bio',
                          icon: Icons.info,
                          maxLines: 3,
                          enabled: _isEditing,
                        ),
                        const SizedBox(height: 16),

                        // Join Date (read-only)
                        _buildInfoItem(
                          'Bergabung sejak',
                          _userData['joinDate'] ?? 'Unknown',
                        ),

                        const SizedBox(height: 24),

                        // Action buttons
                        if (_isEditing) ...[
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: _isLoading ? null : _handleCancel,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.grey[300],
                                    foregroundColor: Colors.black87,
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 12,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: const Text('Batal'),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: _isLoading ? null : _handleSave,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xff721908),
                                    foregroundColor: const Color(0xFFFBF5EB),
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 12,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child:
                                      _isLoading
                                          ? const SizedBox(
                                            width: 20,
                                            height: 20,
                                            child: CircularProgressIndicator(
                                              strokeWidth: 2,
                                              valueColor:
                                                  AlwaysStoppedAnimation<Color>(
                                                    Color(0xFFFBF5EB),
                                                  ),
                                            ),
                                          )
                                          : const Text('Simpan'),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Additional options
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    _buildMenuTile('Pengaturan', Icons.settings, () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Fitur pengaturan segera hadir'),
                        ),
                      );
                    }),
                    _buildDividerThin(),
                    _buildMenuTile('Bantuan', Icons.help, () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Fitur bantuan segera hadir'),
                        ),
                      );
                    }),
                    _buildDividerThin(),
                    _buildMenuTile('Tentang Aplikasi', Icons.info_outline, () {
                      showDialog(
                        context: context,
                        builder:
                            (context) => AlertDialog(
                              title: const Text('Tentang Aplikasi'),
                              content: const Text(
                                'Kalcer - Aplikasi untuk berbagi cerita dan mengenal budaya Indonesia.\n\nVersi 1.0.0',
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text('OK'),
                                ),
                              ],
                            ),
                      );
                    }),
                  ],
                ),
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, size: 24, color: const Color(0xff721908)),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xff721908),
          ),
        ),
        const SizedBox(height: 4),
        Text(label, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
      ],
    );
  }

  Widget _buildDivider() {
    return Container(height: 40, width: 1, color: Colors.grey[300]);
  }

  Widget _buildDividerThin() {
    return Container(height: 1, color: Colors.grey[200]);
  }

  Widget _buildFormField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    String? Function(String?)? validator,
    int maxLines = 1,
    bool enabled = true,
  }) {
    return TextFormField(
      controller: controller,
      validator: validator,
      maxLines: maxLines,
      enabled: enabled,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          color: enabled ? const Color(0xff721908) : Colors.grey,
        ),
        prefixIcon: Icon(
          icon,
          color: enabled ? const Color(0xff721908) : Colors.grey,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xff721908), width: 2),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        filled: true,
        fillColor: enabled ? Colors.white : Colors.grey[50],
      ),
    );
  }

  Widget _buildInfoItem(String label, String value) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Row(
        children: [
          Icon(Icons.calendar_today, size: 20, color: Colors.grey[600]),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
              ),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMenuTile(String title, IconData icon, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xff721908)),
      title: Text(
        title,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 16,
        color: Colors.grey,
      ),
      onTap: onTap,
    );
  }
}
