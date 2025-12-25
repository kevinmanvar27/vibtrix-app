import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Privacy settings page
class PrivacySettingsPage extends ConsumerStatefulWidget {
  const PrivacySettingsPage({super.key});

  @override
  ConsumerState<PrivacySettingsPage> createState() => _PrivacySettingsPageState();
}

class _PrivacySettingsPageState extends ConsumerState<PrivacySettingsPage> {
  bool _privateAccount = false;
  bool _showActivityStatus = true;
  bool _allowMessages = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy'),
      ),
      body: ListView(
        children: [
          SwitchListTile(
            title: const Text('Private Account'),
            subtitle: const Text('Only approved followers can see your posts'),
            value: _privateAccount,
            onChanged: (value) {
              setState(() => _privateAccount = value);
            },
          ),
          SwitchListTile(
            title: const Text('Activity Status'),
            subtitle: const Text('Show when you\'re online'),
            value: _showActivityStatus,
            onChanged: (value) {
              setState(() => _showActivityStatus = value);
            },
          ),
          SwitchListTile(
            title: const Text('Allow Messages'),
            subtitle: const Text('Let others send you direct messages'),
            value: _allowMessages,
            onChanged: (value) {
              setState(() => _allowMessages = value);
            },
          ),
          const Divider(),
          ListTile(
            title: const Text('Blocked Accounts'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              // TODO: Navigate to blocked accounts
            },
          ),
          ListTile(
            title: const Text('Muted Accounts'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              // TODO: Navigate to muted accounts
            },
          ),
        ],
      ),
    );
  }
}
