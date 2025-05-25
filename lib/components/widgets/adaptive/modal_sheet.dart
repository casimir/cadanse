import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../shared/target_type.dart';
import '../cupertino/nav_bar.dart';
import 'scaffold.dart';

class ModalSheet extends StatelessWidget {
  const ModalSheet({
    super.key,
    required this.title,
    required this.builder,
    this.backgroundColor,
  }) : _targetType = TargetType.adaptive;

  const ModalSheet.human({
    super.key,
    required this.title,
    required this.builder,
    this.backgroundColor,
  }) : _targetType = TargetType.human;

  const ModalSheet.material({
    super.key,
    required this.title,
    required this.builder,
    this.backgroundColor,
  }) : _targetType = TargetType.material;

  final TargetType _targetType;
  final String title;
  final WidgetBuilder builder;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final effectiveTargetType = _targetType.effectiveType(
      Theme.of(context).platform,
    );
    return effectiveTargetType == TargetType.human
        ? _buildHuman(context)
        : _buildMaterial(context);
  }

  Widget _buildHuman(BuildContext context) {
    return AdaptiveScaffold.human(
      barData: AdaptiveBarData(
        leading: CupertinoNavigationBarCancelButton(
          onPressed: () => CupertinoSheetRoute.popSheet(context),
        ),
        title: Text(title),
      ),
      body: builder(context),
      backgroundColor: backgroundColor,
    );
  }

  Widget _buildMaterial(BuildContext context) {
    // all metrics and styles are taken from the Material 3 spec
    final header = Padding(
      padding: const EdgeInsets.only(left: 16, right: 24, top: 24),
      child: Row(
        children: [_MaterialSheetCloseButton(), _MaterialSheetTitle(title)],
      ),
    );

    return SafeArea(
      bottom: false,
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Container(
          decoration: ShapeDecoration(
            color: Theme.of(context).colorScheme.surface,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(28)),
            ),
          ),
          constraints: const BoxConstraints(maxWidth: 400),
          child: Column(children: [header, Expanded(child: builder(context))]),
        ),
      ),
    );
  }
}

class _MaterialSheetCloseButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.close,
        color: Theme.of(context).colorScheme.onSurfaceVariant,
        semanticLabel: MaterialLocalizations.of(context).closeButtonLabel,
      ),
      onPressed: () => Navigator.of(context).pop(),
    );
  }
}

class _MaterialSheetTitle extends StatelessWidget {
  const _MaterialSheetTitle(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Text(
      title,
      style: theme.textTheme.titleLarge?.copyWith(
        color: theme.colorScheme.onSurfaceVariant,
      ),
    );
  }
}

void showModalSheet({
  required BuildContext context,
  required String title,
  required WidgetBuilder builder,
  Color? backgroundColor,
  TargetPlatform? platformOverride,
}) {
  final platform = platformOverride ?? Theme.of(context).platform;
  if (platform == TargetPlatform.iOS) {
    showCupertinoSheet(
      context: context,
      pageBuilder:
          (context) => ModalSheet.human(
            title: title,
            builder: builder,
            backgroundColor: backgroundColor,
          ),
    );
  } else {
    showModalBottomSheet(
      context: context,
      builder:
          (context) => ModalSheet.material(
            title: title,
            builder: builder,
            backgroundColor: backgroundColor,
          ),
      isScrollControlled: true,
      useSafeArea: true,
    );
  }
}
