import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../shared/target_type.dart';

class AdaptiveBarData {
  const AdaptiveBarData({
    this.key,
    this.title,
    this.leading,
    this.actions,
    this.bottom,
  });

  final Key? key;
  final Widget? title;
  final Widget? leading;
  final List<Widget>? actions;
  final PreferredSizeWidget? bottom;

  AppBar get appBar =>
      AppBar(title: title, leading: leading, actions: actions, bottom: bottom);

  CupertinoNavigationBar get navigationBar => CupertinoNavigationBar(
    middle: title,
    leading: leading,
    trailing:
        actions != null
            ? Row(mainAxisSize: MainAxisSize.min, children: actions!)
            : null,
    bottom: bottom,
  );
}

class AdaptiveScaffold extends StatelessWidget {
  const AdaptiveScaffold({
    super.key,
    this.barData,
    required this.body,
    this.backgroundColor,
  }) : _targetType = TargetType.adaptive;

  const AdaptiveScaffold.human({
    super.key,
    this.barData,
    required this.body,
    this.backgroundColor,
  }) : _targetType = TargetType.human;

  const AdaptiveScaffold.material({
    super.key,
    this.barData,
    required this.body,
    this.backgroundColor,
  }) : _targetType = TargetType.material;

  final TargetType _targetType;
  final AdaptiveBarData? barData;
  final Widget body;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final effectiveTargetType = _targetType.effectiveType(
      Theme.of(context).platform,
    );
    return effectiveTargetType == TargetType.human
        ? CupertinoPageScaffold(
          navigationBar: barData?.navigationBar,
          backgroundColor: backgroundColor,
          child: body,
        )
        : Scaffold(
          appBar: barData?.appBar,
          body: body,
          backgroundColor: backgroundColor,
        );
  }
}
