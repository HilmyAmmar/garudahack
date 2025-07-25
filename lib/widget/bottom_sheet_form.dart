import 'package:flutter/material.dart';
import 'tag_chip.dart';

class BottomSheetForm extends StatefulWidget {
  final Function(Map<String, dynamic>)? onSubmit;

  const BottomSheetForm({super.key, this.onSubmit});

  @override
  State<BottomSheetForm> createState() => _BottomSheetFormState();
}

class _BottomSheetFormState extends State<BottomSheetForm> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _cityController = TextEditingController();
  final _contentController = TextEditingController();

  String _selectedTag = '#Storytime';
  final List<String> _availableTags = [
    '#Storytime',
    '#DoAndDont',
    '#AskLocal',
    '#Review',
    '#CultureShock',
  ];

  @override
  void dispose() {
    _titleController.dispose();
    _cityController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    if (_formKey.currentState?.validate() ?? false) {
      final newPost = {
        'title': _titleController.text.trim(),
        'author': 'Current User', // You can replace this with actual user data
        'subtitle': 'User, ${_cityController.text.trim()}',
        'timestamp': _formatTimestamp(DateTime.now()),
        'tag1': _selectedTag,
        'tag2': '#UserPost',
        'content': _contentController.text.trim(),
        'upvotes': 0,
        'downvotes': 0,
        'comments': 0,
      };

      widget.onSubmit?.call(newPost);
      Navigator.pop(context, newPost);
    }
  }

  String _formatTimestamp(DateTime dateTime) {
    final months = [
      'Januari',
      'Februari',
      'Maret',
      'April',
      'Mei',
      'Juni',
      'Juli',
      'Agustus',
      'September',
      'Oktober',
      'November',
      'Desember',
    ];

    final day = dateTime.day;
    final month = months[dateTime.month - 1];
    final year = dateTime.year;
    final hour = dateTime.hour.toString().padLeft(2, '0');
    final minute = dateTime.minute.toString().padLeft(2, '0');

    return '$day $month $year | $hour.$minute ${dateTime.hour >= 12 ? 'PM' : 'AM'}';
  }

  void _selectTag(String tag) {
    setState(() {
      _selectedTag = tag;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.75,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      builder:
          (context, scrollController) => Container(
            decoration: const BoxDecoration(
              color: Color(0xFFFBF5EB),
              borderRadius: BorderRadius.vertical(top: Radius.circular(48)),
            ),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 12),
                    width: 50,
                    height: 5,
                    decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(24),
                    child: const Text(
                      'Tambahkan Cerita',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF8B4513),
                      ),
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      controller: scrollController,
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildLabel('Judul'),
                          _buildInputField(
                            'Judul cerita kamu disini',
                            _titleController,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Judul tidak boleh kosong';
                              }
                              return null;
                            },
                          ),

                          const SizedBox(height: 24),
                          _buildLabel('Kota'),
                          _buildInputField(
                            'Kota cerita kamu disini',
                            _cityController,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Kota tidak boleh kosong';
                              }
                              return null;
                            },
                          ),

                          const SizedBox(height: 24),
                          _buildLabel('Tags'),
                          const SizedBox(height: 12),
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children:
                                _availableTags
                                    .map(
                                      (tag) => TagChip(
                                        label: tag,
                                        isSelected: _selectedTag == tag,
                                        onTap: () => _selectTag(tag),
                                      ),
                                    )
                                    .toList(),
                          ),

                          const SizedBox(height: 24),
                          _buildLabel('Cerita'),
                          Container(
                            height: 200,
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: const Color(0x40721908),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: TextFormField(
                              controller: _contentController,
                              maxLines: null,
                              expands: true,
                              textAlignVertical: TextAlignVertical.top,
                              decoration: const InputDecoration(
                                hintText: 'Tulis ceritamu disini...',
                                hintStyle: TextStyle(
                                  color: Color(0xFF8B4513),
                                  fontSize: 16,
                                ),
                                border: InputBorder.none,
                              ),
                              style: const TextStyle(
                                color: Color(0xFF8B4513),
                                fontSize: 16,
                              ),
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Cerita tidak boleh kosong';
                                }
                                if (value.trim().length < 10) {
                                  return 'Cerita minimal 10 karakter';
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(height: 32),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 24,
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: _handleSubmit,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF721908),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 0,
                        ),
                        child: const Text(
                          'Kirim',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
    );
  }

  Widget _buildLabel(String label) => Text(
    label,
    style: const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: Color(0xFF721908),
    ),
  );

  Widget _buildInputField(
    String hint,
    TextEditingController controller, {
    String? Function(String?)? validator,
  }) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
    decoration: BoxDecoration(
      color: const Color(0x40721908),
      borderRadius: BorderRadius.circular(12),
    ),
    child: TextFormField(
      controller: controller,
      validator: validator,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Color(0xFF8B4513), fontSize: 16),
        border: InputBorder.none,
        errorStyle: const TextStyle(color: Color(0xFF721908)),
      ),
      style: const TextStyle(color: Color(0xFF8B4513), fontSize: 16),
    ),
  );
}
