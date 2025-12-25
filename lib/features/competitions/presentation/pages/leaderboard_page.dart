import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Page showing competition leaderboard/rankings
class LeaderboardPage extends ConsumerWidget {
  final String competitionId;
  
  const LeaderboardPage({
    super.key,
    required this.competitionId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Leaderboard'),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.leaderboard_outlined, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text('Leaderboard coming soon...'),
          ],
        ),
      ),
    );
  }
}
