import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// User profile page showing user info and their posts
class ProfilePage extends ConsumerWidget {
  final String? userId;
  
  const ProfilePage({
    super.key,
    this.userId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isOwnProfile = userId == null;
    
    return Scaffold(
      appBar: AppBar(
        title: Text(isOwnProfile ? 'My Profile' : 'Profile'),
        actions: isOwnProfile
            ? [
                IconButton(
                  icon: const Icon(Icons.settings_outlined),
                  onPressed: () {
                    // TODO: Navigate to settings
                  },
                ),
              ]
            : [
                IconButton(
                  icon: const Icon(Icons.more_vert),
                  onPressed: () {
                    // TODO: Show profile options
                  },
                ),
              ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 24),
            // Profile picture
            const CircleAvatar(
              radius: 50,
              child: Icon(Icons.person, size: 50),
            ),
            const SizedBox(height: 16),
            // Username
            Text(
              isOwnProfile ? 'Your Username' : 'User $userId',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            // Bio
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 32),
              child: Text(
                'Bio coming soon...',
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 24),
            // Stats row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildStatColumn('Posts', '0'),
                _buildStatColumn('Followers', '0'),
                _buildStatColumn('Following', '0'),
              ],
            ),
            const SizedBox(height: 24),
            // Action buttons
            if (isOwnProfile)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: OutlinedButton(
                  onPressed: () {
                    // TODO: Navigate to edit profile
                  },
                  child: const Text('Edit Profile'),
                ),
              )
            else
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          // TODO: Follow/Unfollow
                        },
                        child: const Text('Follow'),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          // TODO: Message user
                        },
                        child: const Text('Message'),
                      ),
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 32),
            // Posts grid placeholder
            const Center(
              child: Column(
                children: [
                  Icon(Icons.grid_on, size: 48, color: Colors.grey),
                  SizedBox(height: 8),
                  Text('Posts will appear here'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatColumn(String label, String count) {
    return Column(
      children: [
        Text(
          count,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: const TextStyle(color: Colors.grey),
        ),
      ],
    );
  }
}
