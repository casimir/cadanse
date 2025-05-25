import 'package:flutter/cupertino.dart';

/// A wrapper around [CupertinoNavigationBar] that sticks more closely to the
/// Human Interface Guidelines.
///
/// Whereas Material Design preconises the primary color being used for most of
/// interactable elements, HIG is more sparse on its usage and prefers the system
/// accent color for the navigation bar.
class ThemedCupertinoNavigationBar extends StatelessWidget
    implements ObstructingPreferredSizeWidget {
  const ThemedCupertinoNavigationBar({super.key, required this.navigationBar});

  final CupertinoNavigationBar navigationBar;

  @override
  Widget build(BuildContext context) {
    return CupertinoTheme(
      data: const CupertinoThemeData(primaryColor: CupertinoColors.systemBlue),
      child: navigationBar,
    );
  }

  @override
  bool shouldFullyObstruct(BuildContext context) =>
      navigationBar.shouldFullyObstruct(context);

  @override
  Size get preferredSize => navigationBar.preferredSize;
}

class CupertinoNavigationBarCancelButton extends StatelessWidget {
  const CupertinoNavigationBarCancelButton({
    super.key,
    required this.onPressed,
  });

  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    final labelWidget = Align(
      alignment: AlignmentDirectional.centerStart,
      widthFactor: 1.0,
      child: Text(CupertinoLocalizations.of(context).cancelButtonLabel),
    );
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: onPressed,
      child: labelWidget,
    );
  }
}
