import 'package:flutter/material.dart';

class CardItem extends StatefulWidget {
  const CardItem({super.key, required this.post});

  final Map<String, dynamic> post;

  @override
  State<CardItem> createState() => _CardItemState();
}

class _CardItemState extends State<CardItem> {
  int upvotes = 0;
  int downvotes = 0;
  int comments = 0;
  bool hasUpvoted = false;
  bool hasDownvoted = false;

  @override
  void initState() {
    super.initState();
    // Initialize with data from post if available
    upvotes = widget.post['upvotes'] ?? 0;
    downvotes = widget.post['downvotes'] ?? 0;
    comments = widget.post['comments'] ?? 0;
  }

  void _handleUpvote() {
    setState(() {
      if (hasUpvoted) {
        // Remove upvote
        upvotes--;
        hasUpvoted = false;
      } else {
        // Add upvote
        upvotes++;
        hasUpvoted = true;

        // Remove downvote if it exists
        if (hasDownvoted) {
          downvotes--;
          hasDownvoted = false;
        }
      }
    });
  }

  void _handleDownvote() {
    setState(() {
      if (hasDownvoted) {
        // Remove downvote
        downvotes--;
        hasDownvoted = false;
      } else {
        // Add downvote
        downvotes++;
        hasDownvoted = true;

        // Remove upvote if it exists
        if (hasUpvoted) {
          upvotes--;
          hasUpvoted = false;
        }
      }
    });
  }

  void _handleComment() {
    // Handle comment action - could navigate to comment screen
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Komentar'),
            content: const Text('Fitur komentar akan segera tersedia!'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: const Color(0x40721908),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Row
            Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: const Color(0xFF721908),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.post['author'] ?? 'Syarna Savitri',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Color(0xFF721908),
                        ),
                      ),
                      Text(
                        widget.post['subtitle'] ??
                            'Cultural Storyteller, Jakarta Utara',
                        style: const TextStyle(
                          color: Color(0xFF721908),
                          fontSize: 13,
                        ),
                      ),
                      Text(
                        widget.post['timestamp'] ?? '24 Juli 2025 | 17.16 PM',
                        style: const TextStyle(
                          color: Color(0xFF721908),
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Tags
            Row(
              children: [
                if (widget.post['tag1'] != null)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF721908),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      widget.post['tag1']!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                if (widget.post['tag1'] != null && widget.post['tag2'] != null)
                  const SizedBox(width: 8),
                if (widget.post['tag2'] != null)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF721908),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      widget.post['tag2']!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 12),

            // Title with emoji
            RichText(
              text: TextSpan(
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF721908),
                ),
                children: [
                  TextSpan(
                    text: widget.post['title'] ?? 'Depok = Gotham City ',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),

            // Content
            Text(
              widget.post['content'] ??
                  'Ini hal yang menurut gue paling menarik. Warga Depok itu sadar banget kota mereka sering jadi bahan bercandaan. Meme tentang Depok udah viral dari dulu. Tapi mereka nggak marah ....',
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF721908),
                height: 1.4,
              ),
            ),
            const SizedBox(height: 16),

            // Action Buttons Row
            Row(
              children: [
                // Upvote Button
                Container(
                  decoration: BoxDecoration(
                    color:
                        hasUpvoted
                            ? const Color(0xFF721908)
                            : const Color(0xFF721908).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(20),
                      onTap: _handleUpvote,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.thumb_up,
                              size: 16,
                              color:
                                  hasUpvoted
                                      ? Colors.white
                                      : const Color(0xFF721908),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '$upvotes',
                              style: TextStyle(
                                color:
                                    hasUpvoted
                                        ? Colors.white
                                        : const Color(0xFF721908),
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),

                // Downvote Button
                Container(
                  decoration: BoxDecoration(
                    color:
                        hasDownvoted
                            ? const Color(0xFF721908)
                            : const Color(0xFF721908).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(20),
                      onTap: _handleDownvote,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.thumb_down,
                              size: 16,
                              color:
                                  hasDownvoted
                                      ? Colors.white
                                      : const Color(0xFF721908),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '$downvotes',
                              style: TextStyle(
                                color:
                                    hasDownvoted
                                        ? Colors.white
                                        : const Color(0xFF721908),
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const Spacer(),

                // Comment Button
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF721908).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(20),
                      onTap: _handleComment,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.chat_bubble_outline,
                              size: 16,
                              color: Color(0xFF721908),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '$comments',
                              style: const TextStyle(
                                color: Color(0xFF721908),
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
