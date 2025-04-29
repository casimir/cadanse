import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptiveIconFactory {
  AdaptiveIconFactory(context) : _platform = Theme.of(context).platform;

  final TargetPlatform _platform;

  bool get _isApple =>
      _platform == TargetPlatform.iOS || _platform == TargetPlatform.macOS;

  IconData get delete => _isApple ? CupertinoIcons.delete : Icons.delete;
  IconData get done => _isApple ? CupertinoIcons.checkmark : Icons.done;
  IconData get info => _isApple ? CupertinoIcons.info : Icons.info_outline;
  IconData get settings =>
      _isApple ? CupertinoIcons.settings : Icons.settings_outlined;
  IconData get share => _isApple ? CupertinoIcons.share : Icons.share;
  IconData get star => _isApple ? CupertinoIcons.star : Icons.star_border;
  IconData get starFilled => _isApple ? CupertinoIcons.star_fill : Icons.star;
}
