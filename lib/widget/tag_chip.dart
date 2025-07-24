import 'package:flutter/material.dart';

class TagChip extends StatelessWidget {
  final String label;
  final bool isSelected;

  const TagChip({super.key, required this.label, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFF721908) : Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFF721908), width: 1.5),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isSelected ? Colors.white : const Color(0xFF721908),
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
