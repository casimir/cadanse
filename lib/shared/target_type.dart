import 'package:flutter/foundation.dart';

enum TargetType {
  adaptive,
  human,
  material;

  TargetType effectiveType(TargetPlatform platform) {
    if (this != adaptive) return this;

    return platform == TargetPlatform.iOS || platform == TargetPlatform.macOS
        ? human
        : material;
  }
}
