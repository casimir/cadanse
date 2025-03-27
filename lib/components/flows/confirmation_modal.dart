import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:macos_ui/macos_ui.dart';

import '../../layout.dart';

enum ConfirmationVariant {
  iosCompact,
  iosLarge,
  macos,
  material;

  factory ConfirmationVariant.from(BuildContext context) {
    final platform = Theme.of(context).platform;
    final isCompact = Layout.isCompact(context);

    return switch (platform) {
      TargetPlatform.iOS => isCompact
          ? ConfirmationVariant.iosCompact
          : ConfirmationVariant.iosLarge,
      TargetPlatform.macOS => ConfirmationVariant.macos,
      _ => ConfirmationVariant.material,
    };
  }
}

class ConfirmationAction {
  const ConfirmationAction({
    required this.title,
    this.icon,
    this.isDestructive = true,
  });

  final String title;
  final Icon? icon;
  final bool isDestructive;
}

/// Asks the user for confirmation before proceeding to a given action using a
/// modal component.
/// By default, this component tries to adhere to the platform's expected behavior.
///
/// A modal bottom sheet is used on compact screens while a dialog is preferred
/// on larger screens.
///
/// The [isDestructiveAction] parameter is used on platforms adhering to the Human
/// Interface Guidelines (iOS, macOS) to style the action accordingly.
///
/// The [overridePlatformType] parameter can be used to force a specific platform
/// variant.
///
/// Returns `true` if the user confirms the action, `false` otherwise.
Future<bool> askForConfirmation({
  required BuildContext context,
  required String title,
  required String message,
  required ConfirmationAction action,
  ConfirmationVariant? overridePlatformType,
}) {
  final platformType =
      overridePlatformType ?? ConfirmationVariant.from(context);
  return switch (platformType) {
    ConfirmationVariant.iosCompact =>
      _showIosCompact(context, title, message, action),
    ConfirmationVariant.iosLarge =>
      _showIosLarge(context, title, message, action),
    ConfirmationVariant.macos => _showMacos(context, title, message, action),
    ConfirmationVariant.material =>
      _showMaterial(context, title, message, action),
  };
}

Future<bool> _showIosCompact(
  BuildContext context,
  String title,
  String message,
  ConfirmationAction action,
) {
  return showCupertinoModalPopup(
    context: context,
    builder: (context) => CupertinoActionSheet(
      title: Text(title),
      message: Text(message),
      actions: [
        CupertinoActionSheetAction(
          isDestructiveAction: action.isDestructive,
          isDefaultAction: !action.isDestructive,
          child: Text(action.title),
          onPressed: () => Navigator.of(context).pop(true),
        )
      ],
      cancelButton: CupertinoActionSheetAction(
        child: Text(MaterialLocalizations.of(context).cancelButtonLabel),
        onPressed: () => Navigator.of(context).pop(false),
      ),
    ),
  ).then(
    (value) => value ?? false,
  );
}

Future<bool> _showIosLarge(
  BuildContext context,
  String title,
  String content,
  ConfirmationAction action,
) {
  return showCupertinoDialog(
    context: context,
    builder: (context) => CupertinoAlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        CupertinoDialogAction(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(MaterialLocalizations.of(context).cancelButtonLabel),
        ),
        CupertinoDialogAction(
          onPressed: () => Navigator.of(context).pop(true),
          isDestructiveAction: action.isDestructive,
          child: Text(action.title),
        ),
      ],
    ),
    barrierDismissible: true,
  ).then((value) => value ?? false);
}

Future<bool> _showMacos(
  BuildContext context,
  String title,
  String message,
  ConfirmationAction action,
) {
  final dialog = MacosAlertDialog(
    appIcon: action.icon ?? const Icon(CupertinoIcons.info),
    title: Text(title),
    message: Text(message),
    primaryButton: PushButton(
      controlSize: ControlSize.large,
      child: Text(action.title),
      onPressed: () => Navigator.of(context).pop(true),
    ),
    secondaryButton: PushButton(
      controlSize: ControlSize.large,
      secondary: true,
      child: Text(MaterialLocalizations.of(context).cancelButtonLabel),
      onPressed: () => Navigator.of(context).pop(false),
    ),
  );

  return showMacosAlertDialog(
    context: context,
    builder: (context) {
      if (MacosTheme.maybeOf(context) != null) {
        return dialog;
      }
      return MacosTheme(
        data: (Theme.of(context).brightness == Brightness.light
            ? MacosThemeData.light()
            : MacosThemeData.dark()),
        child: dialog,
      );
    },
    barrierDismissible: true,
  ).then((value) => value ?? false);
}

Future<bool> _showMaterial(
  BuildContext context,
  String title,
  String content,
  ConfirmationAction action,
) {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      icon: action.icon,
      title: Text(title),
      content: Text(content),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(MaterialLocalizations.of(context).cancelButtonLabel),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: Text(action.title),
        ),
      ],
    ),
  ).then((value) => value ?? false);
}
