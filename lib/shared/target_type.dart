import 'package:flutter/foundation.dart';

/// The type of target (Design System) the interface should adapt to.
enum TargetType {
  /// Dynamically determined based on [TargetPlatform].
  adaptive,

  /// Human Guidelines Interface: <https://developer.apple.com/design/human-interface-guidelines/>
  human,

  /// Material Design: <https://m3.material.io/>
  material;

  /// Returns the effective target type based on the current platform.
  ///
  /// When running in a browser, [material] is enforced regardless of [platform].
  TargetType effectiveType(TargetPlatform platform) {
    if (this != adaptive) return this;

    if (kIsWeb) return material;

    return platform == TargetPlatform.iOS || platform == TargetPlatform.macOS
        ? human
        : material;
  }
}
