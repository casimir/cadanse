import 'package:cadanse/tokens/spacers.dart';
import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key, required this.error, this.description});

  final Exception error;
  final String? description;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const Icon(Icons.error_outline, size: 48.0),
      verticalContentSpacer,
      if (description != null)
        Text(description!, style: const TextStyle(fontWeight: FontWeight.bold)),
      if (description != null) verticalContentSpacer,
      Text(error.toString(), style: const TextStyle(fontFamily: 'monospace')),
    ]);
  }
}
