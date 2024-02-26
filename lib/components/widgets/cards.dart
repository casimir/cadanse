import 'package:flutter/material.dart';

class PaddedCard extends StatelessWidget {
  const PaddedCard({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: child,
      ),
    );
  }
}
