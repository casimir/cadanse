import 'package:flutter/material.dart';

import '../../cadanse.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key, required this.error, this.description});

  final Object error;
  final String? description;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const Icon(Icons.error_outline, size: 48.0),
      C.spacers.verticalContent,
      if (description != null)
        Text(description!, style: const TextStyle(fontWeight: FontWeight.bold)),
      if (description != null) C.spacers.verticalContent,
      Text(error.toString(), style: const TextStyle(fontFamily: 'monospace')),
    ]);
  }
}
