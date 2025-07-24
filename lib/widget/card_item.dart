import 'package:flutter/material.dart';

class CardItem extends StatelessWidget {
  const CardItem({super.key, required this.post});

  final Map<String, String> post;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: const Color(0x40721908)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Row: Profile + Info
            Row(
              children: [
                const CircleAvatar(
                  radius: 24,
                  backgroundImage: AssetImage('assets/profile_placeholder.png'),
                  // or use NetworkImage for real avatar
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        post['author']!,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        post['info1']!,
                        style: TextStyle(color: Colors.grey[600], fontSize: 13),
                      ),
                      Text(
                        post['info2']!,
                        style: TextStyle(color: Colors.grey[600], fontSize: 13),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Tag
            Wrap(
              spacing: 6,
              children: [
                Chip(
                  label: Text(post['tag']!),
                  backgroundColor: Color(0xff721908),
                  shape: StadiumBorder(),
                  labelStyle: const TextStyle(color: Color(0xFFFBF5EB)),
                ),
              ],
            ),

            // Title
            Text(
              post['title']!,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 10),
            Text(
              post['content']!,
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 15),
            ),

            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
