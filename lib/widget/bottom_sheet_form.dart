import 'package:flutter/material.dart';
import 'tag_chip.dart';

class BottomSheetForm extends StatelessWidget {
  const BottomSheetForm({super.key});

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
                        _buildInputField('Judul cerita kamu disini'),

                        const SizedBox(height: 24),
                        _buildLabel('Kota'),
                        _buildInputField('Kota cerita kamu disini'),

                        const SizedBox(height: 24),
                        _buildLabel('Tags'),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            TagChip(label: '#Storytime', isSelected: true),
                            const SizedBox(width: 8),
                            TagChip(label: '#DoAndDont', isSelected: false),
                            const SizedBox(width: 8),
                            TagChip(label: '#AskLocal', isSelected: false),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            TagChip(label: '#Review', isSelected: false),
                            const SizedBox(width: 8),
                            TagChip(label: '#CultureShock', isSelected: false),
                          ],
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
                          child: const TextField(
                            maxLines: null,
                            expands: true,
                            decoration: InputDecoration(
                              hintText: 'Tulis ceritamu disini...',
                              hintStyle: TextStyle(
                                color: Color(0xFF8B4513),
                                fontSize: 16,
                              ),
                              border: InputBorder.none,
                            ),
                            style: TextStyle(
                              color: Color(0xFF8B4513),
                              fontSize: 16,
                            ),
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
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        // Handle submit
                      },
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

  Widget _buildInputField(String hint) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
    decoration: BoxDecoration(
      color: const Color(0x40721908),
      borderRadius: BorderRadius.circular(12),
    ),
    child: TextField(
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Color(0xFF8B4513), fontSize: 16),
        border: InputBorder.none,
      ),
      style: const TextStyle(color: Color(0xFF8B4513), fontSize: 16),
    ),
  );
}
