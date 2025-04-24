import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../shared/target_type.dart';

/// A button intended to be used for actions in the appbar.
class ActionButton extends StatelessWidget {
  const ActionButton({
    super.key,
    required this.icon,
    this.tooltip,
    required this.onPressed,
  }) : _targetType = TargetType.adaptive;

  const ActionButton.human({
    super.key,
    required this.icon,
    required this.onPressed,
  }) : _targetType = TargetType.human,
       tooltip = null;

  const ActionButton.material({
    super.key,
    required this.icon,
    this.tooltip,
    required this.onPressed,
  }) : _targetType = TargetType.material;

  final TargetType _targetType;
  final IconData icon;
  final String? tooltip;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final effectiveTargetType = _targetType.effectiveType(
      Theme.of(context).platform,
    );
    return effectiveTargetType == TargetType.human
        ? CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: onPressed,
          child: Icon(icon, semanticLabel: tooltip, size: 25.0),
        )
        : IconButton(
          icon: Icon(icon, semanticLabel: tooltip),
          tooltip: tooltip,
          onPressed: onPressed,
        );
  }
}
