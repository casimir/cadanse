import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_down_button/pull_down_button.dart';
import '../../../shared/target_type.dart';
import 'buttons.dart';

class ActionsMenuEntry {
  const ActionsMenuEntry({
    this.key,
    required this.title,
    this.icon,
    required this.onTap,
    this.enabled = true,
    this.isDestructive = false,
  });

  final Key? key;
  final String title;
  final IconData? icon;
  final VoidCallback onTap;
  final bool isDestructive;
  final bool enabled;
}

// taken from pull_down_button/src/theme/route_theme.dart
const kBackgroundColor = CupertinoDynamicColor.withBrightness(
  color: Color.fromRGBO(247, 247, 247, 0.8),
  darkColor: Color.fromRGBO(36, 36, 36, 0.75),
);

class ActionsMenuButton extends StatelessWidget {
  const ActionsMenuButton({
    super.key,
    required this.actions,
    this.applyBlurEffect,
  }) : _targetType = TargetType.adaptive;

  const ActionsMenuButton.human({
    super.key,
    required this.actions,
    this.applyBlurEffect,
  }) : _targetType = TargetType.human;

  const ActionsMenuButton.material({super.key, required this.actions})
    : _targetType = TargetType.material,
      applyBlurEffect = false;

  final TargetType _targetType;
  final List<ActionsMenuEntry?> actions;

  /// Used on iOS to determine if the blur effect should be applied to the
  /// pull-down menu. By default, the blur effect is applied.
  ///
  /// Flutter can sometimes struggle with the blur effect in certain contexts,
  /// such as unsupported browsers or when rendering over native components.
  final bool? applyBlurEffect;

  @override
  Widget build(BuildContext context) {
    final effectiveTargetType = _targetType.effectiveType(
      Theme.of(context).platform,
    );
    return effectiveTargetType == TargetType.human
        ? _buildHuman(context)
        : _buildMaterial();
  }

  Widget _buildHuman(BuildContext context) {
    final button = PullDownButton(
      itemBuilder:
          (context) =>
              actions
                  .map(
                    (action) =>
                        action != null
                            ? PullDownMenuItem(
                              key: action.key,
                              title: action.title,
                              icon: action.icon,
                              onTap: action.onTap,
                              enabled: action.enabled,
                              isDestructive: action.isDestructive,
                            )
                            : const PullDownMenuDivider.large(),
                  )
                  .cast<PullDownMenuEntry>()
                  .toList(),
      buttonBuilder:
          (context, showMenu) => ActionButton(
            icon: CupertinoIcons.ellipsis_circle,
            onPressed: showMenu,
          ),
    );

    if (applyBlurEffect ?? true) {
      return button;
    }

    final backgroundColor = kBackgroundColor
        .resolveFrom(context)
        .withAlpha(255);
    return Theme(
      data: Theme.of(context).copyWith(
        extensions: [
          PullDownButtonTheme(
            routeTheme: PullDownMenuRouteTheme(
              backgroundColor: backgroundColor,
            ),
          ),
        ],
      ),
      child: button,
    );
  }

  Widget _buildMaterial() {
    return PopupMenuButton(
      itemBuilder:
          (context) =>
              actions
                  .map(
                    (action) =>
                        action != null
                            ? PopupMenuItem(
                              key: action.key,
                              enabled: action.enabled,
                              onTap: action.onTap,
                              child: ListTile(
                                leading:
                                    action.icon != null
                                        ? Icon(action.icon)
                                        : null,
                                title: Text(action.title),
                              ),
                            )
                            : const PopupMenuDivider(),
                  )
                  .cast<PopupMenuEntry>()
                  .toList(),
    );
  }
}
