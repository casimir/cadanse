import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_down_button/pull_down_button.dart';

enum _TargetType {
  adaptive,
  human,
  material,
}

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

class ActionsMenuButton extends StatelessWidget {
  const ActionsMenuButton({super.key, required this.actions})
      : _targetType = _TargetType.adaptive;

  const ActionsMenuButton.human({super.key, required this.actions})
      : _targetType = _TargetType.human;

  const ActionsMenuButton.material({super.key, required this.actions})
      : _targetType = _TargetType.material;

  final _TargetType _targetType;
  final List<ActionsMenuEntry?> actions;

  @override
  Widget build(BuildContext context) {
    switch (_targetType) {
      case _TargetType.adaptive:
        final platform = Theme.of(context).platform;
        return switch (platform) {
          TargetPlatform.iOS || TargetPlatform.macOS => _buildHuman(),
          _ => _buildMaterial(),
        };
      case _TargetType.human:
        return _buildHuman();
      case _TargetType.material:
        return _buildMaterial();
    }
  }

  Widget _buildHuman() {
    return PullDownButton(
      itemBuilder: (context) => actions
          .map((action) => action != null
              ? PullDownMenuItem(
                  key: action.key,
                  title: action.title,
                  icon: action.icon,
                  onTap: action.onTap,
                  enabled: action.enabled,
                  isDestructive: action.isDestructive,
                )
              : const PullDownMenuDivider.large())
          .cast<PullDownMenuEntry>()
          .toList(),
      buttonBuilder: (context, showMenu) => CupertinoButton(
        onPressed: showMenu,
        padding: EdgeInsets.zero,
        child: const Icon(CupertinoIcons.ellipsis_circle),
      ),
    );
  }

  Widget _buildMaterial() {
    return PopupMenuButton(
      itemBuilder: (context) => actions
          .map((action) => action != null
              ? PopupMenuItem(
                  key: action.key,
                  enabled: action.enabled,
                  child: ListTile(
                    leading: action.icon != null ? Icon(action.icon) : null,
                    title: Text(action.title),
                    onTap: action.onTap,
                  ),
                )
              : const PopupMenuDivider())
          .cast<PopupMenuEntry>()
          .toList(),
    );
  }
}
