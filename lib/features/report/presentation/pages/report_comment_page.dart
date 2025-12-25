import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Page for reporting a comment
class ReportCommentPage extends ConsumerStatefulWidget {
  final String commentId;
  
  const ReportCommentPage({
    super.key,
    required this.commentId,
  });

  @override
  ConsumerState<ReportCommentPage> createState() => _ReportCommentPageState();
}

class _ReportCommentPageState extends ConsumerState<ReportCommentPage> {
  String? _selectedReason;

  final _reasons = [
    'Spam',
    'Harassment',
    'Hate speech',
    'Inappropriate content',
    'Other',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Report Comment'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Why are you reporting this comment?',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          ..._reasons.map((reason) {
            return RadioListTile<String>(
              title: Text(reason),
              value: reason,
              groupValue: _selectedReason,
              onChanged: (value) {
                setState(() => _selectedReason = value);
              },
            );
          }),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: _selectedReason != null
                ? () {
                    // TODO: Submit report
                  }
                : null,
            child: const Text('Submit Report'),
          ),
        ],
      ),
    );
  }
}
