import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Detailed view of a single post with comments
class PostDetailPage extends ConsumerWidget {
  final String postId;
  
  const PostDetailPage({
    super.key,
    required this.postId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.post_add_outlined, size: 64, color: Colors.grey),
            const SizedBox(height: 16),
            Text('Post ID: $postId'),
            const SizedBox(height: 8),
            const Text('Post details coming soon...'),
          ],
        ),
      ),
    );
  }
}
