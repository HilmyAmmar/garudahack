import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatefulWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  State<CustomBottomNavBar> createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: Color(0xff721908),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 15,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Bottom Navigation Items
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildNavItem(
                icon: Icons.home_outlined,
                activeIcon: Icons.home,
                label: 'Home',
                index: 0,
              ),
              _buildNavItem(
                icon: Icons.search_outlined,
                activeIcon: Icons.search,
                label: 'Search',
                index: 1,
              ),
              // Empty space for center button
              const SizedBox(width: 60),
              _buildNavItem(
                icon: Icons.favorite_outline,
                activeIcon: Icons.favorite,
                label: 'Favorite',
                index: 2,
              ),
              _buildNavItem(
                icon: Icons.person_outline,
                activeIcon: Icons.person,
                label: 'Profile',
                index: 3,
              ),
            ],
          ),
          // Center Plus Button
          Positioned(
            top: -15,
            left: MediaQuery.of(context).size.width / 2 - 30,
            child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xff721908),
                boxShadow: [
                  BoxShadow(
                    color: Colors.orange.withOpacity(0.3),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(30),
                  onTap: () => _showAddBottomSheet(context),
                  child: const Icon(Icons.add, color: Colors.white, size: 30),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required IconData activeIcon,
    required String label,
    required int index,
  }) {
    final isSelected = widget.currentIndex == index;

    return Expanded(
      child: InkWell(
        onTap: () => widget.onTap(index),
        splashColor: Colors.orange.withOpacity(0.2),
        highlightColor: Colors.orange.withOpacity(0.1),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color:
                      isSelected
                          ? Colors.orange.withOpacity(0.1)
                          : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  isSelected ? activeIcon : icon,
                  color: isSelected ? Colors.orange : Colors.grey,
                  size: 24,
                ),
              ),
              const SizedBox(height: 4),
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 200),
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                  color: isSelected ? Colors.orange : Colors.grey,
                ),
                child: Text(label),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showAddBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder:
          (context) => DraggableScrollableSheet(
            initialChildSize: 0.75,
            minChildSize: 0.5,
            maxChildSize: 0.95,
            builder:
                (context, scrollController) => Container(
                  decoration: const BoxDecoration(
                    color: Color(0xFFFBF5EB),
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(48),
                    ),
                  ),
                  child: Column(
                    children: [
                      // Handle bar
                      Container(
                        margin: const EdgeInsets.only(top: 12),
                        width: 50,
                        height: 5,
                        decoration: BoxDecoration(
                          color: Colors.grey[400],
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),

                      // Header
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

                      // Form Content
                      Expanded(
                        child: SingleChildScrollView(
                          controller: scrollController,
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Judul Section
                              const Text(
                                'Judul',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF8B4513),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(
                                    0xFFD2B48C,
                                  ).withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const TextField(
                                  decoration: InputDecoration(
                                    hintText: 'Ketemu Pak Joko di Solo',
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

                              const SizedBox(height: 24),

                              // Kota Section
                              const Text(
                                'Kota',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF8B4513),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(
                                    0xFFD2B48C,
                                  ).withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const TextField(
                                  decoration: InputDecoration(
                                    hintText: 'Solo',
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

                              const SizedBox(height: 24),

                              // Tags Section
                              const Text(
                                'Tags',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF8B4513),
                                ),
                              ),
                              const SizedBox(height: 12),

                              // Tags Row 1
                              Row(
                                children: [
                                  _buildTag('#Storytime', isSelected: true),
                                  const SizedBox(width: 8),
                                  _buildTag('#DoAndDont', isSelected: false),
                                  const SizedBox(width: 8),
                                  _buildTag('#AskLocal', isSelected: false),
                                ],
                              ),
                              const SizedBox(height: 8),

                              // Tags Row 2
                              Row(
                                children: [
                                  _buildTag('#Review', isSelected: false),
                                  const SizedBox(width: 8),
                                  _buildTag('#CultureShock', isSelected: false),
                                ],
                              ),

                              const SizedBox(height: 24),

                              // Story Content
                              Container(
                                height: 200,
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: const Color(
                                    0xFFD2B48C,
                                  ).withOpacity(0.3),
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

                      // Submit Button
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
                              backgroundColor: const Color(0xFF8B4513),
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

  Widget _buildTag(String tag, {required bool isSelected}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFF8B4513) : Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFF8B4513), width: 1.5),
      ),
      child: Text(
        tag,
        style: TextStyle(
          color: isSelected ? Colors.white : const Color(0xFF8B4513),
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
