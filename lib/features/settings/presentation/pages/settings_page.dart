import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Main settings page with all setting categories
class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          _buildSection(
            context,
            'Account',
            [
              _buildSettingTile(
                Icons.person_outline,
                'Account Settings',
                'Manage your account details',
                () {
                  // TODO: Navigate to account settings
                },
              ),
              _buildSettingTile(
                Icons.lock_outline,
                'Privacy',
                'Control who can see your content',
                () {
                  // TODO: Navigate to privacy settings
                },
              ),
              _buildSettingTile(
                Icons.block_outlined,
                'Blocked Users',
                'Manage blocked accounts',
                () {
                  // TODO: Navigate to blocked users
                },
              ),
            ],
          ),
          _buildSection(
            context,
            'Preferences',
            [
              _buildSettingTile(
                Icons.notifications_outlined,
                'Notifications',
                'Manage notification preferences',
                () {
                  // TODO: Navigate to notification settings
                },
              ),
              _buildSettingTile(
                Icons.palette_outlined,
                'Appearance',
                'Theme and display settings',
                () {
                  // TODO: Navigate to appearance settings
                },
              ),
            ],
          ),
          _buildSection(
            context,
            'Support',
            [
              _buildSettingTile(
                Icons.help_outline,
                'Help & Support',
                'Get help and contact us',
                () {
                  // TODO: Navigate to help
                },
              ),
              _buildSettingTile(
                Icons.info_outline,
                'About',
                'App version and legal info',
                () {
                  // TODO: Navigate to about
                },
              ),
              _buildSettingTile(
                Icons.feedback_outlined,
                'Send Feedback',
                'Help us improve the app',
                () {
                  // TODO: Navigate to feedback
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: OutlinedButton(
              onPressed: () {
                // TODO: Logout
              },
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.red,
              ),
              child: const Text('Log Out'),
            ),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildSection(BuildContext context, String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              color: Colors.grey,
            ),
          ),
        ),
        ...children,
      ],
    );
  }

  Widget _buildSettingTile(
    IconData icon,
    String title,
    String subtitle,
    VoidCallback onTap,
  ) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}
