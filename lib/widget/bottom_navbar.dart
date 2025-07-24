import 'package:flutter/material.dart';
import 'bottom_nav_item.dart';
import 'bottom_sheet_form.dart';

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
        color: const Color(0xff721908),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              BottomNavItem(
                icon: Icons.home_outlined,
                activeIcon: Icons.home,
                label: 'Beranda',
                index: 0,
                currentIndex: widget.currentIndex,
                onTap: widget.onTap,
              ),
              BottomNavItem(
                icon: Icons.search_outlined,
                activeIcon: Icons.search,
                label: 'Pencarian AI',
                index: 1,
                currentIndex: widget.currentIndex,
                onTap: widget.onTap,
              ),
              const SizedBox(width: 60),
              BottomNavItem(
                icon: Icons.analytics_outlined,
                activeIcon: Icons.analytics,
                label: 'Cerita Saya',
                index: 2,
                currentIndex: widget.currentIndex,
                onTap: widget.onTap,
              ),
              BottomNavItem(
                icon: Icons.person_outline,
                activeIcon: Icons.person,
                label: 'Profil',
                index: 3,
                currentIndex: widget.currentIndex,
                onTap: widget.onTap,
              ),
            ],
          ),
          Positioned(
            top: -15,
            left: MediaQuery.of(context).size.width / 2 - 30,
            child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xff721908),
                boxShadow: [
                  BoxShadow(
                    color: Colors.white.withOpacity(0.1),
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

  void _showAddBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => const BottomSheetForm(),
    );
  }
}
