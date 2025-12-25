import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Page showing list of users that a user is following
class FollowingPage extends ConsumerWidget {
  final String userId;
  
  const FollowingPage({
    super.key,
    required this.userId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Following'),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.person_add_outlined, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text('Following list coming soon...'),
          ],
        ),
      ),
    );
  }
}
